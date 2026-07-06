/// Unit-aware quantity behavior. Quantities are stored as double so that
/// 0.5 kg / 1.5 L are representable; whole numbers display without ".0".
library;

/// Step used by the +/- stepper for a given unit.
double quantityStepForUnit(String? unit) {
  switch (unit) {
    case 'g':
    case 'mL':
      return 100; // 100, 200, 300 … practical shopping increments
    case 'kg':
    case 'L':
    case 'lb':
      return 0.5; // 0.5, 1, 1.5, 2 …
    default: // pcs, oz, no unit → simple counting
      return 1;
  }
}

/// Smallest allowed quantity for a given unit.
double minQuantityForUnit(String? unit) => quantityStepForUnit(unit);

/// Sensible starting quantity when a unit is first chosen.
double defaultQuantityForUnit(String? unit) {
  switch (unit) {
    case 'g':
    case 'mL':
      return 100;
    default:
      return 1;
  }
}

/// Adjusts the current quantity when the user switches units, so the
/// number keeps making semantic sense (1 pc → 100 mL; 300 mL → 1 pc).
/// Never guesses a unit — only reacts to the user's explicit choice.
double adjustQuantityForUnitChange(double current, String? newUnit) {
  final min = minQuantityForUnit(newUnit);
  if (current < min) return defaultQuantityForUnit(newUnit);
  // Coming from a small metric unit back to counting: 300 "pcs" is nonsense.
  final step = quantityStepForUnit(newUnit);
  if (step == 1 && current > 20) return 1;
  if (step == 0.5 && current > 20) return 1;
  return current;
}

/// "1", "2", "0.5", "1.5" — no trailing ".0" for whole numbers.
String formatQuantity(double q) =>
    q == q.roundToDouble() ? q.toInt().toString() : q.toString();
