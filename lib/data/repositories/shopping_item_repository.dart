import 'package:isar_community/isar.dart';
import '../models/shopping_list_item.dart';
import '../models/item_history.dart';

/// CRUD for items within a specific shopping list.
class ShoppingItemRepository {
  final Isar _isar;
  const ShoppingItemRepository(this._isar);

  // ---------------------------------------------------------------------------
  // Reactive stream — items for a given list.
  // Unchecked items first (by position, then createdAt); checked at bottom.
  // ---------------------------------------------------------------------------
  Stream<List<ShoppingListItem>> watchByList(int listId) {
    return _isar.shoppingListItems
        .filter()
        .listIdEqualTo(listId)
        .watch(fireImmediately: true)
        .map((items) {
      final sorted = [...items];
      sorted.sort((a, b) {
        if (a.isChecked != b.isChecked) return a.isChecked ? 1 : -1;
        final pa = a.position ?? 999999;
        final pb = b.position ?? 999999;
        if (pa != pb) return pa.compareTo(pb);
        return a.createdAt.compareTo(b.createdAt);
      });
      return sorted;
    });
  }

  Future<List<ShoppingListItem>> getByList(int listId) async {
    return _isar.shoppingListItems
        .filter()
        .listIdEqualTo(listId)
        .findAll();
  }

  /// Names currently in the given list (for suggestion filtering).
  Future<Set<String>> currentNormalizedNames(int listId) async {
    final items = await getByList(listId);
    return items.map((i) => i.normalizedName).toSet();
  }

  // ---------------------------------------------------------------------------
  // Add
  // ---------------------------------------------------------------------------

  /// Add a single item to [listId].
  /// If the same normalizedName already exists:
  ///  - checked item → uncheck it (the user needs it again);
  ///  - unchecked item → increment quantity.
  /// Duplicate adds do NOT inflate suggestion history (usage counts).
  /// Returns the item id.
  Future<int> addItem({
    required int listId,
    required String name,
    int quantity = 1,
    String? unit,
    int? categoryId,
    String addedFrom = 'manual',
  }) async {
    final normalized = _normalize(name);
    if (normalized.isEmpty) return -1;

    // Check for existing duplicate in same list
    final existing = await _isar.shoppingListItems
        .filter()
        .listIdEqualTo(listId)
        .and()
        .normalizedNameEqualTo(normalized)
        .findFirst();

    if (existing != null) {
      await _isar.writeTxn(() async {
        if (existing.isChecked) {
          // Re-adding a checked item means "I need it again".
          existing.isChecked = false;
          existing.quantity = quantity;
        } else {
          existing.quantity += quantity;
        }
        existing.updatedAt = DateTime.now();
        await _isar.shoppingListItems.put(existing);
      });
      // Touch recency only — do not inflate usage count for duplicates.
      await _updateAddHistory(normalized, name.trim(), categoryId,
          countAsUsage: false);
      return existing.id;
    }

    final now = DateTime.now();
    final item = ShoppingListItem()
      ..listId = listId
      ..name = name.trim()
      ..normalizedName = normalized
      ..quantity = quantity
      ..unit = unit
      ..categoryId = categoryId
      ..addedFrom = addedFrom
      ..createdAt = now
      ..updatedAt = now;

    await _isar.writeTxn(() async {
      await _isar.shoppingListItems.put(item);
    });
    await _updateAddHistory(normalized, name.trim(), categoryId);
    return item.id;
  }

  /// Multi-add: split on commas and newlines.
  Future<void> addMultiple({
    required int listId,
    required String input,
    int? categoryId,
    String addedFrom = 'manual',
  }) async {
    final parts = input.split(RegExp(r'[,\n]'));
    for (final part in parts) {
      final trimmed = part.trim();
      if (trimmed.isNotEmpty) {
        await addItem(
          listId: listId,
          name: trimmed,
          categoryId: categoryId,
          addedFrom: addedFrom,
        );
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Check / Uncheck
  // ---------------------------------------------------------------------------

  Future<void> toggleCheck(int itemId) async {
    final item = await _isar.shoppingListItems.get(itemId);
    if (item == null) return;

    final willBeChecked = !item.isChecked;
    final now = DateTime.now();

    await _isar.writeTxn(() async {
      item.isChecked = willBeChecked;
      item.updatedAt = now;
      await _isar.shoppingListItems.put(item);
    });

    // Update history only when checking (not unchecking).
    if (willBeChecked) {
      await _updateCheckHistory(item.normalizedName, now);
    }
  }

  // ---------------------------------------------------------------------------
  // Edit
  // ---------------------------------------------------------------------------

  Future<void> updateItem({
    required int itemId,
    String? name,
    int? quantity,
    String? unit,
    int? categoryId,
  }) async {
    final item = await _isar.shoppingListItems.get(itemId);
    if (item == null) return;

    final newName = name?.trim();
    final isRename = newName != null &&
        newName.isNotEmpty &&
        _normalize(newName) != item.normalizedName;

    // If renaming to a name that already exists in this list,
    // merge into the existing row instead of creating a duplicate.
    if (isRename) {
      final clash = await _isar.shoppingListItems
          .filter()
          .listIdEqualTo(item.listId)
          .and()
          .normalizedNameEqualTo(_normalize(newName))
          .findFirst();
      if (clash != null && clash.id != item.id) {
        await _isar.writeTxn(() async {
          clash.quantity += quantity ?? item.quantity;
          clash.isChecked = clash.isChecked && item.isChecked;
          clash.updatedAt = DateTime.now();
          await _isar.shoppingListItems.put(clash);
          await _isar.shoppingListItems.delete(item.id);
        });
        return;
      }
    }

    await _isar.writeTxn(() async {
      if (newName != null && newName.isNotEmpty) {
        item.name = newName;
        item.normalizedName = _normalize(newName);
      }
      if (quantity != null && quantity > 0) item.quantity = quantity;
      if (unit != null) item.unit = unit.isEmpty ? null : unit;
      if (categoryId != null) item.categoryId = categoryId;
      item.updatedAt = DateTime.now();
      await _isar.shoppingListItems.put(item);
    });

    // Make sure the new name is known to history so suggestions and
    // autocomplete pick it up (without inflating usage counts).
    if (isRename) {
      await _updateAddHistory(
        item.normalizedName,
        item.name,
        categoryId ?? item.categoryId,
        countAsUsage: false,
      );
    }

    // Persist category override to history for future reuse.
    if (categoryId != null) {
      final history = await _isar.itemHistorys
          .filter()
          .normalizedNameEqualTo(item.normalizedName)
          .findFirst();
      if (history != null) {
        await _isar.writeTxn(() async {
          history.categoryId = categoryId;
          await _isar.itemHistorys.put(history);
        });
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Delete
  // ---------------------------------------------------------------------------

  Future<void> deleteItem(int itemId) async {
    await _isar.writeTxn(() async {
      await _isar.shoppingListItems.delete(itemId);
    });
  }

  /// Delete all checked items in a list. Returns how many were removed.
  Future<int> clearChecked(int listId) async {
    final ids = await _isar.shoppingListItems
        .filter()
        .listIdEqualTo(listId)
        .and()
        .isCheckedEqualTo(true)
        .idProperty()
        .findAll();
    await _isar.writeTxn(() async {
      await _isar.shoppingListItems.deleteAll(ids);
    });
    return ids.length;
  }

  /// Persist a manual ordering: items get sequential positions.
  Future<void> updatePositions(List<int> orderedItemIds) async {
    await _isar.writeTxn(() async {
      for (var i = 0; i < orderedItemIds.length; i++) {
        final item = await _isar.shoppingListItems.get(orderedItemIds[i]);
        if (item != null) {
          item.position = i;
          await _isar.shoppingListItems.put(item);
        }
      }
    });
  }

  /// Re-insert a previously deleted item (Undo). Does not touch history.
  Future<void> restoreItem(ShoppingListItem item) async {
    final copy = ShoppingListItem()
      ..listId = item.listId
      ..name = item.name
      ..normalizedName = item.normalizedName
      ..quantity = item.quantity
      ..unit = item.unit
      ..categoryId = item.categoryId
      ..isChecked = item.isChecked
      ..position = item.position
      ..addedFrom = item.addedFrom
      ..createdAt = item.createdAt
      ..updatedAt = DateTime.now();
    await _isar.writeTxn(() async {
      await _isar.shoppingListItems.put(copy);
    });
  }

  // ---------------------------------------------------------------------------
  // History helpers
  // ---------------------------------------------------------------------------

  Future<void> _updateAddHistory(
    String normalized,
    String displayName,
    int? categoryId, {
    bool countAsUsage = true,
  }) async {
    final existing = await _isar.itemHistorys
        .filter()
        .normalizedNameEqualTo(normalized)
        .findFirst();

    final now = DateTime.now();
    await _isar.writeTxn(() async {
      if (existing != null) {
        if (countAsUsage) existing.timesAdded += 1;
        existing.lastAddedAt = now;
        existing.displayName = displayName;
        if (categoryId != null) existing.categoryId = categoryId;
        await _isar.itemHistorys.put(existing);
      } else {
        final history = ItemHistory()
          ..normalizedName = normalized
          ..displayName = displayName
          ..categoryId = categoryId
          ..timesAdded = 1
          ..lastAddedAt = now;
        await _isar.itemHistorys.put(history);
      }
    });
  }

  Future<void> _updateCheckHistory(String normalized, DateTime now) async {
    final history = await _isar.itemHistorys
        .filter()
        .normalizedNameEqualTo(normalized)
        .findFirst();
    if (history == null) return;

    await _isar.writeTxn(() async {
      // Incremental average-interval calculation
      if (history.timesChecked >= 1 && history.lastCheckedAt != null) {
        final interval =
            now.difference(history.lastCheckedAt!).inDays.toDouble();
        final prevIntervals = history.timesChecked - 1;
        if (prevIntervals == 0 || history.averageIntervalDays == null) {
          history.averageIntervalDays = interval;
        } else {
          history.averageIntervalDays =
              ((history.averageIntervalDays! * prevIntervals) + interval) /
                  (prevIntervals + 1);
        }
      }

      history.timesChecked += 1;
      history.lastCheckedAt = now;
      await _isar.itemHistorys.put(history);
    });
  }

  String _normalize(String name) => name.toLowerCase().trim();
}
