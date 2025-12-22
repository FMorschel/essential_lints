import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('member', () {
    test('constructor', () {
      expectSortDeclaration(const .constructor());
      expectSortDeclaration(const .constructor(#test));
    });
    test('field', () {
      expectSortDeclaration(const .field(#test));
    });
    test('getter', () {
      expectSortDeclaration(const .getter(#test));
    });
    test('method', () {
      expectSortDeclaration(const .method(#test));
    });
    test('setter', () {
      expectSortDeclaration(const .setter(#test));
    });
  });
}
