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

  /// Optional due date. When [hasDueTime] is false, only the calendar day
  /// is meaningful (time component is midnight local).
  @Index()
  DateTime? dueDate;

  /// Whether the user picked a specific time in addition to the date.
  bool hasDueTime = false;

  /// Whether a local reminder notification is scheduled for this item.
  bool reminderEnabled = false;

  /// How long before [dueDate] the reminder should fire, in minutes.
  /// 0 = at the selected time. Only meaningful when [reminderEnabled].
  int reminderOffsetMinutes = 0;

  /// How the reminder repeats: 'none', 'daily', 'weekly', 'monthly',
  /// or 'yearly'. Only meaningful when [reminderEnabled].
  String reminderRepeat = 'none';

  /// Optional price (plain number — no currency is stored).
  double? price;

  /// Optional free-text location ("Lidl", "Aisle 4", …).
  String? location;

  late DateTime createdAt;

  late DateTime updatedAt;
}
