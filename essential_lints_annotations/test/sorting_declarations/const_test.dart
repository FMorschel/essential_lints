import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Const', () {
    test('const_', () {
      expectSortDeclaration(const .const_(.fields));
    });
    group('members', () {
      test('constructors', () {
        expectSortDeclaration(const .const_(.constructors));
      });
      test('fields', () {
        expectSortDeclaration(const .const_(.fields));
      });
    });
    group('Public', () {
      test('constructors', () {
        expectSortDeclaration(const .const_(.public(.constructors)));
      });
      test('fields', () {
        expectSortDeclaration(const .const_(.public(.fields)));
      });
    });
    group('Private', () {
      test('constructors', () {
        expectSortDeclaration(const .const_(.private(.constructors)));
      });
      test('fields', () {
        expectSortDeclaration(const .const_(.private(.fields)));
      });
    });
    group('Initialized', () {
      test('fields', () {
        expectSortDeclaration(const .const_(.initialized(.fields)));
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .const_(.initialized(.public(.fields))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .const_(.initialized(.private(.fields))));
        });
      });
    });
    group('Unnamed', () {
      test('constructors', () {
        expectSortDeclaration(const .const_(.unnamed(.constructors)));
      });
    });
    group('Named', () {
      test('constructors', () {
        expectSortDeclaration(const .const_(.named(.constructors)));
      });
      group('Public', () {
        test('constructors', () {
          expectSortDeclaration(const .const_(.named(.public(.constructors))));
        });
      });
      group('Private', () {
        test('constructors', () {
          expectSortDeclaration(
            const .const_(.named(.private(.constructors))),
          );
        });
      });
    });
    group('Factory', () {
      test('constructors', () {
        expectSortDeclaration(const .const_(.factory_(.constructors)));
      });
      group('Public', () {
        test('constructors', () {
          expectSortDeclaration(
            const .const_(.factory_(.public(.constructors))),
          );
        });
      });
      group('Private', () {
        test('constructors', () {
          expectSortDeclaration(
            const .const_(.factory_(.private(.constructors))),
          );
        });
      });
      group('Unnamed', () {
        test('constructors', () {
          expectSortDeclaration(
            const .const_(.factory_(.unnamed(.constructors))),
          );
        });
      });
      group('Named', () {
        test('constructors', () {
          expectSortDeclaration(
            const .const_(.factory_(.named(.constructors))),
          );
        });
        group('Public', () {
          test('constructors', () {
            expectSortDeclaration(
              const .const_(.factory_(.named(.public(.constructors)))),
            );
          });
        });
        group('Private', () {
          test('constructors', () {
            expectSortDeclaration(
              const .const_(.factory_(.named(.private(.constructors)))),
            );
          });
        });
      });
      group('Redirecting', () {
        test('constructors', () {
          expectSortDeclaration(
            const .const_(.factory_(.redirecting(.constructors))),
          );
        });
        group('Public', () {
          test('constructors', () {
            expectSortDeclaration(
              const .const_(.factory_(.redirecting(.public(.constructors)))),
            );
          });
        });
        group('Private', () {
          test('constructors', () {
            expectSortDeclaration(
              const .const_(.factory_(.redirecting(.private(.constructors)))),
            );
          });
        });
        group('Unnamed', () {
          test('constructors', () {
            expectSortDeclaration(
              const .const_(.factory_(.redirecting(.unnamed(.constructors)))),
            );
          });
        });
        group('Named', () {
          test('constructors', () {
            expectSortDeclaration(
              const .const_(.factory_(.redirecting(.named(.constructors)))),
            );
          });
          group('Public', () {
            test('constructors', () {
              expectSortDeclaration(
                const .const_(
                  .factory_(.redirecting(.named(.public(.constructors)))),
                ),
              );
            });
          });
          group('Private', () {
            test('constructors', () {
              expectSortDeclaration(
                const .const_(
                  .factory_(.redirecting(.named(.private(.constructors)))),
                ),
              );
            });
          });
        });
      });
    });
  });
}
