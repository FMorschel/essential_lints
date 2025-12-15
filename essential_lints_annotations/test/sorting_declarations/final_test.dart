import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Final', () {
    test('final_', () {
      expectSortDeclaration(const .final_(.fields));
    });
    group('members', () {
      test('fields', () {
        expectSortDeclaration(const .final_(.fields));
      });
    });
    group('Initialized', () {
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .final_(.initialized(.public(.fields))));
        });
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .final_(.initialized(.fields)));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(
            const .final_(.initialized(.private(.fields))),
          );
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(
            const .final_(.initialized(.nullable(.fields))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .final_(.initialized(.nullable(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .final_(.initialized(.nullable(.private(.fields)))),
            );
          });
        });
      });
    });
    group('Public', () {
      test('fields', () {
        expectSortDeclaration(const .final_(.public(.fields)));
      });
    });
    group('Private', () {
      test('fields', () {
        expectSortDeclaration(const .final_(.private(.fields)));
      });
    });
    group('Nullable', () {
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .final_(.nullable(.public(.fields))));
        });
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .final_(.nullable(.fields)));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .final_(.nullable(.private(.fields))));
        });
      });
      group('Initialized', () {
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .final_(.nullable(.initialized(.public(.fields)))),
            );
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .final_(.nullable(.initialized(.fields))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .final_(.nullable(.initialized(.private(.fields)))),
            );
          });
        });
      });
    });
  });
}
