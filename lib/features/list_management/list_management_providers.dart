import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/shopping_list.dart';
import '../../providers/app_providers.dart';

/// Stream of all non-archived lists.
final allListsProvider = StreamProvider.autoDispose<List<ShoppingList>>((ref) {
  return ref.watch(shoppingListRepoProvider).watchAll();
});
