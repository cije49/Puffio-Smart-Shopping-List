import '../../data/models/item_history.dart';
import '../../data/repositories/item_history_repository.dart';

/// Orchestrates suggestion sections for the Home screen.
/// Each item appears in only one section (deduplicated at render time).
/// Priority: pattern → frequent → recent → favorites (always visible).
class SuggestionService {
  final ItemHistoryRepository _historyRepo;
  const SuggestionService(this._historyRepo);

  Future<SuggestionsResult> getSuggestions({
    required Set<String> activeListNames,
  }) async {
    final excluded = {...activeListNames};

    // 1. Pattern-based (highest priority)
    final pattern =
        await _historyRepo.getPatternBased(excludedNames: excluded);
    excluded.addAll(pattern.map((h) => h.normalizedName));

    // 2. Frequent
    final frequent =
        await _historyRepo.getFrequent(excludedNames: excluded);
    excluded.addAll(frequent.map((h) => h.normalizedName));

    // 3. Recent
    final recent = await _historyRepo.getRecent(excludedNames: excluded);
    excluded.addAll(recent.map((h) => h.normalizedName));

    // 4. Favorites (always visible, but still deduplicated)
    final favorites =
        await _historyRepo.getFavorites(excludedNames: excluded);

    return SuggestionsResult(
      pattern: pattern,
      frequent: frequent,
      recent: recent,
      favorites: favorites,
    );
  }
}

class SuggestionsResult {
  final List<ItemHistory> pattern;
  final List<ItemHistory> frequent;
  final List<ItemHistory> recent;
  final List<ItemHistory> favorites;

  const SuggestionsResult({
    required this.pattern,
    required this.frequent,
    required this.recent,
    required this.favorites,
  });

  bool get isEmpty =>
      pattern.isEmpty &&
      frequent.isEmpty &&
      recent.isEmpty &&
      favorites.isEmpty;
}
