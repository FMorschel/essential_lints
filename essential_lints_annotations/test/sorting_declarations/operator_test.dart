import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Operator', () {
    test('operator', () {
      expectSortDeclaration(const .operator(.methods));
      expectSortDeclaration(const .operator());
    });
    group('members', () {
      test('methods', () {
        expectSortDeclaration(const .operator(.methods));
        expectSortDeclaration(const .operator());
      });
    });
    group('Nullable', () {
      test('methods', () {
        expectSortDeclaration(const .operator(.nullable(.methods)));
        expectSortDeclaration(const .operator(.nullable()));
      });
    });
  });
}
