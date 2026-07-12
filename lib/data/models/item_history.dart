import 'package:isar_community/isar.dart';

part 'item_history.g.dart';

/// Exists independently from shopping lists.
/// Updated on every add and check event. Powers all suggestion logic.
@collection
class ItemHistory {
  Id id = Isar.autoIncrement;

  /// Primary key for matching; lowercase, trimmed.
  @Index(unique: true, replace: true)
  late String normalizedName;

  /// Last known display name shown to the user.
  late String displayName;

  /// Last known category id (reused on next addition).
  int? categoryId;

  /// Last unit the user explicitly assigned (reused on next addition).
  /// Never guessed — only set when the user picks a unit themselves.
  String? lastUnit;

  /// Last non-empty price the user entered for this item (reused on next
  /// addition). Only updated by explicit non-empty saves — clearing the
  /// price on one list item does not erase this memory.
  double? lastPrice;

  /// Last non-empty location ("Lidl", "Aisle 4", …) the user entered for
  /// this item (reused on next addition). Same update rule as [lastPrice].
  String? lastLocation;

  /// Total number of times item was added to any list.
  int timesAdded = 0;

  /// Total number of times item was checked as purchased.
  int timesChecked = 0;

  /// Powers "Recent" suggestions.
  DateTime? lastAddedAt;

  /// Anchor date for pattern interval calculation.
  DateTime? lastCheckedAt;

  /// Calculated average days between completed purchases.
  double? averageIntervalDays;

  /// User-pinned flag.
  bool isFavorite = false;
}
