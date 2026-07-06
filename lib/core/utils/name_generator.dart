/// Deterministic, collision-safe default list names.
///
/// Given base "My List" and existing names (lowercased), returns:
///  - "My List" if free,
///  - otherwise "My List (n)" with the smallest free n ≥ 2 — so gaps are
///    filled first (existing "My List" + "My List (3)" → next is "My List (2)").
String nextUniqueListName(String base, Set<String> existingLowercase) {
  final baseLower = base.toLowerCase();
  if (!existingLowercase.contains(baseLower)) return base;
  var n = 2;
  while (existingLowercase.contains('$baseLower ($n)')) {
    n++;
  }
  return '$base ($n)';
}
