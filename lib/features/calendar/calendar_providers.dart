import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/shopping_list_item.dart';
import '../../providers/app_providers.dart';
import '../shopping_list/shopping_list_providers.dart';

/// An item with a due date, joined with the name of the list it belongs to.
class DatedItem {
  final ShoppingListItem item;
  final String listName;
  const DatedItem({required this.item, required this.listName});
}

/// Normalizes a DateTime to its calendar day (used as map key).
DateTime dayKey(DateTime d) => DateTime(d.year, d.month, d.day);

/// All items (across every non-archived list) that have a due date,
/// grouped by calendar day. Reacts to both item and list changes.
final datedItemsByDayProvider =
    Provider.autoDispose<AsyncValue<Map<DateTime, List<DatedItem>>>>((ref) {
  final itemsAsync = ref.watch(_datedItemsProvider);
  final listsAsync = ref.watch(orderedListsProvider);

  return itemsAsync.when(
    data: (items) => listsAsync.when(
      data: (lists) {
        final listNames = {for (final l in lists) l.id: l.name};
        final byDay = <DateTime, List<DatedItem>>{};
        for (final item in items) {
          // Skip items whose list is archived or gone.
          final listName = listNames[item.listId];
          if (listName == null) continue;
          byDay
              .putIfAbsent(dayKey(item.dueDate!), () => [])
              .add(DatedItem(item: item, listName: listName));
        }
        // Within a day: timed items first (chronologically), then by name.
        for (final entries in byDay.values) {
          entries.sort((a, b) {
            if (a.item.hasDueTime != b.item.hasDueTime) {
              return a.item.hasDueTime ? -1 : 1;
            }
            if (a.item.hasDueTime && b.item.hasDueTime) {
              final cmp = a.item.dueDate!.compareTo(b.item.dueDate!);
              if (cmp != 0) return cmp;
            }
            return a.item.name.toLowerCase().compareTo(
                  b.item.name.toLowerCase(),
                );
          });
        }
        return AsyncValue.data(byDay);
      },
      loading: () => const AsyncValue.loading(),
      error: (e, st) => AsyncValue.error(e, st),
    ),
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
  );
});

final _datedItemsProvider =
    StreamProvider.autoDispose<List<ShoppingListItem>>((ref) {
  return ref.watch(shoppingItemRepoProvider).watchDatedItems();
});
