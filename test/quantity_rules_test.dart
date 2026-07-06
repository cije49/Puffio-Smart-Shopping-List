import 'package:flutter_test/flutter_test.dart';
import 'package:shop_list_pro/core/utils/quantity_rules.dart';

void main() {
  group('quantityStepForUnit', () {
    test('count units step by 1', () {
      expect(quantityStepForUnit(null), 1);
      expect(quantityStepForUnit('pcs'), 1);
      expect(quantityStepForUnit('oz'), 1);
    });

    test('small metric units step by 100', () {
      expect(quantityStepForUnit('g'), 100);
      expect(quantityStepForUnit('mL'), 100);
    });

    test('large units step by 0.5', () {
      expect(quantityStepForUnit('kg'), 0.5);
      expect(quantityStepForUnit('L'), 0.5);
      expect(quantityStepForUnit('lb'), 0.5);
    });
  });

  group('adjustQuantityForUnitChange', () {
    test('1 pc -> mL becomes 100', () {
      expect(adjustQuantityForUnitChange(1, 'mL'), 100);
    });

    test('300 mL -> pcs resets to 1', () {
      expect(adjustQuantityForUnitChange(300, 'pcs'), 1);
    });

    test('300 g -> kg resets to 1', () {
      expect(adjustQuantityForUnitChange(300, 'kg'), 1);
    });

    test('3 pcs -> kg keeps 3', () {
      expect(adjustQuantityForUnitChange(3, 'kg'), 3);
    });

    test('1 pc -> kg keeps 1', () {
      expect(adjustQuantityForUnitChange(1, 'kg'), 1);
    });

    test('200 mL -> g keeps 200', () {
      expect(adjustQuantityForUnitChange(200, 'g'), 200);
    });
  });

  group('restored unit normalization (add flow)', () {
    test('restored mL with default quantity 1 becomes 100', () {
      expect(adjustQuantityForUnitChange(1, 'mL'), 100);
    });

    test('restored g with default quantity 1 becomes 100', () {
      expect(adjustQuantityForUnitChange(1, 'g'), 100);
    });

    test('restored kg with default quantity 1 stays 1 (valid on 0.5 grid)', () {
      expect(adjustQuantityForUnitChange(1, 'kg'), 1);
    });

    test('restored pcs / no unit keeps 1', () {
      expect(adjustQuantityForUnitChange(1, 'pcs'), 1);
      expect(adjustQuantityForUnitChange(1, null), 1);
    });

    test('normalized quantity stays on the unit step grid', () {
      final q = adjustQuantityForUnitChange(1, 'mL');
      final step = quantityStepForUnit('mL');
      expect(q % step, 0); // 100, 200, 300 … never 101, 201
    });
  });

  group('formatQuantity', () {
    test('whole numbers have no decimal point', () {
      expect(formatQuantity(1), '1');
      expect(formatQuantity(300), '300');
    });

    test('halves keep one decimal', () {
      expect(formatQuantity(0.5), '0.5');
      expect(formatQuantity(1.5), '1.5');
    });
  });
}
