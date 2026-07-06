import 'package:isar_community/isar.dart';

part 'shopping_list_item.g.dart';

/// A single item belonging to a ShoppingList.
@collection
class ShoppingListItem {
  Id id = Isar.autoIncrement;

  /// Foreign key → ShoppingList.id
  @Index()
  late int listId;

  late String name;

  @Index()
  late String normalizedName;

  /// Optional quantity; defaults to 1. Double so that 0.5 kg / 1.5 L work.
  double quantity = 1;

  /// Optional unit: pcs, kg, L, etc.
  String? unit;

  /// Foreign key → Category.id (nullable; "Other" when null).
  int? categoryId;

  bool isChecked = false;

  /// Manual sort order within unchecked items (nullable).
  int? position;

  /// How the item was added: manual, chip, recent, favorite, pattern.
  String addedFrom = 'manual';

  late DateTime createdAt;

  late DateTime updatedAt;
}
