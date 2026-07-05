import 'dart:math' as math;

/// Deterministic frequency + recency score for suggestion ranking.
///
/// - Usage baseline: checks count double (a purchase is a stronger signal
///   than merely adding to a list).
/// - Recency decay: half-life of [halfLifeDays] — an item unused for one
///   half-life is worth 50% of its baseline, two half-lives 25%, etc.
/// - Items never used score 0.
double suggestionScore({
  required int timesAdded,
  required int timesChecked,
  DateTime? lastUsedAt,
  required DateTime now,
  double halfLifeDays = 90,
}) {
  final usage = timesChecked * 2 + timesAdded;
  if (usage <= 0) return 0;
  if (lastUsedAt == null) return usage * 0.01; // unknown recency: heavy penalty
  final days = now.difference(lastUsedAt).inHours / 24.0;
  if (days <= 0) return usage.toDouble();
  final decay = math.pow(0.5, days / halfLifeDays).toDouble();
  return usage * decay;
}
