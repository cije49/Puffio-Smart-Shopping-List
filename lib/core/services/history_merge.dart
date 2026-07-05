import '../../data/models/item_history.dart';

/// Merges [source]'s usage statistics into [target] (mutates target).
/// Used when a history entry is renamed to a name that already exists:
/// the two records must become one without losing signal.
///
/// Rules:
///  - usage counts are summed
///  - the most recent timestamps win
///  - purchase-interval averages are weighted by check count
///  - favorite status is kept if either record had it
///  - target's category wins; source's fills the gap
void mergeHistoryInto(ItemHistory target, ItemHistory source) {
  // Weighted average interval (before counts are combined).
  final tChecks = target.timesChecked;
  final sChecks = source.timesChecked;
  if (target.averageIntervalDays == null) {
    target.averageIntervalDays = source.averageIntervalDays;
  } else if (source.averageIntervalDays != null && tChecks + sChecks > 0) {
    target.averageIntervalDays =
        ((target.averageIntervalDays! * tChecks) +
                (source.averageIntervalDays! * sChecks)) /
            (tChecks + sChecks);
  }

  target.timesAdded += source.timesAdded;
  target.timesChecked += source.timesChecked;

  DateTime? later(DateTime? a, DateTime? b) {
    if (a == null) return b;
    if (b == null) return a;
    return a.isAfter(b) ? a : b;
  }

  target.lastAddedAt = later(target.lastAddedAt, source.lastAddedAt);
  target.lastCheckedAt = later(target.lastCheckedAt, source.lastCheckedAt);
  target.isFavorite = target.isFavorite || source.isFavorite;
  target.categoryId ??= source.categoryId;
}
