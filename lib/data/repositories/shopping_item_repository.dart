import 'package:isar_community/isar.dart';
import '../models/shopping_list.dart';
import '../models/shopping_list_item.dart';
import '../models/item_history.dart';
import '../../core/services/notification_service.dart';
import '../../core/utils/quantity_rules.dart';

/// CRUD for items within a specific shopping list.
class ShoppingItemRepository {
  final Isar _isar;
  final NotificationService _notifications;
  const ShoppingItemRepository(this._isar, this._notifications);

  /// Name of the list an item belongs to (for notification bodies).
  Future<String?> _listNameOf(int listId) async =>
      (await _isar.shoppingLists.get(listId))?.name;

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

  /// Reactive stream of every item (in any list) that has a due date.
  /// Powers the calendar overview.
  Stream<List<ShoppingListItem>> watchDatedItems() {
    return _isar.shoppingListItems
        .filter()
        .dueDateIsNotNull()
        .watch(fireImmediately: true);
  }

  Future<ShoppingListItem?> getById(int itemId) =>
      _isar.shoppingListItems.get(itemId);

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
    double quantity = 1,
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

    // Restore learned attributes from history: the last unit the user
    // assigned (unless provided explicitly) and the last remembered price
    // and location ("Olive oil → 7.99 at Lidl"). Remembered, never guessed.
    final history = await _isar.itemHistorys
        .filter()
        .normalizedNameEqualTo(normalized)
        .findFirst();
    final effectiveUnit = unit ?? history?.lastUnit;

    // Keep quantity semantically valid for the effective unit
    // (a restored "mL" must not produce "1 mL" and a 101/201 stepper).
    final effectiveQuantity =
        adjustQuantityForUnitChange(quantity, effectiveUnit);

    final now = DateTime.now();
    final item = ShoppingListItem()
      ..listId = listId
      ..name = name.trim()
      ..normalizedName = normalized
      ..quantity = effectiveQuantity
      ..unit = effectiveUnit
      ..categoryId = categoryId
      ..addedFrom = addedFrom
      ..price = history?.lastPrice
      ..location = history?.lastLocation
      ..createdAt = now
      ..updatedAt = now;

    await _isar.writeTxn(() async {
      await _isar.shoppingListItems.put(item);
    });
    await _updateAddHistory(normalized, name.trim(), categoryId,
        explicitUnit: unit);
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

    // Checked items don't need reminding; unchecking restores a still-valid
    // reminder (scheduleForItem is a no-op for past or disabled reminders).
    if (willBeChecked) {
      await _notifications.cancelForItem(item.id);
    } else if (item.reminderEnabled) {
      await _notifications.scheduleForItem(item,
          listName: await _listNameOf(item.listId));
    }
  }

  // ---------------------------------------------------------------------------
  // Edit
  // ---------------------------------------------------------------------------

  /// [updateSchedule] / [updateExtras] act as "provided" flags so that null
  /// can mean "cleared" for dueDate, price, and location (mirrors the empty-
  /// string sentinel used for [unit]).
  Future<void> updateItem({
    required int itemId,
    String? name,
    double? quantity,
    String? unit,
    int? categoryId,
    bool updateSchedule = false,
    DateTime? dueDate,
    bool hasDueTime = false,
    bool reminderEnabled = false,
    int reminderOffsetMinutes = 0,
    String reminderRepeat = 'none',
    bool updateExtras = false,
    double? price,
    String? location,
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
        // The edited row no longer exists — drop its pending reminder.
        await _notifications.cancelForItem(item.id);
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
      if (updateSchedule) {
        item.dueDate = dueDate;
        item.hasDueTime = dueDate != null && hasDueTime;
        item.reminderEnabled = dueDate != null && reminderEnabled;
        item.reminderOffsetMinutes = reminderOffsetMinutes;
        item.reminderRepeat = reminderRepeat;
      }
      if (updateExtras) {
        item.price = price;
        final loc = location?.trim();
        item.location = (loc == null || loc.isEmpty) ? null : loc;
      }
      item.updatedAt = DateTime.now();
      await _isar.shoppingListItems.put(item);
    });

    // Keep the scheduled notification in lockstep with the stored state.
    // scheduleForItem also handles the cancel cases (reminder disabled,
    // date removed, trigger in the past, item checked).
    if (updateSchedule) {
      await _notifications.scheduleForItem(item,
          listName: await _listNameOf(item.listId));
    }

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

    // Persist category, unit, price, and location overrides to history for
    // future reuse. Price and location are remembered only when non-empty:
    // clearing them on this list item intentionally leaves the previously
    // remembered values intact.
    final rememberPrice = updateExtras && price != null;
    final rememberLocation = updateExtras &&
        location != null &&
        location.trim().isNotEmpty;
    if (categoryId != null ||
        unit != null ||
        rememberPrice ||
        rememberLocation) {
      final history = await _isar.itemHistorys
          .filter()
          .normalizedNameEqualTo(item.normalizedName)
          .findFirst();
      if (history != null) {
        await _isar.writeTxn(() async {
          if (categoryId != null) history.categoryId = categoryId;
          if (unit != null) {
            history.lastUnit = unit.isEmpty ? null : unit;
          }
          if (rememberPrice) history.lastPrice = price;
          if (rememberLocation) history.lastLocation = location.trim();
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
    await _notifications.cancelForItem(itemId);
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
    await _notifications.cancelMany(ids);
    return ids.length;
  }

  /// Delete every item in a list (the list itself is kept).
  Future<void> clearList(int listId) async {
    final ids = await _isar.shoppingListItems
        .filter()
        .listIdEqualTo(listId)
        .idProperty()
        .findAll();
    await _isar.writeTxn(() async {
      await _isar.shoppingListItems.deleteAll(ids);
    });
    await _notifications.cancelMany(ids);
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
      ..dueDate = item.dueDate
      ..hasDueTime = item.hasDueTime
      ..reminderEnabled = item.reminderEnabled
      ..reminderOffsetMinutes = item.reminderOffsetMinutes
      ..reminderRepeat = item.reminderRepeat
      ..price = item.price
      ..location = item.location
      ..createdAt = item.createdAt
      ..updatedAt = DateTime.now();
    await _isar.writeTxn(() async {
      await _isar.shoppingListItems.put(copy);
    });
    // The restored row has a new id — schedule under the new id if needed.
    if (copy.reminderEnabled && !copy.isChecked) {
      await _notifications.scheduleForItem(copy,
          listName: await _listNameOf(copy.listId));
    }
  }

  // ---------------------------------------------------------------------------
  // History helpers
  // ---------------------------------------------------------------------------

  Future<void> _updateAddHistory(
    String normalized,
    String displayName,
    int? categoryId, {
    bool countAsUsage = true,
    String? explicitUnit,
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
        if (explicitUnit != null) existing.lastUnit = explicitUnit;
        await _isar.itemHistorys.put(existing);
      } else {
        final history = ItemHistory()
          ..normalizedName = normalized
          ..displayName = displayName
          ..categoryId = categoryId
          ..lastUnit = explicitUnit
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
