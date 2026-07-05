import 'package:isar_community/isar.dart';

part 'shopping_item.g.dart';

/// Represents a single item in the active shopping list.
@collection
class ShoppingItem {
  Id id = Isar.autoIncrement;

  late String name;

  @Index()
  late String normalizedName;

  bool isChecked = false;

  late DateTime createdAt;

  late DateTime updatedAt;
}
