import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/shopping_list.dart';
import '../../core/services/suggestion_service.dart';
import '../../providers/app_providers.dart';

// ---------------------------------------------------------------------------
// Active list metadata (name + item counts for the summary card).
// ---------------------------------------------------------------------------
class ActiveListSummary {
  final ShoppingList list;
  final int totalItems;
  final int checkedItems;

  const ActiveListSummary({
    required this.list,
    required this.totalItems,
    required this.checkedItems,
  });
}

final activeListSummaryProvider =
    StreamProvider.autoDispose<ActiveListSummary?>((ref) {
  final listId = ref.watch(activeListIdProvider);
  if (listId == null) return Stream.value(null);

  final itemRepo = ref.watch(shoppingItemRepoProvider);
  final listRepo = ref.watch(shoppingListRepoProvider);

  return itemRepo.watchByList(listId).asyncMap((items) async {
    final list = await listRepo.getById(listId);
    if (list == null) return null;
    return ActiveListSummary(
      list: list,
      totalItems: items.length,
      checkedItems: items.where((i) => i.isChecked).length,
    );
  });
});

// ---------------------------------------------------------------------------
// Suggestions — recalculated whenever the active list OR the item history
// changes (renames, removals, favorites).
// ---------------------------------------------------------------------------
final historyChangesProvider = StreamProvider.autoDispose<void>((ref) {
  return ref.watch(itemHistoryRepoProvider).watchHistoryChanges();
});

final suggestionsProvider =
    StreamProvider.autoDispose<SuggestionsResult>((ref) {
  // Rebuild (and thus recompute) on every history mutation.
  ref.watch(historyChangesProvider);
  final listId = ref.watch(activeListIdProvider);
  if (listId == null) {
    return Stream.value(const SuggestionsResult(
      pattern: [], frequent: [], favorites: [],
    ));
  }

  final itemRepo = ref.watch(shoppingItemRepoProvider);
  final suggestionService = ref.watch(suggestionServiceProvider);

  return itemRepo.watchByList(listId).asyncMap((items) async {
    final activeNames = items.map((i) => i.normalizedName).toSet();
    return suggestionService.getSuggestions(activeListNames: activeNames);
  });
});
