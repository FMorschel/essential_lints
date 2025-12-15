import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Var', () {
    test('var_', () {
      expectSortDeclaration(const .var_(.fields));
    });
    group('members', () {
      test('fields', () {
        expectSortDeclaration(const .var_(.fields));
      });
    });
    group('Public', () {
      test('fields', () {
        expectSortDeclaration(const .var_(.public(.fields)));
      });
    });
    group('Private', () {
      test('fields', () {
        expectSortDeclaration(const .var_(.private(.fields)));
      });
    });
    group('Initialized', () {
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .var_(.initialized(.public(.fields))));
        });
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .var_(.initialized(.fields)));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .var_(.initialized(.private(.fields))));
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(const .var_(.initialized(.nullable(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .var_(.initialized(.nullable(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .var_(.initialized(.nullable(.private(.fields)))),
            );
          });
        });
      });
    });
  });
}
