import 'package:flutter_test/flutter_test.dart';
import 'package:shop_list_pro/core/utils/name_generator.dart';

void main() {
  group('nextUniqueListName', () {
    test('base name when free', () {
      expect(nextUniqueListName('My List', {}), 'My List');
    });

    test('appends (2) on first collision', () {
      expect(nextUniqueListName('My List', {'my list'}), 'My List (2)');
    });

    test('increments past existing numbered names', () {
      expect(
        nextUniqueListName('My List', {'my list', 'my list (2)'}),
        'My List (3)',
      );
    });

    test('fills gaps deterministically', () {
      expect(
        nextUniqueListName('My List', {'my list', 'my list (3)'}),
        'My List (2)',
      );
    });

    test('case-insensitive collision detection', () {
      expect(nextUniqueListName('My List', {'MY LIST'.toLowerCase()}),
          'My List (2)');
    });

    test('works with Croatian base name', () {
      expect(
        nextUniqueListName('Moja lista', {'moja lista', 'moja lista (2)'}),
        'Moja lista (3)',
      );
    });

    test('manually created similar names do not break generation', () {
      expect(
        nextUniqueListName('My List', {'my list', 'my list (2b)', 'my listx'}),
        'My List (2)',
      );
    });
  });
}
