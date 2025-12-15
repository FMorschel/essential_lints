import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Operator', () {
    test('operator', () {
      expectSortDeclaration(const .operator(.methods));
    });
    group('members', () {
      test('methods', () {
        expectSortDeclaration(const .operator(.methods));
      });
    });
    group('Nullable', () {
      test('methods', () {
        expectSortDeclaration(const .operator(.nullable(.methods)));
      });
    });
  });
}
