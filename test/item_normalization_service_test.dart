import 'package:flutter_test/flutter_test.dart';
import 'package:shop_list_pro/core/services/item_normalization_service.dart';

void main() {
  const service = ItemNormalizationService();

  group('normalize', () {
    test('lowercases and trims', () {
      expect(service.normalize('  Milk '), 'milk');
      expect(service.normalize('MILK'), 'milk');
      expect(service.normalize('milk'), 'milk');
    });

    test('same logical item maps to same key', () {
      final keys = {'Milk', 'milk', 'MILK', ' milk  '}
          .map(service.normalize)
          .toSet();
      expect(keys, {'milk'});
    });

    test('blank input returns empty string', () {
      expect(service.normalize('   '), '');
      expect(service.normalize(''), '');
    });
  });

  group('splitMulti', () {
    test('splits on commas', () {
      expect(service.splitMulti('Milk, Bread, Eggs'),
          ['Milk', 'Bread', 'Eggs']);
    });

    test('splits on newlines', () {
      expect(service.splitMulti('Milk\nBread\nEggs\nCoffee'),
          ['Milk', 'Bread', 'Eggs', 'Coffee']);
    });

    test('mixed separators', () {
      expect(service.splitMulti('Milk, Bread\nEggs'),
          ['Milk', 'Bread', 'Eggs']);
    });

    test('ignores empty entries and trims whitespace', () {
      expect(service.splitMulti(' Milk ,, \n , Bread '), ['Milk', 'Bread']);
    });

    test('blank input produces no items', () {
      expect(service.splitMulti('  , \n , '), isEmpty);
      expect(service.splitMulti(''), isEmpty);
    });

    test('single item without separators', () {
      expect(service.splitMulti('Oat milk'), ['Oat milk']);
    });
  });
}
