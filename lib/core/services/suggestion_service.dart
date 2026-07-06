import '../../data/models/item_history.dart';
import '../../data/repositories/item_history_repository.dart';

/// Orchestrates suggestion sections for the Home screen.
/// Each item appears in only one section (deduplicated at render time).
/// Priority: pinned → pattern → frequent, so a starred item is
/// never absorbed into the automatic sections and always surfaces at the
/// top whenever it is not on the active list.
class SuggestionService {
  final ItemHistoryRepository _historyRepo;
  const SuggestionService(this._historyRepo);

  Future<SuggestionsResult> getSuggestions({
    required Set<String> activeListNames,
  }) async {
    final excluded = {...activeListNames};

    // 1. Pinned (user-starred; highest priority)
    final favorites =
        await _historyRepo.getFavorites(excludedNames: excluded);
    excluded.addAll(favorites.map((h) => h.normalizedName));

    // 2. Pattern-based (purchase-interval due)
    final pattern =
        await _historyRepo.getPatternBased(excludedNames: excluded);
    excluded.addAll(pattern.map((h) => h.normalizedName));

    // 3. Suggested for you (frequency + recency score) — recency is part
    // of the score, so recently used items surface here directly.
    final frequent =
        await _historyRepo.getFrequent(excludedNames: excluded);

    return SuggestionsResult(
      pattern: pattern,
      frequent: frequent,
      favorites: favorites,
    );
  }
}

class SuggestionsResult {
  final List<ItemHistory> pattern;
  final List<ItemHistory> frequent;
  final List<ItemHistory> favorites;

  const SuggestionsResult({
    required this.pattern,
    required this.frequent,
    required this.favorites,
  });

  bool get isEmpty =>
      pattern.isEmpty && frequent.isEmpty && favorites.isEmpty;
}
