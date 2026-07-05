import 'package:isar_community/isar.dart';

part 'category.g.dart';

/// Item category for grouping in the active list (e.g. Dairy, Bakery).
@collection
class Category {
  Id id = Isar.autoIncrement;

  late String name;

  /// Display order in the active list.
  int sortOrder = 0;

  /// Reserved for future icon / emoji assignment.
  String? icon;
}
