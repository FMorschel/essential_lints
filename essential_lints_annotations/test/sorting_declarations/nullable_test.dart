import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Nullable', () {
    test('nullable', () {
      expectSortDeclaration(const .nullable(.fields));
    });
    group('members', () {
      test('fields', () {
        expectSortDeclaration(const .nullable(.fields));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(const .nullable(.fieldsGettersSetters));
      });
      test('getters', () {
        expectSortDeclaration(const .nullable(.getters));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .nullable(.gettersSetters));
      });
      test('methods', () {
        expectSortDeclaration(const .nullable(.methods));
      });
      test('setters', () {
        expectSortDeclaration(const .nullable(.setters));
      });
    });
    group('Public', () {
      test('fields', () {
        expectSortDeclaration(const .nullable(.public(.fields)));
      });
      test('getters', () {
        expectSortDeclaration(const .nullable(.public(.getters)));
      });
      test('setters', () {
        expectSortDeclaration(const .nullable(.public(.setters)));
      });
      test('methods', () {
        expectSortDeclaration(const .nullable(.public(.methods)));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .nullable(.public(.gettersSetters)));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(const .nullable(.public(.fieldsGettersSetters)));
      });
    });
    group('Private', () {
      test('fields', () {
        expectSortDeclaration(const .nullable(.private(.fields)));
      });
      test('getters', () {
        expectSortDeclaration(const .nullable(.private(.getters)));
      });
      test('setters', () {
        expectSortDeclaration(const .nullable(.private(.setters)));
      });
      test('methods', () {
        expectSortDeclaration(const .nullable(.private(.methods)));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .nullable(.private(.gettersSetters)));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(const .nullable(.private(.fieldsGettersSetters)));
      });
    });
    group('Initialized', () {
      test('fields', () {
        expectSortDeclaration(const .nullable(.initialized(.fields)));
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(
            const .nullable(.initialized(.public(.fields))),
          );
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(
            const .nullable(.initialized(.private(.fields))),
          );
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(
            const .nullable(.initialized(.nullable(.fields))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .nullable(.initialized(.nullable(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .nullable(.initialized(.nullable(.private(.fields)))),
            );
          });
        });
      });
    });
  });
}
