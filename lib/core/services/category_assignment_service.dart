import '../../data/repositories/item_history_repository.dart';
import '../../data/repositories/category_repository.dart';
import 'category_keywords.dart';

/// Assigns a category to a new item.
/// Order: the user's remembered mapping (history) → local keyword
/// dictionary (EN + HR) → the "Other" fallback. The dictionary is only a
/// first-time default; a category the user picked always wins.
class CategoryAssignmentService {
  final ItemHistoryRepository _historyRepo;
  final CategoryRepository _categoryRepo;

  const CategoryAssignmentService(this._historyRepo, this._categoryRepo);

  Future<int?> assignCategory(String normalizedName) async {
    // 1. Remembered user mapping.
    final history = await _historyRepo.getByNormalizedName(normalizedName);
    if (history != null && history.categoryId != null) {
      return history.categoryId;
    }

    // 2. Offline keyword dictionary.
    final keywordCategory = categoryNameForItem(normalizedName);
    if (keywordCategory != null) {
      final cat = await _categoryRepo.getByName(keywordCategory);
      if (cat != null) return cat.id;
    }

    // 3. Fallback.
    final other = await _categoryRepo.getOther();
    return other?.id;
  }
}
