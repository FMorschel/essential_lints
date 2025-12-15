import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Abstract', () {
    test('abstract', () {
      expectSortDeclaration(const .abstract(.fields));
    });
    group('members', () {
      test('methods', () {
        expectSortDeclaration(const .abstract(.methods));
      });
      test('fields', () {
        expectSortDeclaration(const .abstract(.fields));
      });
      test('fields', () {
        expectSortDeclaration(const .abstract(.getters));
      });
      test('setters', () {
        expectSortDeclaration(const .abstract(.setters));
      });
    });
    group('Nullable', () {
      test('methods', () {
        expectSortDeclaration(const .abstract(.nullable(.methods)));
      });
      test('fields', () {
        expectSortDeclaration(const .abstract(.nullable(.fields)));
      });
      test('getters', () {
        expectSortDeclaration(const .abstract(.nullable(.getters)));
      });
      test('setters', () {
        expectSortDeclaration(const .abstract(.nullable(.setters)));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .abstract(.nullable(.gettersSetters)));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(
          const .abstract(.nullable(.fieldsGettersSetters)),
        );
      });
    });
    group('Operator', () {
      group('Nullable', () {
        test('methods', () {
          expectSortDeclaration(
            const .abstract(.operator(.nullable(.methods))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .abstract(.operator(.methods)),
          );
        });
      });
    });
    group('Public', () {
      test('fields', () {
        expectSortDeclaration(const .abstract(.public(.fields)));
      });
      test('getters', () {
        expectSortDeclaration(const .abstract(.public(.getters)));
      });
      test('setters', () {
        expectSortDeclaration(const .abstract(.public(.setters)));
      });
      test('methods', () {
        expectSortDeclaration(const .abstract(.public(.methods)));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .abstract(.public(.gettersSetters)));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(const .abstract(.public(.fieldsGettersSetters)));
      });
    });
    group('Private', () {
      test('fields', () {
        expectSortDeclaration(const .abstract(.private(.fields)));
      });
      test('getters', () {
        expectSortDeclaration(const .abstract(.private(.getters)));
      });
      test('setters', () {
        expectSortDeclaration(const .abstract(.private(.setters)));
      });
      test('methods', () {
        expectSortDeclaration(const .abstract(.private(.methods)));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .abstract(.private(.gettersSetters)));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(const .abstract(.private(.fieldsGettersSetters)));
      });
    });
    group('Nullable', () {
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .abstract(.nullable(.public(.fields))));
        });
        test('getters', () {
          expectSortDeclaration(const .abstract(.nullable(.public(.getters))));
        });
        test('setters', () {
          expectSortDeclaration(const .abstract(.nullable(.public(.setters))));
        });
        test('methods', () {
          expectSortDeclaration(const .abstract(.nullable(.public(.methods))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .abstract(.nullable(.public(.gettersSetters))),
          );
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .abstract(.nullable(.public(.fieldsGettersSetters))),
          );
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .abstract(.nullable(.private(.fields))));
        });
        test('getters', () {
          expectSortDeclaration(
            const .abstract(.nullable(.private(.getters))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .abstract(.nullable(.private(.setters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .abstract(.nullable(.private(.methods))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .abstract(.nullable(.private(.gettersSetters))),
          );
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .abstract(.nullable(.private(.fieldsGettersSetters))),
          );
        });
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(
            const .abstract(.nullable(.initialized(.fields))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .abstract(.nullable(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .abstract(.nullable(.initialized(.private(.fields)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .abstract(.nullable(.initialized(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .abstract(
                  .nullable(.initialized(.nullable(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .abstract(
                  .nullable(.initialized(.nullable(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
    });
    group('var', () {
      test('fields', () {
        expectSortDeclaration(const .abstract(.var_(.fields)));
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .abstract(.var_(.public(.fields))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .abstract(.var_(.private(.fields))));
        });
      });
      group('final', () {
        test('nullable setters', () {
          expectSortDeclaration(const .abstract(.final_(.nullable(.fields))));
        });
        test('nullable private fields', () {
          expectSortDeclaration(
            const .abstract(.final_(.nullable(.private(.fields)))),
          );
        });
        test('nullable public fields', () {
          expectSortDeclaration(
            const .abstract(.final_(.nullable(.public(.fields)))),
          );
        });
        test('private fields', () {
          expectSortDeclaration(
            const .abstract(.final_(.private(.fields))),
          );
        });
        test('public fields', () {
          expectSortDeclaration(
            const .abstract(.final_(.public(.fields))),
          );
        });
        test('fields', () {
          expectSortDeclaration(const .abstract(.final_(.fields)));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(const .abstract(.final_(.public(.fields))));
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(const .abstract(.final_(.private(.fields))));
          });
        });
        group('Nullable', () {
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .abstract(.final_(.nullable(.public(.fields)))),
              );
            });
          });
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .abstract(.final_(.nullable(.fields))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .abstract(.final_(.nullable(.private(.fields)))),
              );
            });
          });
        });
      });
    });
  });
}
