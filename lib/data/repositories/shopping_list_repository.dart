import 'package:isar_community/isar.dart';
import '../models/shopping_list.dart';
import '../models/shopping_list_item.dart';
import '../../core/constants.dart';
import '../../core/services/notification_service.dart';
import '../../core/utils/name_generator.dart';

/// CRUD + active-list logic for ShoppingList.
class ShoppingListRepository {
  final Isar _isar;
  final NotificationService _notifications;
  const ShoppingListRepository(this._isar, this._notifications);

  // ---------------------------------------------------------------------------
  // Queries
  // ---------------------------------------------------------------------------

  /// All non-archived lists, most-recently-opened first.
  Stream<List<ShoppingList>> watchAll() {
    return _isar.shoppingLists
        .filter()
        .isArchivedEqualTo(false)
        .sortByLastOpenedAtDesc()
        .watch(fireImmediately: true);
  }

  Future<List<ShoppingList>> getAll() async {
    return _isar.shoppingLists
        .filter()
        .isArchivedEqualTo(false)
        .sortByLastOpenedAtDesc()
        .findAll();
  }

  /// The most-recently-opened, non-archived list (i.e. the "active" list).
  Future<ShoppingList?> getMostRecentList() async {
    return _isar.shoppingLists
        .filter()
        .isArchivedEqualTo(false)
        .sortByLastOpenedAtDesc()
        .findFirst();
  }

  Future<ShoppingList?> getById(int id) => _isar.shoppingLists.get(id);

  // ---------------------------------------------------------------------------
  // Mutations
  // ---------------------------------------------------------------------------

  /// Create a new list and return its id.
  Future<int> createList(String name) async {
    final now = DateTime.now();
    final list = ShoppingList()
      ..name = name.trim()
      ..createdAt = now
      ..updatedAt = now
      ..lastOpenedAt = now;

    await _isar.writeTxn(() async {
      await _isar.shoppingLists.put(list);
    });
    return list.id;
  }

  /// Ensure at least one active list exists. Returns its id.
  /// [defaultName] lets callers pass the localized default ("My List" /
  /// "Moja lista"); falls back to the constant.
  Future<int> ensureActiveList({String? defaultName}) async {
    final existing = await getMostRecentList();
    if (existing != null) return existing.id;
    return createList(defaultName ?? kDefaultListName);
  }

  /// Next collision-free auto-generated name based on [base]
  /// ("My List", "My List (2)", …). Case-insensitive, fills gaps first.
  Future<String> generateUniqueName(String base) async {
    final lists = await getAll();
    final existing =
        lists.map((l) => l.name.trim().toLowerCase()).toSet();
    return nextUniqueListName(base.trim(), existing);
  }

  Future<void> rename(int id, String newName) async {
    final list = await _isar.shoppingLists.get(id);
    if (list == null) return;
    await _isar.writeTxn(() async {
      list.name = newName.trim();
      list.updatedAt = DateTime.now();
      await _isar.shoppingLists.put(list);
    });
  }

  /// Mark as most-recently-opened (makes it "active").
  Future<void> setActive(int id) async {
    final list = await _isar.shoppingLists.get(id);
    if (list == null) return;
    await _isar.writeTxn(() async {
      list.lastOpenedAt = DateTime.now();
      list.updatedAt = DateTime.now();
      await _isar.shoppingLists.put(list);
    });
  }

  /// Duplicate a list: copies all items with isChecked = false.
  Future<int> duplicate(int sourceId) async {
    final source = await _isar.shoppingLists.get(sourceId);
    if (source == null) throw Exception('List not found');

    final items = await _isar.shoppingListItems
        .filter()
        .listIdEqualTo(sourceId)
        .findAll();

    final now = DateTime.now();
    final newList = ShoppingList()
      ..name = '${source.name} (copy)'
      ..createdAt = now
      ..updatedAt = now
      ..lastOpenedAt = now;

    await _isar.writeTxn(() async {
      await _isar.shoppingLists.put(newList);

      for (final item in items) {
        final copy = ShoppingListItem()
          ..listId = newList.id
          ..name = item.name
          ..normalizedName = item.normalizedName
          ..quantity = item.quantity
          ..unit = item.unit
          ..categoryId = item.categoryId
          ..isChecked = false
          ..position = item.position
          ..addedFrom = item.addedFrom
          // Dates, prices, and locations carry over; reminders stay off on
          // the copy so a duplicated list never double-notifies.
          ..dueDate = item.dueDate
          ..hasDueTime = item.hasDueTime
          ..reminderEnabled = false
          ..reminderOffsetMinutes = item.reminderOffsetMinutes
          ..reminderRepeat = item.reminderRepeat
          ..price = item.price
          ..location = item.location
          ..createdAt = now
          ..updatedAt = now;
        await _isar.shoppingListItems.put(copy);
      }
    });

    return newList.id;
  }

  /// Delete a list and its items. If this was the only list,
  /// a new default list is auto-created.
  Future<int> deleteList(int id) async {
    final itemIds = await _isar.shoppingListItems
        .filter()
        .listIdEqualTo(id)
        .idProperty()
        .findAll();

    await _isar.writeTxn(() async {
      await _isar.shoppingListItems.deleteAll(itemIds);
      await _isar.shoppingLists.delete(id);
    });
    await _notifications.cancelMany(itemIds);

    // Guarantee an active list always exists
    return ensureActiveList();
  }

  /// Wipe every list and item.
  Future<void> clearAll() async {
    await _isar.writeTxn(() async {
      await _isar.shoppingLists.clear();
      await _isar.shoppingListItems.clear();
    });
    await _notifications.cancelAll();
  }
}
