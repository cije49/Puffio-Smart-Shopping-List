/// Stateless normalisation used on every add, match, and history update.
class ItemNormalizationService {
  const ItemNormalizationService();

  /// Lowercase + trim. Returns empty string for blank input.
  String normalize(String name) => name.toLowerCase().trim();

  /// Split multi-item input on commas and newlines; discard empties.
  List<String> splitMulti(String input) {
    return input
        .split(RegExp(r'[,\n]'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }
}
