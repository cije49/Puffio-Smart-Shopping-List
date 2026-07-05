import 'dart:convert';
import 'package:isar_community/isar.dart';
import '../../data/models/category.dart';
import '../../data/models/item_history.dart';
import '../../data/models/shopping_list.dart';
import '../../data/models/shopping_list_item.dart';

/// Serializes the full database to JSON and restores it.
/// Import fully replaces existing data (deterministic, no merge surprises).
class BackupService {
  final Isar _isar;
  const BackupService(this._isar);

  static const int formatVersion = 1;

  // ---------------------------------------------------------------------------
  // Export
  // ---------------------------------------------------------------------------

  Future<String> exportToJson() async {
    final lists = await _isar.shoppingLists.where().findAll();
    final items = await _isar.shoppingListItems.where().findAll();
    final history = await _isar.itemHistorys.where().findAll();
    final categories = await _isar.categorys.where().findAll();

    return jsonEncode({
      'formatVersion': formatVersion,
      'exportedAt': DateTime.now().toIso8601String(),
      'categories': categories
          .map((c) => {
                'id': c.id,
                'name': c.name,
                'sortOrder': c.sortOrder,
                'icon': c.icon,
              })
          .toList(),
      'lists': lists
          .map((l) => {
                'id': l.id,
                'name': l.name,
                'createdAt': l.createdAt.toIso8601String(),
                'updatedAt': l.updatedAt.toIso8601String(),
                'lastOpenedAt': l.lastOpenedAt?.toIso8601String(),
                'isArchived': l.isArchived,
              })
          .toList(),
      'items': items
          .map((i) => {
                'listId': i.listId,
                'name': i.name,
                'normalizedName': i.normalizedName,
                'quantity': i.quantity,
                'unit': i.unit,
                'categoryId': i.categoryId,
                'isChecked': i.isChecked,
                'position': i.position,
                'addedFrom': i.addedFrom,
                'createdAt': i.createdAt.toIso8601String(),
                'updatedAt': i.updatedAt.toIso8601String(),
              })
          .toList(),
      'history': history
          .map((h) => {
                'normalizedName': h.normalizedName,
                'displayName': h.displayName,
                'categoryId': h.categoryId,
                'timesAdded': h.timesAdded,
                'timesChecked': h.timesChecked,
                'lastAddedAt': h.lastAddedAt?.toIso8601String(),
                'lastCheckedAt': h.lastCheckedAt?.toIso8601String(),
                'averageIntervalDays': h.averageIntervalDays,
                'isFavorite': h.isFavorite,
              })
          .toList(),
    });
  }

  // ---------------------------------------------------------------------------
  // Import (replace-all)
  // ---------------------------------------------------------------------------

  /// Throws [FormatException] if the payload is not a valid backup.
  Future<void> importFromJson(String jsonString) async {
    final Map<String, dynamic> data;
    try {
      data = jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (_) {
      throw const FormatException('Not valid JSON');
    }
    if (data['formatVersion'] is! int ||
        data['lists'] is! List ||
        data['items'] is! List ||
        data['history'] is! List ||
        data['categories'] is! List) {
      throw const FormatException('Not a Puffio backup');
    }

    DateTime parseDate(Object? v) =>
        v is String ? DateTime.parse(v) : DateTime.now();
    DateTime? parseDateOrNull(Object? v) =>
        v is String ? DateTime.tryParse(v) : null;

    await _isar.writeTxn(() async {
      await _isar.shoppingListItems.clear();
      await _isar.shoppingLists.clear();
      await _isar.itemHistorys.clear();
      await _isar.categorys.clear();

      // Categories (remap old id -> new id)
      final catIdMap = <int, int>{};
      for (final raw in data['categories'] as List) {
        final c = raw as Map<String, dynamic>;
        final cat = Category()
          ..name = c['name'] as String
          ..sortOrder = (c['sortOrder'] as num?)?.toInt() ?? 0
          ..icon = c['icon'] as String?;
        final newId = await _isar.categorys.put(cat);
        if (c['id'] is int) catIdMap[c['id'] as int] = newId;
      }
      int? mapCat(Object? oldId) =>
          oldId is int ? catIdMap[oldId] : null;

      // Lists (remap old id -> new id)
      final listIdMap = <int, int>{};
      for (final raw in data['lists'] as List) {
        final l = raw as Map<String, dynamic>;
        final list = ShoppingList()
          ..name = l['name'] as String? ?? 'List'
          ..createdAt = parseDate(l['createdAt'])
          ..updatedAt = parseDate(l['updatedAt'])
          ..lastOpenedAt = parseDateOrNull(l['lastOpenedAt'])
          ..isArchived = l['isArchived'] as bool? ?? false;
        final newId = await _isar.shoppingLists.put(list);
        if (l['id'] is int) listIdMap[l['id'] as int] = newId;
      }

      // Items
      for (final raw in data['items'] as List) {
        final i = raw as Map<String, dynamic>;
        final newListId = listIdMap[i['listId']];
        if (newListId == null) continue; // orphan
        final name = i['name'] as String?;
        if (name == null || name.trim().isEmpty) continue;
        final item = ShoppingListItem()
          ..listId = newListId
          ..name = name
          ..normalizedName =
              i['normalizedName'] as String? ?? name.toLowerCase().trim()
          ..quantity = (i['quantity'] as num?)?.toInt() ?? 1
          ..unit = i['unit'] as String?
          ..categoryId = mapCat(i['categoryId'])
          ..isChecked = i['isChecked'] as bool? ?? false
          ..position = (i['position'] as num?)?.toInt()
          ..addedFrom = i['addedFrom'] as String? ?? 'manual'
          ..createdAt = parseDate(i['createdAt'])
          ..updatedAt = parseDate(i['updatedAt']);
        await _isar.shoppingListItems.put(item);
      }

      // History
      for (final raw in data['history'] as List) {
        final h = raw as Map<String, dynamic>;
        final normalized = h['normalizedName'] as String?;
        if (normalized == null || normalized.isEmpty) continue;
        final entry = ItemHistory()
          ..normalizedName = normalized
          ..displayName = h['displayName'] as String? ?? normalized
          ..categoryId = mapCat(h['categoryId'])
          ..timesAdded = (h['timesAdded'] as num?)?.toInt() ?? 0
          ..timesChecked = (h['timesChecked'] as num?)?.toInt() ?? 0
          ..lastAddedAt = parseDateOrNull(h['lastAddedAt'])
          ..lastCheckedAt = parseDateOrNull(h['lastCheckedAt'])
          ..averageIntervalDays =
              (h['averageIntervalDays'] as num?)?.toDouble()
          ..isFavorite = h['isFavorite'] as bool? ?? false;
        await _isar.itemHistorys.put(entry);
      }
    });
  }
}
