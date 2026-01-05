import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Dynamic', () {
    group('members', () {
      test('fields', () {
        expectSortDeclaration(const .dynamic(.fields));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(const .dynamic(.fieldsGettersSetters));
      });
      test('getters', () {
        expectSortDeclaration(const .dynamic(.getters));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .dynamic(.gettersSetters));
      });
      test('methods', () {
        expectSortDeclaration(const .dynamic(.methods));
      });
      test('setters', () {
        expectSortDeclaration(const .dynamic(.setters));
      });
    });
    group('Public', () {
      test('fields', () {
        expectSortDeclaration(const .dynamic(.public(.fields)));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(const .dynamic(.public(.fieldsGettersSetters)));
      });
      test('getters', () {
        expectSortDeclaration(const .dynamic(.public(.getters)));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .dynamic(.public(.gettersSetters)));
      });
      test('methods', () {
        expectSortDeclaration(const .dynamic(.public(.methods)));
      });
      test('setters', () {
        expectSortDeclaration(const .dynamic(.public(.setters)));
      });
    });
    group('Private', () {
      test('fields', () {
        expectSortDeclaration(const .dynamic(.private(.fields)));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(const .dynamic(.private(.fieldsGettersSetters)));
      });
      test('getters', () {
        expectSortDeclaration(const .dynamic(.private(.getters)));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .dynamic(.private(.gettersSetters)));
      });
      test('methods', () {
        expectSortDeclaration(const .dynamic(.private(.methods)));
      });
      test('setters', () {
        expectSortDeclaration(const .dynamic(.private(.setters)));
      });
    });
    group('Initialized', () {
      test('fields', () {
        expectSortDeclaration(const .dynamic(.initialized(.fields)));
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .dynamic(.initialized(.public(.fields))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(
            const .dynamic(.initialized(.private(.fields))),
          );
        });
      });
    });
  });
}
