import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Public', () {
    test('public', () {
      expectSortDeclaration(const .public(.fields));
    });
    group('members', () {
      test('constructors', () {
        expectSortDeclaration(const .public(.constructors));
      });
      test('fields', () {
        expectSortDeclaration(const .public(.fields));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(const .public(.fieldsGettersSetters));
      });
      test('getters', () {
        expectSortDeclaration(const .public(.getters));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .public(.gettersSetters));
      });
      test('methods', () {
        expectSortDeclaration(const .public(.methods));
      });
      test('setters', () {
        expectSortDeclaration(const .public(.setters));
      });
    });
  });
}
