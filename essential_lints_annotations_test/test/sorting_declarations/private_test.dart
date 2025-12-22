import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Private', () {
    test('private', () {
      expectSortDeclaration(const .private(.fields));
    });
    group('members', () {
      test('constructors', () {
        expectSortDeclaration(const .private(.constructors));
      });
      test('fields', () {
        expectSortDeclaration(const .private(.fields));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(const .private(.fieldsGettersSetters));
      });
      test('getters', () {
        expectSortDeclaration(const .private(.getters));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .private(.gettersSetters));
      });
      test('methods', () {
        expectSortDeclaration(const .private(.methods));
      });
      test('setters', () {
        expectSortDeclaration(const .private(.setters));
      });
    });
  });
}
