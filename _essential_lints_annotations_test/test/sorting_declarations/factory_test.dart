import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Factory', () {
    test('factory_', () {
      expectSortDeclaration(const .factory_(.constructors));
    });
    group('members', () {
      test('constructors', () {
        expectSortDeclaration(const .factory_(.constructors));
      });
    });
    group('Public', () {
      test('constructors', () {
        expectSortDeclaration(const .factory_(.public(.constructors)));
      });
    });
    group('Private', () {
      test('constructors', () {
        expectSortDeclaration(const .factory_(.private(.constructors)));
      });
    });
    group('Unnamed', () {
      test('constructors', () {
        expectSortDeclaration(const .factory_(.unnamed(.constructors)));
      });
    });
    group('Named', () {
      test('constructors', () {
        expectSortDeclaration(const .factory_(.named(.constructors)));
      });
      group('Public', () {
        test('constructors', () {
          expectSortDeclaration(
            const .factory_(.named(.public(.constructors))),
          );
        });
      });
      group('Private', () {
        test('constructors', () {
          expectSortDeclaration(
            const .factory_(.named(.private(.constructors))),
          );
        });
      });
    });
    group('Redirecting', () {
      test('constructors', () {
        expectSortDeclaration(const .factory_(.redirecting(.constructors)));
      });
      group('Public', () {
        test('constructors', () {
          expectSortDeclaration(
            const .factory_(.redirecting(.public(.constructors))),
          );
        });
      });
      group('Private', () {
        test('constructors', () {
          expectSortDeclaration(
            const .factory_(.redirecting(.private(.constructors))),
          );
        });
      });
      group('Unnamed', () {
        test('constructors', () {
          expectSortDeclaration(
            const .factory_(.redirecting(.unnamed(.constructors))),
          );
        });
      });
      group('Named', () {
        test('constructors', () {
          expectSortDeclaration(
            const .factory_(.redirecting(.named(.constructors))),
          );
        });
        group('Public', () {
          test('constructors', () {
            expectSortDeclaration(
              const .factory_(.redirecting(.named(.public(.constructors)))),
            );
          });
        });
        group('Private', () {
          test('constructors', () {
            expectSortDeclaration(
              const .factory_(.redirecting(.named(.private(.constructors)))),
            );
          });
        });
      });
    });
  });
}
