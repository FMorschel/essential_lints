import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Initialized', () {
    group('members', () {
      test('fields', () {
        expectSortDeclaration(const .initialized(.fields));
      });
    });
    group('Public', () {
      test('fields', () {
        expectSortDeclaration(const .initialized(.public(.fields)));
      });
    });
    group('Private', () {
      test('fields', () {
        expectSortDeclaration(const .initialized(.private(.fields)));
      });
    });
    group('Const', () {
      test('fields', () {
        expectSortDeclaration(const .const_(.initialized(.fields)));
      });
    });
    group('var', () {
      test('fields', () {
        expectSortDeclaration(const .var_(.initialized(.fields)));
      });
    });
    group('final', () {
      test('fields', () {
        expectSortDeclaration(const .final_(.initialized(.fields)));
      });
    });
  });
}
