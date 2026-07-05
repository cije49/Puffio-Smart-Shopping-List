import '../../data/repositories/item_history_repository.dart';
import '../../data/repositories/category_repository.dart';

/// Assigns a category to a new item based on history or falls back to "Other".
class CategoryAssignmentService {
  final ItemHistoryRepository _historyRepo;
  final CategoryRepository _categoryRepo;

  const CategoryAssignmentService(this._historyRepo, this._categoryRepo);

  /// Look up the last-known categoryId for [normalizedName].
  /// Falls back to the "Other" category if no history exists.
  Future<int?> assignCategory(String normalizedName) async {
    final history = await _historyRepo.getByNormalizedName(normalizedName);
    if (history != null && history.categoryId != null) {
      return history.categoryId;
    }
    final other = await _categoryRepo.getOther();
    return other?.id;
  }
}
