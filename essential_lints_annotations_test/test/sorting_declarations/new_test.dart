import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('New', () {
    group('Dynamic', () {
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.dynamic(.fields)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .new_(.dynamic(.fieldsGettersSetters)),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .new_(.dynamic(.getters)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .new_(.dynamic(.gettersSetters)));
        });
        test('methods', () {
          expectSortDeclaration(const .new_(.dynamic(.methods)));
        });
        test('setters', () {
          expectSortDeclaration(const .new_(.dynamic(.setters)));
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.dynamic(.public(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .new_(.dynamic(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .new_(.dynamic(.public(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .new_(.dynamic(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .new_(.dynamic(.public(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .new_(.dynamic(.public(.setters))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(
            const .new_(.dynamic(.private(.fields))),
          );
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .new_(.dynamic(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .new_(.dynamic(.private(.getters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .new_(.dynamic(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .new_(.dynamic(.private(.methods))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .new_(.dynamic(.private(.setters))),
          );
        });
      });
      group('Initialized', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.dynamic(.initialized(.fields))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.dynamic(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.dynamic(.initialized(.private(.fields)))),
            );
          });
        });
      });
    });
    group('Typed', () {
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.typed(.fields)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .new_(.typed(.fieldsGettersSetters)),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .new_(.typed(.getters)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .new_(.typed(.gettersSetters)));
        });
        test('methods', () {
          expectSortDeclaration(const .new_(.typed(.methods)));
        });
        test('setters', () {
          expectSortDeclaration(const .new_(.typed(.setters)));
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.typed(.public(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .new_(.typed(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .new_(.typed(.public(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .new_(.typed(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .new_(.typed(.public(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .new_(.typed(.public(.setters))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.typed(.private(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .new_(.typed(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .new_(.typed(.private(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .new_(.typed(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .new_(.typed(.private(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .new_(.typed(.private(.setters))));
        });
      });
      group('Initialized', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.typed(.initialized(.fields))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.typed(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.typed(.initialized(.private(.fields)))),
            );
          });
        });
      });
      group('Nullable', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.typed(.nullable(.fields))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .new_(.typed(.nullable(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .new_(.typed(.nullable(.getters))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .new_(.typed(.nullable(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .new_(.typed(.nullable(.methods))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .new_(.typed(.nullable(.setters))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.typed(.nullable(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .new_(.typed(.nullable(.public(.fieldsGettersSetters)))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .new_(.typed(.nullable(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .new_(.typed(.nullable(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .new_(.typed(.nullable(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .new_(.typed(.nullable(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.typed(.nullable(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .new_(
                .typed(.nullable(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .new_(.typed(.nullable(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .new_(.typed(.nullable(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .new_(.typed(.nullable(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .new_(.typed(.nullable(.private(.setters)))),
            );
          });
        });
        group('Initialized', () {
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(.typed(.nullable(.initialized(.fields)))),
              );
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .typed(.nullable(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .typed(.nullable(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
    });
    test('overridden', () {
      expectSortDeclaration(const .new_(.fields));
    });
    test('getters', () {
      expectSortDeclaration(const .new_(.getters));
    });
    group('Public', () {
      test('fields', () {
        expectSortDeclaration(const .new_(.public(.fields)));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(
          const .new_(.public(.fieldsGettersSetters)),
        );
      });
      test('getters', () {
        expectSortDeclaration(const .new_(.public(.getters)));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .new_(.public(.gettersSetters)));
      });
      test('methods', () {
        expectSortDeclaration(const .new_(.public(.methods)));
      });
      test('setters', () {
        expectSortDeclaration(const .new_(.public(.setters)));
      });
    });
    group('Private', () {
      test('fields', () {
        expectSortDeclaration(const .new_(.private(.fields)));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(
          const .new_(.private(.fieldsGettersSetters)),
        );
      });
      test('getters', () {
        expectSortDeclaration(const .new_(.private(.getters)));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .new_(.private(.gettersSetters)));
      });
      test('methods', () {
        expectSortDeclaration(const .new_(.private(.methods)));
      });
      test('setters', () {
        expectSortDeclaration(const .new_(.private(.setters)));
      });
    });
    group('Initialized', () {
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.initialized(.fields)));
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(
            const .new_(.initialized(.public(.fields))),
          );
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(
            const .new_(.initialized(.private(.fields))),
          );
        });
      });
    });
    group('Nullable', () {
      test('fieldsGettersSetters', () {
        expectSortDeclaration(
          const .new_(.nullable(.fieldsGettersSetters)),
        );
      });
      test('getters', () {
        expectSortDeclaration(const .new_(.nullable(.getters)));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .new_(.nullable(.gettersSetters)));
      });
      test('methods', () {
        expectSortDeclaration(const .new_(.nullable(.methods)));
      });
      test('setters', () {
        expectSortDeclaration(const .new_(.nullable(.setters)));
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(
            const .new_(.nullable(.initialized(.fields))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.nullable(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.nullable(.initialized(.private(.fields)))),
            );
          });
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(
            const .new_(.nullable(.public(.fields))),
          );
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .new_(.nullable(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .new_(.nullable(.public(.getters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .new_(.nullable(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .new_(.nullable(.public(.methods))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .new_(.nullable(.public(.setters))),
          );
        });
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.nullable(.fields)));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(
            const .new_(.nullable(.private(.fields))),
          );
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .new_(.nullable(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .new_(.nullable(.private(.getters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .new_(.nullable(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .new_(.nullable(.private(.methods))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .new_(.nullable(.private(.setters))),
          );
        });
      });
    });
    group('Abstract', () {
      group('Dynamic', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.abstract(.dynamic(.fields))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .new_(.abstract(.dynamic(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .new_(.abstract(.dynamic(.getters))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .new_(.abstract(.dynamic(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .new_(.abstract(.dynamic(.methods))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .new_(.abstract(.dynamic(.setters))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.abstract(.dynamic(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .new_(
                .abstract(.dynamic(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .new_(.abstract(.dynamic(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .new_(.abstract(.dynamic(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .new_(.abstract(.dynamic(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .new_(.abstract(.dynamic(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.abstract(.dynamic(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .new_(
                .abstract(.dynamic(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .new_(.abstract(.dynamic(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .new_(.abstract(.dynamic(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .new_(.abstract(.dynamic(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .new_(.abstract(.dynamic(.private(.setters)))),
            );
          });
        });
      });
      group('Typed', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.abstract(.typed(.fields))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .new_(.abstract(.typed(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .new_(.abstract(.typed(.getters))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .new_(.abstract(.typed(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .new_(.abstract(.typed(.methods))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .new_(.abstract(.typed(.setters))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.abstract(.typed(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .new_(
                .abstract(.typed(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .new_(.abstract(.typed(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .new_(.abstract(.typed(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .new_(.abstract(.typed(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .new_(.abstract(.typed(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.abstract(.typed(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .new_(
                .abstract(.typed(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .new_(.abstract(.typed(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .new_(.abstract(.typed(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .new_(.abstract(.typed(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .new_(.abstract(.typed(.private(.setters)))),
            );
          });
        });
        group('Nullable', () {
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(.abstract(.typed(.nullable(.fields)))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .new_(
                  .abstract(.typed(.nullable(.fieldsGettersSetters))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .new_(.abstract(.typed(.nullable(.getters)))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .new_(.abstract(.typed(.nullable(.gettersSetters)))),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .new_(.abstract(.typed(.nullable(.methods)))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .new_(.abstract(.typed(.nullable(.setters)))),
              );
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .abstract(.typed(.nullable(.public(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .new_(
                  .abstract(
                    .typed(.nullable(.public(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .new_(
                  .abstract(.typed(.nullable(.public(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .new_(
                  .abstract(.typed(.nullable(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .new_(
                  .abstract(.typed(.nullable(.public(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .new_(
                  .abstract(.typed(.nullable(.public(.setters)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .abstract(.typed(.nullable(.private(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .new_(
                  .abstract(
                    .typed(.nullable(.private(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .new_(
                  .abstract(.typed(.nullable(.private(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .new_(
                  .abstract(.typed(.nullable(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .new_(
                  .abstract(.typed(.nullable(.private(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .new_(
                  .abstract(.typed(.nullable(.private(.setters)))),
                ),
              );
            });
          });
        });
      });
      group('Public', () {
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .new_(.abstract(.public(.fieldsGettersSetters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .new_(.abstract(.public(.gettersSetters))),
          );
        });
      });
      group('Private', () {
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .new_(.abstract(.private(.fieldsGettersSetters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .new_(.abstract(.private(.gettersSetters))),
          );
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(
            const .new_(.abstract(.public(.fields))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .new_(.abstract(.public(.getters))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .new_(.abstract(.public(.setters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .new_(.abstract(.public(.methods))),
          );
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(
            const .new_(.abstract(.private(.fields))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .new_(.abstract(.private(.getters))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .new_(.abstract(.private(.setters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .new_(.abstract(.private(.methods))),
          );
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(
            const .new_(.abstract(.nullable(.fields))),
          );
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .new_(.abstract(.nullable(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .new_(.abstract(.nullable(.getters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .new_(.abstract(.nullable(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .new_(.abstract(.nullable(.methods))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .new_(.abstract(.nullable(.setters))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.abstract(.nullable(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .new_(
                .abstract(.nullable(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .new_(.abstract(.nullable(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .new_(.abstract(.nullable(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .new_(.abstract(.nullable(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .new_(.abstract(.nullable(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.abstract(.nullable(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .new_(
                .abstract(.nullable(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .new_(.abstract(.nullable(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .new_(
                .abstract(.nullable(.private(.gettersSetters))),
              ),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .new_(.abstract(.nullable(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .new_(.abstract(.nullable(.private(.setters)))),
            );
          });
        });
      });
      group('Operator', () {
        group('Dynamic', () {
          test('methods', () {
            expectSortDeclaration(
              const .new_(.abstract(.operator(.dynamic(.methods)))),
            );
            expectSortDeclaration(
              const .new_(.abstract(.operator(.dynamic()))),
            );
          });
        });
        group('Typed', () {
          test('methods', () {
            expectSortDeclaration(
              const .new_(.abstract(.operator(.typed(.methods)))),
            );
            expectSortDeclaration(
              const .new_(.abstract(.operator(.typed()))),
            );
          });
          group('Nullable', () {
            test('methods', () {
              expectSortDeclaration(
                const .new_(
                  .abstract(.operator(.typed(.nullable(.methods)))),
                ),
              );
              expectSortDeclaration(
                const .new_(.abstract(.operator(.typed(.nullable())))),
              );
            });
          });
        });
        test('methods', () {
          expectSortDeclaration(
            const .new_(.abstract(.operator(.methods))),
          );
          expectSortDeclaration(
            const .new_(.abstract(.operator())),
          );
        });
        group('Nullable', () {
          test('methods', () {
            expectSortDeclaration(
              const .new_(.abstract(.operator(.nullable(.methods)))),
            );
            expectSortDeclaration(
              const .new_(.abstract(.operator(.nullable()))),
            );
          });
        });
      });
      group('members', () {
        test('getters', () {
          expectSortDeclaration(const .new_(.abstract(.getters)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .new_(.abstract(.gettersSetters)));
        });
        test('setters', () {
          expectSortDeclaration(const .new_(.abstract(.setters)));
        });
        test('methods', () {
          expectSortDeclaration(const .new_(.abstract(.methods)));
        });
        test('fields', () {
          expectSortDeclaration(const .new_(.abstract(.fields)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .new_(.abstract(.fieldsGettersSetters)),
          );
        });
      });
      group('var', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.abstract(.var_(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.abstract(.var_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.abstract(.var_(.private(.fields)))),
            );
          });
        });
      });
      group('final', () {
        group('Dynamic', () {
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(.abstract(.final_(.dynamic(.fields)))),
              );
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .abstract(.final_(.dynamic(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .abstract(.final_(.dynamic(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Typed', () {
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(.abstract(.final_(.typed(.fields)))),
              );
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .abstract(.final_(.typed(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .abstract(.final_(.typed(.private(.fields)))),
                ),
              );
            });
          });
          group('Nullable', () {
            group('members', () {
              test('fields', () {
                expectSortDeclaration(
                  const .new_(
                    .abstract(.final_(.typed(.nullable(.fields)))),
                  ),
                );
              });
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .new_(
                    .abstract(.final_(.typed(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .new_(
                    .abstract(.final_(.typed(.nullable(.private(.fields))))),
                  ),
                );
              });
            });
          });
        });
        test('fields', () {
          expectSortDeclaration(
            const .new_(.abstract(.final_(.fields))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.abstract(.final_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.abstract(.final_(.private(.fields)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.abstract(.final_(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .abstract(.final_(.nullable(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .abstract(.final_(.nullable(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
    });
    group('Operator', () {
      test('methods', () {
        expectSortDeclaration(const .new_(.operator(.methods)));
        expectSortDeclaration(const .new_(.operator()));
      });
      group('Dynamic', () {
        test('methods', () {
          expectSortDeclaration(const .new_(.operator(.dynamic(.methods))));
        });
      });
      group('Typed', () {
        test('methods', () {
          expectSortDeclaration(const .new_(.operator(.typed(.methods))));
        });
        group('Nullable', () {
          test('methods', () {
            expectSortDeclaration(
              const .new_(.operator(.typed(.nullable(.methods)))),
            );
          });
        });
      });
      group('Nullable', () {
        test('methods', () {
          expectSortDeclaration(
            const .new_(.operator(.nullable(.methods))),
          );
          expectSortDeclaration(const .new_(.operator(.nullable())));
        });
      });
    });
    group('Late', () {
      test('fields', () {
        expectSortDeclaration(const .new_(.late(.fields)));
      });
      group('Dynamic', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.late(.dynamic(.fields))));
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.dynamic(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .late(.dynamic(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .late(.dynamic(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.dynamic(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.dynamic(.private(.fields)))),
            );
          });
        });
      });
      group('Typed', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.late(.typed(.fields))));
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.typed(.nullable(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .late(.typed(.nullable(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .new_(
                    .late(.typed(.nullable(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .new_(
                    .late(.typed(.nullable(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(.late(.typed(.nullable(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(.late(.typed(.nullable(.private(.fields))))),
              );
            });
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.typed(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .late(.typed(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .late(.typed(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.typed(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.typed(.private(.fields)))),
            );
          });
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.late(.public(.fields))));
        });
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.late(.fields)));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.late(.private(.fields))));
        });
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(
            const .new_(.late(.initialized(.fields))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.initialized(.private(.fields)))),
            );
          });
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.late(.nullable(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.nullable(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.nullable(.private(.fields)))),
            );
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.nullable(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .late(.nullable(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .late(.nullable(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
      group('var', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.late(.var_(.fields))));
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.var_(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(.late(.var_(.initialized(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .late(.var_(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.var_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.var_(.private(.fields)))),
            );
          });
        });
      });
      group('final', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.late(.final_(.fields))));
        });
        group('Dynamic', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.final_(.dynamic(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(.late(.final_(.dynamic(.initialized(.fields))))),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .new_(
                    .late(
                      .final_(.dynamic(.initialized(.public(.fields)))),
                    ),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .new_(
                    .late(
                      .final_(.dynamic(.initialized(.private(.fields)))),
                    ),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(.late(.final_(.dynamic(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(.late(.final_(.dynamic(.private(.fields))))),
              );
            });
          });
        });
        group('Typed', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.final_(.typed(.fields)))),
            );
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(.late(.final_(.typed(.nullable(.fields))))),
              );
            });
            group('Initialized', () {
              test('fields', () {
                expectSortDeclaration(
                  const .new_(
                    .late(
                      .final_(.typed(.nullable(.initialized(.fields)))),
                    ),
                  ),
                );
              });
              group('Public', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .new_(
                      .late(
                        .final_(
                          .typed(
                            .nullable(.initialized(.public(.fields))),
                          ),
                        ),
                      ),
                    ),
                  );
                });
              });
              group('Private', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .new_(
                      .late(
                        .final_(
                          .typed(
                            .nullable(.initialized(.private(.fields))),
                          ),
                        ),
                      ),
                    ),
                  );
                });
              });
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .new_(
                    .late(.final_(.typed(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .new_(
                    .late(.final_(.typed(.nullable(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(.late(.final_(.typed(.initialized(.fields))))),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .new_(
                    .late(
                      .final_(.typed(.initialized(.public(.fields)))),
                    ),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .new_(
                    .late(
                      .final_(.typed(.initialized(.private(.fields)))),
                    ),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(.late(.final_(.typed(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(.late(.final_(.typed(.private(.fields))))),
              );
            });
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.final_(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .late(.final_(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .late(.final_(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.final_(.nullable(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .late(.final_(.nullable(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .new_(
                    .late(.final_(.nullable(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .new_(
                    .late(.final_(.nullable(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(.late(.final_(.nullable(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(.late(.final_(.nullable(.private(.fields))))),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.final_(.public(.fields)))),
            );
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(const .new_(.late(.final_(.fields))));
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.late(.final_(.private(.fields)))),
            );
          });
        });
      });
    });
    group('var', () {
      test('fields', () {
        expectSortDeclaration(const .new_(.var_(.fields)));
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.var_(.public(.fields))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.var_(.private(.fields))));
        });
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(
            const .new_(.var_(.initialized(.fields))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.var_(.initialized(.public(.fields)))),
            );
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.var_(.initialized(.fields))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.var_(.initialized(.private(.fields)))),
            );
          });
        });
      });
    });
    group('final', () {
      test('fields', () {
        expectSortDeclaration(const .new_(.final_(.fields)));
      });
      group('Dynamic', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.final_(.dynamic(.fields))));
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.final_(.dynamic(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .final_(.dynamic(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .final_(.dynamic(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.final_(.dynamic(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.final_(.dynamic(.private(.fields)))),
            );
          });
        });
      });
      group('Typed', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.final_(.typed(.fields))));
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.final_(.typed(.nullable(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .final_(.typed(.nullable(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .new_(
                    .final_(
                      .typed(.nullable(.initialized(.public(.fields)))),
                    ),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .new_(
                    .final_(
                      .typed(.nullable(.initialized(.private(.fields)))),
                    ),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(.final_(.typed(.nullable(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(.final_(.typed(.nullable(.private(.fields))))),
              );
            });
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.final_(.typed(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .final_(.typed(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .final_(.typed(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.final_(.typed(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.final_(.typed(.private(.fields)))),
            );
          });
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.final_(.public(.fields))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.final_(.private(.fields))));
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(const .new_(.final_(.nullable(.fields))));
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.final_(.nullable(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .final_(.nullable(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .new_(
                  .final_(.nullable(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.final_(.nullable(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.final_(.nullable(.private(.fields)))),
            );
          });
        });
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(
            const .new_(.final_(.initialized(.fields))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.final_(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .new_(.final_(.initialized(.private(.fields)))),
            );
          });
        });
      });
    });
    group('members', () {
      test('fields', () {
        expectSortDeclaration(const .new_(.fields));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(const .new_(.fieldsGettersSetters));
      });
      test('getters', () {
        expectSortDeclaration(const .new_(.getters));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .new_(.gettersSetters));
      });
      test('methods', () {
        expectSortDeclaration(const .new_(.methods));
      });
      test('setters', () {
        expectSortDeclaration(const .new_(.setters));
      });
    });
  });
}
