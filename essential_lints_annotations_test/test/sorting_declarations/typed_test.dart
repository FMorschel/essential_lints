import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Typed', () {
    group('members', () {
      test('fields', () {
        expectSortDeclaration(const .typed(.fields));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(const .typed(.fieldsGettersSetters));
      });
      test('getters', () {
        expectSortDeclaration(const .typed(.getters));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .typed(.gettersSetters));
      });
      test('methods', () {
        expectSortDeclaration(const .typed(.methods));
      });
      test('setters', () {
        expectSortDeclaration(const .typed(.setters));
      });
    });
    group('Public', () {
      test('fields', () {
        expectSortDeclaration(const .typed(.public(.fields)));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(const .typed(.public(.fieldsGettersSetters)));
      });
      test('getters', () {
        expectSortDeclaration(const .typed(.public(.getters)));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .typed(.public(.gettersSetters)));
      });
      test('methods', () {
        expectSortDeclaration(const .typed(.public(.methods)));
      });
      test('setters', () {
        expectSortDeclaration(const .typed(.public(.setters)));
      });
    });
    group('Private', () {
      test('fields', () {
        expectSortDeclaration(const .typed(.private(.fields)));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(const .typed(.private(.fieldsGettersSetters)));
      });
      test('getters', () {
        expectSortDeclaration(const .typed(.private(.getters)));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .typed(.private(.gettersSetters)));
      });
      test('methods', () {
        expectSortDeclaration(const .typed(.private(.methods)));
      });
      test('setters', () {
        expectSortDeclaration(const .typed(.private(.setters)));
      });
    });
    group('Nullable', () {
      test('fields', () {
        expectSortDeclaration(const .typed(.nullable(.fields)));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(const .typed(.nullable(.fieldsGettersSetters)));
      });
      test('getters', () {
        expectSortDeclaration(const .typed(.nullable(.getters)));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .typed(.nullable(.gettersSetters)));
      });
      test('methods', () {
        expectSortDeclaration(const .typed(.nullable(.methods)));
      });
      test('setters', () {
        expectSortDeclaration(const .typed(.nullable(.setters)));
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .typed(.nullable(.public(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .typed(.nullable(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .typed(.nullable(.public(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .typed(.nullable(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .typed(.nullable(.public(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .typed(.nullable(.public(.setters))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .typed(.nullable(.private(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .typed(.nullable(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .typed(.nullable(.private(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .typed(.nullable(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .typed(.nullable(.private(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .typed(.nullable(.private(.setters))));
        });
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(const .typed(.nullable(.initialized(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .typed(.nullable(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .typed(.nullable(.initialized(.private(.fields)))),
            );
          });
        });
      });
    });
    group('Initialized', () {
      test('fields', () {
        expectSortDeclaration(const .typed(.initialized(.fields)));
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .typed(.initialized(.public(.fields))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .typed(.initialized(.private(.fields))));
        });
      });
    });
  });
}
