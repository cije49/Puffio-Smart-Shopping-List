import 'package:isar_community/isar.dart';
import '../models/category.dart';
import '../../core/constants.dart';

/// Category CRUD + first-launch seeding.
class CategoryRepository {
  final Isar _isar;
  const CategoryRepository(this._isar);

  /// Seed default categories if the table is empty (first launch).
  Future<void> seedDefaults() async {
    final count = await _isar.categorys.count();
    if (count > 0) return;

    await _isar.writeTxn(() async {
      for (final c in kDefaultCategories) {
        final cat = Category()
          ..name = c['name'] as String
          ..sortOrder = c['sortOrder'] as int;
        await _isar.categorys.put(cat);
      }
    });
  }

  /// All categories sorted by sortOrder.
  Future<List<Category>> getAll() async {
    return _isar.categorys.where().sortBySortOrder().findAll();
  }

  Stream<List<Category>> watchAll() {
    return _isar.categorys
        .where()
        .sortBySortOrder()
        .watch(fireImmediately: true);
  }

  Future<Category?> getById(int id) => _isar.categorys.get(id);

  /// Find the "Other" fallback category.
  Future<Category?> getOther() async {
    return _isar.categorys
        .filter()
        .nameEqualTo('Other')
        .findFirst();
  }

  Future<void> clearAll() async {
    await _isar.writeTxn(() async {
      await _isar.categorys.clear();
    });
  }
}
