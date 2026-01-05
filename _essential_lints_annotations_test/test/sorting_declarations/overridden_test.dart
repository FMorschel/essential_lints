import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Overridden', () {
    test('overridden', () {
      expectSortDeclaration(const .overridden(.fields));
    });
    test('getters', () {
      expectSortDeclaration(const .overridden(.getters));
    });
    group('Dynamic', () {
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.dynamic(.fields)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .overridden(.dynamic(.fieldsGettersSetters)),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .overridden(.dynamic(.getters)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .overridden(.dynamic(.gettersSetters)));
        });
        test('methods', () {
          expectSortDeclaration(const .overridden(.dynamic(.methods)));
        });
        test('setters', () {
          expectSortDeclaration(const .overridden(.dynamic(.setters)));
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.dynamic(.public(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .overridden(.dynamic(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .overridden(.dynamic(.public(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .overridden(.dynamic(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .overridden(.dynamic(.public(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .overridden(.dynamic(.public(.setters))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.dynamic(.private(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .overridden(.dynamic(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .overridden(.dynamic(.private(.getters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .overridden(.dynamic(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .overridden(.dynamic(.private(.methods))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .overridden(.dynamic(.private(.setters))),
          );
        });
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(
            const .overridden(.dynamic(.initialized(.fields))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.dynamic(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.dynamic(.initialized(.private(.fields)))),
            );
          });
        });
      });
    });
    group('Typed', () {
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.typed(.fields)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .overridden(.typed(.fieldsGettersSetters)),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .overridden(.typed(.getters)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .overridden(.typed(.gettersSetters)));
        });
        test('methods', () {
          expectSortDeclaration(const .overridden(.typed(.methods)));
        });
        test('setters', () {
          expectSortDeclaration(const .overridden(.typed(.setters)));
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.typed(.public(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .overridden(.typed(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .overridden(.typed(.public(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .overridden(.typed(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .overridden(.typed(.public(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .overridden(.typed(.public(.setters))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.typed(.private(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .overridden(.typed(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .overridden(.typed(.private(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .overridden(.typed(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .overridden(.typed(.private(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .overridden(.typed(.private(.setters))));
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.typed(.nullable(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .overridden(.typed(.nullable(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .overridden(.typed(.nullable(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .overridden(.typed(.nullable(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .overridden(.typed(.nullable(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .overridden(.typed(.nullable(.setters))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.typed(.nullable(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .overridden(
                .typed(.nullable(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .overridden(.typed(.nullable(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .overridden(.typed(.nullable(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .overridden(.typed(.nullable(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .overridden(.typed(.nullable(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.typed(.nullable(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .overridden(
                .typed(.nullable(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .overridden(.typed(.nullable(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .overridden(.typed(.nullable(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .overridden(.typed(.nullable(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .overridden(.typed(.nullable(.private(.setters)))),
            );
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.typed(.nullable(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .typed(.nullable(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .typed(.nullable(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(
            const .overridden(.typed(.initialized(.fields))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.typed(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.typed(.initialized(.private(.fields)))),
            );
          });
        });
      });
    });
    group('Public', () {
      test('fields', () {
        expectSortDeclaration(const .overridden(.public(.fields)));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(
          const .overridden(.public(.fieldsGettersSetters)),
        );
      });
      test('getters', () {
        expectSortDeclaration(const .overridden(.public(.getters)));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .overridden(.public(.gettersSetters)));
      });
      test('methods', () {
        expectSortDeclaration(const .overridden(.public(.methods)));
      });
      test('setters', () {
        expectSortDeclaration(const .overridden(.public(.setters)));
      });
    });
    group('Private', () {
      test('fields', () {
        expectSortDeclaration(const .overridden(.private(.fields)));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(
          const .overridden(.private(.fieldsGettersSetters)),
        );
      });
      test('getters', () {
        expectSortDeclaration(const .overridden(.private(.getters)));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .overridden(.private(.gettersSetters)));
      });
      test('methods', () {
        expectSortDeclaration(const .overridden(.private(.methods)));
      });
      test('setters', () {
        expectSortDeclaration(const .overridden(.private(.setters)));
      });
    });
    group('Initialized', () {
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.initialized(.fields)));
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(
            const .overridden(.initialized(.public(.fields))),
          );
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(
            const .overridden(.initialized(.private(.fields))),
          );
        });
      });
    });
    group('Nullable', () {
      test('fieldsGettersSetters', () {
        expectSortDeclaration(
          const .overridden(.nullable(.fieldsGettersSetters)),
        );
      });
      test('getters', () {
        expectSortDeclaration(const .overridden(.nullable(.getters)));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .overridden(.nullable(.gettersSetters)));
      });
      test('methods', () {
        expectSortDeclaration(const .overridden(.nullable(.methods)));
      });
      test('setters', () {
        expectSortDeclaration(const .overridden(.nullable(.setters)));
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(
            const .overridden(.nullable(.initialized(.fields))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.nullable(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.nullable(.initialized(.private(.fields)))),
            );
          });
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(
            const .overridden(.nullable(.public(.fields))),
          );
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .overridden(.nullable(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .overridden(.nullable(.public(.getters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .overridden(.nullable(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .overridden(.nullable(.public(.methods))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .overridden(.nullable(.public(.setters))),
          );
        });
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.nullable(.fields)));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(
            const .overridden(.nullable(.private(.fields))),
          );
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .overridden(.nullable(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .overridden(.nullable(.private(.getters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .overridden(.nullable(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .overridden(.nullable(.private(.methods))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .overridden(.nullable(.private(.setters))),
          );
        });
      });
    });
    group('Abstract', () {
      group('Dynamic', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.abstract(.dynamic(.fields))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.dynamic(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.dynamic(.getters))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.dynamic(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .overridden(.abstract(.dynamic(.methods))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.dynamic(.setters))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.abstract(.dynamic(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .overridden(
                .abstract(.dynamic(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.dynamic(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.dynamic(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .overridden(.abstract(.dynamic(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.dynamic(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.abstract(.dynamic(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .overridden(
                .abstract(.dynamic(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.dynamic(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .overridden(
                .abstract(.dynamic(.private(.gettersSetters))),
              ),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .overridden(.abstract(.dynamic(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.dynamic(.private(.setters)))),
            );
          });
        });
      });
      group('Typed', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.abstract(.typed(.fields))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.typed(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.typed(.getters))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.typed(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .overridden(.abstract(.typed(.methods))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.typed(.setters))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.abstract(.typed(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .overridden(
                .abstract(.typed(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.typed(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.typed(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .overridden(.abstract(.typed(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.typed(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.abstract(.typed(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .overridden(
                .abstract(.typed(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.typed(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .overridden(
                .abstract(.typed(.private(.gettersSetters))),
              ),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .overridden(.abstract(.typed(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.typed(.private(.setters)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.abstract(.typed(.nullable(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .overridden(
                .abstract(.typed(.nullable(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.typed(.nullable(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .overridden(
                .abstract(.typed(.nullable(.gettersSetters))),
              ),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .overridden(.abstract(.typed(.nullable(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.typed(.nullable(.setters)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(.typed(.nullable(.public(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(.typed(.nullable(.public(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(.typed(.nullable(.public(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(.typed(.nullable(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(.typed(.nullable(.public(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(.typed(.nullable(.public(.setters)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(.typed(.nullable(.private(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(.typed(.nullable(.private(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(.typed(.nullable(.private(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(.typed(.nullable(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(.typed(.nullable(.private(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .overridden(
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
            const .overridden(.abstract(.public(.fieldsGettersSetters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .overridden(.abstract(.public(.gettersSetters))),
          );
        });
      });
      group('Private', () {
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .overridden(.abstract(.private(.fieldsGettersSetters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .overridden(.abstract(.private(.gettersSetters))),
          );
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(
            const .overridden(.abstract(.public(.fields))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .overridden(.abstract(.public(.getters))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .overridden(.abstract(.public(.setters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .overridden(.abstract(.public(.methods))),
          );
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(
            const .overridden(.abstract(.private(.fields))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .overridden(.abstract(.private(.getters))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .overridden(.abstract(.private(.setters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .overridden(.abstract(.private(.methods))),
          );
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(
            const .overridden(.abstract(.nullable(.fields))),
          );
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .overridden(.abstract(.nullable(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .overridden(.abstract(.nullable(.getters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .overridden(.abstract(.nullable(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .overridden(.abstract(.nullable(.methods))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .overridden(.abstract(.nullable(.setters))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.abstract(.nullable(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .overridden(
                .abstract(.nullable(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.nullable(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.nullable(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .overridden(.abstract(.nullable(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.nullable(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.abstract(.nullable(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .overridden(
                .abstract(.nullable(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.nullable(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .overridden(
                .abstract(.nullable(.private(.gettersSetters))),
              ),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .overridden(.abstract(.nullable(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .overridden(.abstract(.nullable(.private(.setters)))),
            );
          });
        });
      });
      group('operator', () {
        test('methods', () {
          expectSortDeclaration(
            const .overridden(.abstract(.operator(.methods))),
          );
          expectSortDeclaration(
            const .overridden(.abstract(.operator())),
          );
        });
        group('Dynamic', () {
          test('methods', () {
            expectSortDeclaration(
              const .overridden(.abstract(.operator(.dynamic(.methods)))),
            );
          });
        });
        group('Typed', () {
          test('methods', () {
            expectSortDeclaration(
              const .overridden(.abstract(.operator(.typed(.methods)))),
            );
          });
          group('Nullable', () {
            test('methods', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(.operator(.typed(.nullable(.methods)))),
                ),
              );
            });
          });
        });
        group('Nullable', () {
          test('methods', () {
            expectSortDeclaration(
              const .overridden(.abstract(.operator(.nullable(.methods)))),
            );
            expectSortDeclaration(
              const .overridden(.abstract(.operator(.nullable()))),
            );
          });
        });
      });
      group('members', () {
        test('getters', () {
          expectSortDeclaration(const .overridden(.abstract(.getters)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .overridden(.abstract(.fieldsGettersSetters)),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .overridden(.abstract(.gettersSetters)));
        });
        test('setters', () {
          expectSortDeclaration(const .overridden(.abstract(.setters)));
        });
        test('methods', () {
          expectSortDeclaration(const .overridden(.abstract(.methods)));
        });
        test('fields', () {
          expectSortDeclaration(const .overridden(.abstract(.fields)));
        });
      });
      group('var', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.abstract(.var_(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.abstract(.var_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.abstract(.var_(.private(.fields)))),
            );
          });
        });
      });
      group('final', () {
        test('fields', () {
          expectSortDeclaration(
            const .overridden(.abstract(.final_(.fields))),
          );
        });
        group('Dynamic', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.abstract(.final_(.dynamic(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(.final_(.dynamic(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(.final_(.dynamic(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Typed', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.abstract(.final_(.typed(.fields)))),
            );
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(.final_(.typed(.nullable(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .abstract(.final_(.typed(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .abstract(.final_(.typed(.nullable(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(.final_(.typed(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(.final_(.typed(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.abstract(.final_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.abstract(.final_(.private(.fields)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.abstract(.final_(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(.final_(.nullable(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
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
        expectSortDeclaration(const .overridden(.operator(.methods)));
        expectSortDeclaration(const .overridden(.operator()));
      });
      group('Dynamic', () {
        test('methods', () {
          expectSortDeclaration(
            const .overridden(.operator(.dynamic(.methods))),
          );
        });
      });
      group('Typed', () {
        test('methods', () {
          expectSortDeclaration(
            const .overridden(.operator(.typed(.methods))),
          );
        });
        group('Nullable', () {
          test('methods', () {
            expectSortDeclaration(
              const .overridden(.operator(.typed(.nullable(.methods)))),
            );
          });
        });
      });
      group('Nullable', () {
        test('methods', () {
          expectSortDeclaration(
            const .overridden(.operator(.nullable(.methods))),
          );
          expectSortDeclaration(const .overridden(.operator(.nullable())));
        });
      });
    });
    group('Late', () {
      test('fields', () {
        expectSortDeclaration(const .overridden(.late(.fields)));
      });
      group('Dynamic', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.late(.dynamic(.fields))));
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.dynamic(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.dynamic(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.dynamic(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.dynamic(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.dynamic(.private(.fields)))),
            );
          });
        });
      });
      group('Typed', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.late(.typed(.fields))));
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.typed(.nullable(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.typed(.nullable(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .late(.typed(.nullable(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .late(.typed(.nullable(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(.late(.typed(.nullable(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.typed(.nullable(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.typed(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.typed(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.typed(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.typed(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.typed(.private(.fields)))),
            );
          });
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.late(.public(.fields))));
        });
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.late(.fields)));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.late(.private(.fields))));
        });
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(
            const .overridden(.late(.initialized(.fields))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.initialized(.private(.fields)))),
            );
          });
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.late(.nullable(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.nullable(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.nullable(.private(.fields)))),
            );
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.nullable(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.nullable(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.nullable(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
      group('var', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.late(.var_(.fields))));
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.var_(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(.late(.var_(.initialized(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.var_(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.var_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.var_(.private(.fields)))),
            );
          });
        });
      });
      group('final', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.late(.final_(.fields))));
        });
        group('Dynamic', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.final_(.dynamic(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.final_(.dynamic(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .late(.final_(.dynamic(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .late(.final_(.dynamic(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.final_(.dynamic(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.final_(.dynamic(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Typed', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.final_(.typed(.fields)))),
            );
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.final_(.typed(.nullable(.fields)))),
                ),
              );
            });
            group('Initialized', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .late(.final_(.typed(.nullable(.initialized(.fields))))),
                  ),
                );
              });
              group('Public', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .overridden(
                      .late(.final_(
                        .typed(.nullable(.initialized(.public(.fields)))),
                      )),
                    ),
                  );
                });
              });
              group('Private', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .overridden(
                      .late(.final_(
                        .typed(.nullable(.initialized(.private(.fields)))),
                      )),
                    ),
                  );
                });
              });
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .late(.final_(.typed(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .late(.final_(.typed(.nullable(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.final_(.typed(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .late(.final_(.typed(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .late(.final_(.typed(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.final_(.typed(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.final_(.typed(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.final_(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.final_(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.final_(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.final_(.nullable(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.final_(.nullable(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .late(.final_(.nullable(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .late(.final_(.nullable(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(.late(.final_(.nullable(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(.late(.final_(.nullable(.private(.fields))))),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.final_(.public(.fields)))),
            );
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(const .overridden(.late(.final_(.fields))));
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.final_(.private(.fields)))),
            );
          });
        });
      });
    });
    group('var', () {
      test('fields', () {
        expectSortDeclaration(const .overridden(.var_(.fields)));
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.var_(.public(.fields))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.var_(.private(.fields))));
        });
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(
            const .overridden(.var_(.initialized(.fields))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.var_(.initialized(.public(.fields)))),
            );
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.var_(.initialized(.fields))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.var_(.initialized(.private(.fields)))),
            );
          });
        });
      });
    });
    group('final', () {
      test('fields', () {
        expectSortDeclaration(const .overridden(.final_(.fields)));
      });
      group('Dynamic', () {
        test('fields', () {
          expectSortDeclaration(
            const .overridden(.final_(.dynamic(.fields))),
          );
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.final_(.dynamic(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .final_(.dynamic(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .final_(.dynamic(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.final_(.dynamic(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.final_(.dynamic(.private(.fields)))),
            );
          });
        });
      });
      group('Typed', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.final_(.typed(.fields))));
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.final_(.typed(.nullable(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .final_(.typed(.nullable(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .final_(.typed(.nullable(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .final_(.typed(.nullable(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .final_(.typed(.nullable(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .final_(.typed(.nullable(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.final_(.typed(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .final_(.typed(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .final_(.typed(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.final_(.typed(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.final_(.typed(.private(.fields)))),
            );
          });
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.final_(.public(.fields))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.final_(.private(.fields))));
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.final_(.nullable(.fields))));
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.final_(.nullable(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .final_(.nullable(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .final_(.nullable(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.final_(.nullable(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.final_(.nullable(.private(.fields)))),
            );
          });
        });
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(
            const .overridden(.final_(.initialized(.fields))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.final_(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.final_(.initialized(.private(.fields)))),
            );
          });
        });
      });
    });
    group('members', () {
      test('fields', () {
        expectSortDeclaration(const .overridden(.fields));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(const .overridden(.fieldsGettersSetters));
      });
      test('getters', () {
        expectSortDeclaration(const .overridden(.getters));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .overridden(.gettersSetters));
      });
      test('methods', () {
        expectSortDeclaration(const .overridden(.methods));
      });
      test('setters', () {
        expectSortDeclaration(const .overridden(.setters));
      });
    });
  });
}
