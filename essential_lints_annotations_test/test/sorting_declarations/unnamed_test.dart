import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Unnamed', () {
    test('unnamed', () {
      expectSortDeclaration(const .unnamed(.constructors));
    });
    group('members', () {
      test('constructors', () {
        expectSortDeclaration(const .unnamed(.constructors));
      });
    });
  });
}
