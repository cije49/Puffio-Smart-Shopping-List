import 'package:flutter_test/flutter_test.dart';
import 'package:shop_list_pro/core/services/category_keywords.dart';

void main() {
  group('categoryNameForItem', () {
    test('exact English matches', () {
      expect(categoryNameForItem('milk'), 'Dairy');
      expect(categoryNameForItem('bread'), 'Bakery');
      expect(categoryNameForItem('chicken'), 'Meat & Fish');
      expect(categoryNameForItem('detergent'), 'Household');
    });

    test('exact Croatian matches, with and without diacritics', () {
      expect(categoryNameForItem('mlijeko'), 'Dairy');
      expect(categoryNameForItem('kruh'), 'Bakery');
      expect(categoryNameForItem('rajčica'), 'Vegetables');
      expect(categoryNameForItem('rajcica'), 'Vegetables');
      expect(categoryNameForItem('šećer'), 'Pantry');
      expect(categoryNameForItem('secer'), 'Pantry');
    });

    test('word-level match inside longer names', () {
      expect(categoryNameForItem('oat milk'), 'Dairy');
      expect(categoryNameForItem('whole wheat bread'), 'Bakery');
      expect(categoryNameForItem('domaći kruh'), 'Bakery');
    });

    test('multi-word full-name match', () {
      expect(categoryNameForItem('pasta za zube'), 'Household');
    });

    test('common Croatian spelling variants map like the correct form', () {
      expect(categoryNameForItem('mlijeko'), 'Dairy');
      expect(categoryNameForItem('mljeko'), 'Dairy');
      expect(categoryNameForItem('mliko'), 'Dairy');
      expect(categoryNameForItem('mljeko za kavu'), 'Dairy');
    });

    test('diacritic folding matches diacritic-only keys', () {
      // 'šunka' exists with diacritics; folded input must still match…
      expect(categoryNameForItem('sunka'), 'Meat & Fish');
      // …and diacritic input must match even where only the plain key exists.
      expect(categoryNameForItem('čips'), 'Snacks');
    });

    test('English keywords unaffected by folding', () {
      expect(categoryNameForItem('milk'), 'Dairy');
      expect(categoryNameForItem('cheese'), 'Dairy');
      expect(categoryNameForItem('toilet paper'), 'Household');
    });

    test('unknown items return null (no guessing)', () {
      expect(categoryNameForItem('mystery gadget'), isNull);
      expect(categoryNameForItem(''), isNull);
    });

    test('deterministic', () {
      expect(categoryNameForItem('banana'), categoryNameForItem('banana'));
    });
  });
}
