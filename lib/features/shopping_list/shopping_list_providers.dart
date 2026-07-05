import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/shopping_list.dart';
import '../../data/models/shopping_list_item.dart';
import '../../data/models/category.dart';
import '../../providers/app_providers.dart';

/// All lists sorted by creation date (stable order for the swipe strip).
final orderedListsProvider = StreamProvider<List<ShoppingList>>((ref) {
  return ref.watch(shoppingListRepoProvider).watchAll().map((lists) {
    final sorted = List<ShoppingList>.from(lists);
    sorted.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return sorted;
  });
});

/// Stream of items for the active list.
final activeListItemsProvider =
    StreamProvider.autoDispose<List<ShoppingListItem>>((ref) {
  final listId = ref.watch(activeListIdProvider);
  if (listId == null) return Stream.value([]);
  return ref.watch(shoppingItemRepoProvider).watchByList(listId);
});

/// Active list metadata.
final activeListMetaProvider =
    FutureProvider.autoDispose<ShoppingList?>((ref) {
  final listId = ref.watch(activeListIdProvider);
  if (listId == null) return null;
  return ref.watch(shoppingListRepoProvider).getById(listId);
});

/// All categories (for grouping and the edit modal dropdown).
final categoriesProvider = StreamProvider<List<Category>>((ref) {
  return ref.watch(categoryRepoProvider).watchAll();
});

/// Items grouped by category.
/// Returns a map of categoryId → List<ShoppingListItem>, sorted by
/// the category's sortOrder.
class GroupedItems {
  final List<CategoryGroup> groups;
  const GroupedItems(this.groups);
}

class CategoryGroup {
  final Category? category;
  final List<ShoppingListItem> items;
  const CategoryGroup({this.category, required this.items});
}

final groupedItemsProvider =
    Provider.autoDispose<AsyncValue<GroupedItems>>((ref) {
  final itemsAsync = ref.watch(activeListItemsProvider);
  final catsAsync = ref.watch(categoriesProvider);

  return itemsAsync.when(
    data: (items) => catsAsync.when(
      data: (categories) {
        final catMap = {for (final c in categories) c.id: c};

        // Group unchecked items by category
        final unchecked = items.where((i) => !i.isChecked).toList();
        final checked = items.where((i) => i.isChecked).toList();

        final Map<int?, List<ShoppingListItem>> grouped = {};
        for (final item in unchecked) {
          grouped.putIfAbsent(item.categoryId, () => []).add(item);
        }

        // Sort groups by category sortOrder
        final sortedKeys = grouped.keys.toList()
          ..sort((a, b) {
            final ca = a != null ? catMap[a] : null;
            final cb = b != null ? catMap[b] : null;
            return (ca?.sortOrder ?? 999).compareTo(cb?.sortOrder ?? 999);
          });

        final groups = <CategoryGroup>[];
        for (final key in sortedKeys) {
          groups.add(CategoryGroup(
            category: key != null ? catMap[key] : null,
            items: grouped[key]!,
          ));
        }

        // Add checked items as a separate group at the bottom
        if (checked.isNotEmpty) {
          groups.add(CategoryGroup(
            category: null,
            items: checked,
          ));
        }

        return AsyncValue.data(GroupedItems(groups));
      },
      loading: () => const AsyncValue.loading(),
      error: (e, st) => AsyncValue.error(e, st),
    ),
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
  );
});
