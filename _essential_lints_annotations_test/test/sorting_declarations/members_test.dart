import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('members', () {
    test('constructors', () {
      expectSortDeclaration(.constructors);
    });
    test('fields', () {
      expectSortDeclaration(.fields);
    });
    test('fieldsGettersSetters', () {
      expectSortDeclaration(.fieldsGettersSetters);
    });
    test('getters', () {
      expectSortDeclaration(.getters);
    });
    test('gettersSetters', () {
      expectSortDeclaration(.gettersSetters);
    });
    test('methods', () {
      expectSortDeclaration(.methods);
    });
    test('setters', () {
      expectSortDeclaration(.setters);
    });
  });
}
