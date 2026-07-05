import 'package:isar_community/isar.dart';

part 'shopping_list.g.dart';

/// A named shopping list. The app supports multiple lists;
/// exactly one is "active" at any time (the most recently opened).
@collection
class ShoppingList {
  Id id = Isar.autoIncrement;

  late String name;

  late DateTime createdAt;

  late DateTime updatedAt;

  /// Used to determine the active list (most recent wins).
  DateTime? lastOpenedAt;

  /// Soft-delete flag; archived lists are hidden but history is preserved.
  bool isArchived = false;
}
