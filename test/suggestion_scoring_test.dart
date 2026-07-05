import 'package:flutter_test/flutter_test.dart';
import 'package:shop_list_pro/core/services/suggestion_scoring.dart';

void main() {
  final now = DateTime(2026, 7, 4);

  double score({
    int added = 0,
    int checked = 0,
    int? daysAgo,
  }) =>
      suggestionScore(
        timesAdded: added,
        timesChecked: checked,
        lastUsedAt:
            daysAgo == null ? null : now.subtract(Duration(days: daysAgo)),
        now: now,
      );

  group('suggestionScore', () {
    test('never-used items score 0', () {
      expect(score(), 0);
      expect(score(daysAgo: 5), 0);
    });

    test('checks weigh more than adds', () {
      expect(score(checked: 5, daysAgo: 0),
          greaterThan(score(added: 5, daysAgo: 0)));
    });

    test('used today scores full usage weight', () {
      expect(score(added: 3, checked: 2, daysAgo: 0), 7.0);
    });

    test('half-life: 90 days halves the score', () {
      final fresh = score(checked: 10, daysAgo: 0);
      final old = score(checked: 10, daysAgo: 90);
      expect(old, closeTo(fresh / 2, 0.01));
    });

    test('recent moderate use beats ancient heavy use', () {
      final coffeeYesterday = score(checked: 3, daysAgo: 1);
      final riceLastYear = score(checked: 20, daysAgo: 365);
      expect(coffeeYesterday, greaterThan(riceLastYear));
    });

    test('unknown recency is heavily penalized but nonzero', () {
      final s = score(added: 10);
      expect(s, greaterThan(0));
      expect(s, lessThan(score(added: 10, daysAgo: 365)));
    });

    test('deterministic: same inputs give same score', () {
      expect(score(added: 4, checked: 7, daysAgo: 12),
          score(added: 4, checked: 7, daysAgo: 12));
    });
  });
}
