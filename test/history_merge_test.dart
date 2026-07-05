import 'package:flutter_test/flutter_test.dart';
import 'package:shop_list_pro/core/services/history_merge.dart';
import 'package:shop_list_pro/data/models/item_history.dart';

ItemHistory h({
  String name = 'milk',
  int added = 0,
  int checked = 0,
  DateTime? lastAdded,
  DateTime? lastChecked,
  double? interval,
  bool favorite = false,
  int? categoryId,
}) {
  return ItemHistory()
    ..normalizedName = name
    ..displayName = name
    ..timesAdded = added
    ..timesChecked = checked
    ..lastAddedAt = lastAdded
    ..lastCheckedAt = lastChecked
    ..averageIntervalDays = interval
    ..isFavorite = favorite
    ..categoryId = categoryId;
}

void main() {
  group('mergeHistoryInto', () {
    test('usage counts are summed', () {
      final target = h(added: 3, checked: 2);
      mergeHistoryInto(target, h(added: 5, checked: 4));
      expect(target.timesAdded, 8);
      expect(target.timesChecked, 6);
    });

    test('most recent timestamps win', () {
      final older = DateTime(2026, 1, 1);
      final newer = DateTime(2026, 6, 1);
      final target = h(lastAdded: older, lastChecked: newer);
      mergeHistoryInto(target, h(lastAdded: newer, lastChecked: older));
      expect(target.lastAddedAt, newer);
      expect(target.lastCheckedAt, newer);
    });

    test('null timestamps are filled from the other record', () {
      final date = DateTime(2026, 3, 1);
      final target = h();
      mergeHistoryInto(target, h(lastAdded: date, lastChecked: date));
      expect(target.lastAddedAt, date);
      expect(target.lastCheckedAt, date);
    });

    test('favorite survives merge from either side', () {
      final a = h(favorite: false);
      mergeHistoryInto(a, h(favorite: true));
      expect(a.isFavorite, isTrue);

      final b = h(favorite: true);
      mergeHistoryInto(b, h(favorite: false));
      expect(b.isFavorite, isTrue);
    });

    test('interval is check-weighted average', () {
      // target: 4 checks at 10-day interval; source: 1 check at 5 days
      final target = h(checked: 4, interval: 10);
      mergeHistoryInto(target, h(checked: 1, interval: 5));
      expect(target.averageIntervalDays, closeTo(9.0, 0.001));
    });

    test('interval falls back to the non-null side', () {
      final target = h(checked: 2);
      mergeHistoryInto(target, h(checked: 3, interval: 7));
      expect(target.averageIntervalDays, 7);

      final target2 = h(checked: 2, interval: 4);
      mergeHistoryInto(target2, h(checked: 3));
      expect(target2.averageIntervalDays, 4);
    });

    test("target's category wins; source fills the gap", () {
      final target = h(categoryId: 1);
      mergeHistoryInto(target, h(categoryId: 2));
      expect(target.categoryId, 1);

      final target2 = h();
      mergeHistoryInto(target2, h(categoryId: 2));
      expect(target2.categoryId, 2);
    });
  });
}
