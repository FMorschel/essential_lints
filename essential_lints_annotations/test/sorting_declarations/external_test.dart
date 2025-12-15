import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('External', () {
    group('operator', () {
      test('methods', () {
        expectSortDeclaration(const .external(.operator(.methods)));
      });
      group('Nullable', () {
        test('methods', () {
          expectSortDeclaration(
            const .external(.operator(.nullable(.methods))),
          );
        });
      });
    });
    group('Public', () {
      test('fields', () {
        expectSortDeclaration(const .external(.public(.fields)));
      });
      test('getters', () {
        expectSortDeclaration(const .external(.public(.getters)));
      });
      test('setters', () {
        expectSortDeclaration(const .external(.public(.setters)));
      });
    });
    group('Private', () {
      test('fields', () {
        expectSortDeclaration(const .external(.private(.fields)));
      });
      test('getters', () {
        expectSortDeclaration(const .external(.private(.getters)));
      });
      test('setters', () {
        expectSortDeclaration(const .external(.private(.setters)));
      });
    });
    group('Nullable', () {
      test('fieldsGettersSetters', () {
        expectSortDeclaration(
          const .external(.nullable(.fieldsGettersSetters)),
        );
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .external(.nullable(.gettersSetters)));
      });
      test('methods', () {
        expectSortDeclaration(const .external(.nullable(.methods)));
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .external(.nullable(.public(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.nullable(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .external(.nullable(.public(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .external(.nullable(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .external(.nullable(.public(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.nullable(.public(.setters))));
        });
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .external(.nullable(.fields)));
        });
        test('getters', () {
          expectSortDeclaration(const .external(.nullable(.getters)));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.nullable(.setters)));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .external(.nullable(.private(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.nullable(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .external(.nullable(.private(.getters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .external(.nullable(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .external(.nullable(.private(.methods))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .external(.nullable(.private(.setters))),
          );
        });
      });
    });
    group('var', () {
      test('fields', () {
        expectSortDeclaration(const .external(.var_(.fields)));
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .external(.var_(.public(.fields))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .external(.var_(.private(.fields))));
        });
      });
    });
    group('final', () {
      test('fields', () {
        expectSortDeclaration(const .external(.final_(.fields)));
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .external(.final_(.public(.fields))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .external(.final_(.private(.fields))));
        });
      });
      group('Nullable', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.final_(.nullable(.fields))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.final_(.nullable(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.final_(.nullable(.private(.fields)))),
            );
          });
        });
      });
    });
    group('Public', () {
      group('members', () {
        test('constructors', () {
          expectSortDeclaration(const .external(.public(.constructors)));
        });
        test('fields', () {
          expectSortDeclaration(const .external(.public(.fields)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.public(.fieldsGettersSetters)),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .external(.public(.getters)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .external(.public(.gettersSetters)));
        });
        test('methods', () {
          expectSortDeclaration(const .external(.public(.methods)));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.public(.setters)));
        });
      });
    });
    group('Private', () {
      test('constructors', () {
        expectSortDeclaration(const .external(.private(.constructors)));
      });
      test('fields', () {
        expectSortDeclaration(const .external(.private(.fields)));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(
          const .external(.private(.fieldsGettersSetters)),
        );
      });
      test('getters', () {
        expectSortDeclaration(const .external(.private(.getters)));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .external(.private(.gettersSetters)));
      });
      test('methods', () {
        expectSortDeclaration(const .external(.private(.methods)));
      });
      test('setters', () {
        expectSortDeclaration(const .external(.private(.setters)));
      });
    });
    group('Unnamed', () {
      test('constructors', () {
        expectSortDeclaration(const .external(.unnamed(.constructors)));
      });
    });
    group('Named', () {
      test('constructors', () {
        expectSortDeclaration(const .external(.named(.constructors)));
      });
      group('Public', () {
        test('constructors', () {
          expectSortDeclaration(
            const .external(.named(.public(.constructors))),
          );
        });
      });
      group('Private', () {
        test('constructors', () {
          expectSortDeclaration(
            const .external(.named(.private(.constructors))),
          );
        });
      });
    });
    group('Factory', () {
      test('constructors', () {
        expectSortDeclaration(const .external(.factory_(.constructors)));
      });
      group('Public', () {
        test('constructors', () {
          expectSortDeclaration(
            const .external(.factory_(.public(.constructors))),
          );
        });
      });
      group('Private', () {
        test('constructors', () {
          expectSortDeclaration(
            const .external(.factory_(.private(.constructors))),
          );
        });
      });
      group('Unnamed', () {
        test('constructors', () {
          expectSortDeclaration(
            const .external(.factory_(.unnamed(.constructors))),
          );
        });
      });
      group('Named', () {
        test('constructors', () {
          expectSortDeclaration(
            const .external(.factory_(.named(.constructors))),
          );
        });
        group('Public', () {
          test('constructors', () {
            expectSortDeclaration(
              const .external(.factory_(.named(.public(.constructors)))),
            );
          });
        });
        group('Private', () {
          test('constructors', () {
            expectSortDeclaration(
              const .external(.factory_(.named(.private(.constructors)))),
            );
          });
        });
      });
      group('Redirecting', () {
        test('constructors', () {
          expectSortDeclaration(
            const .external(.factory_(.redirecting(.constructors))),
          );
        });
        group('Unnamed', () {
          test('constructors', () {
            expectSortDeclaration(
              const .external(.factory_(.redirecting(.unnamed(.constructors)))),
            );
          });
        });
        group('Named', () {
          test('constructors', () {
            expectSortDeclaration(
              const .external(.factory_(.redirecting(.named(.constructors)))),
            );
          });
          group('Public', () {
            test('constructors', () {
              expectSortDeclaration(
                const .external(
                  .factory_(.redirecting(.named(.public(.constructors)))),
                ),
              );
            });
          });
          group('Private', () {
            test('constructors', () {
              expectSortDeclaration(
                const .external(
                  .factory_(.redirecting(.named(.private(.constructors)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('constructors', () {
            expectSortDeclaration(
              const .external(
                .factory_(.redirecting(.public(.constructors))),
              ),
            );
          });
        });
        group('Private', () {
          test('constructors', () {
            expectSortDeclaration(
              const .external(
                .factory_(.redirecting(.private(.constructors))),
              ),
            );
          });
        });
      });
    });
    group('members', () {
      test('constructors', () {
        expectSortDeclaration(const .external(.constructors));
      });
      test('fields', () {
        expectSortDeclaration(const .external(.fields));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(const .external(.fieldsGettersSetters));
      });
      test('getters', () {
        expectSortDeclaration(const .external(.getters));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .external(.gettersSetters));
      });
      test('methods', () {
        expectSortDeclaration(const .external(.methods));
      });
      test('setters', () {
        expectSortDeclaration(const .external(.setters));
      });
    });

    group('Static', () {
      test('fields', () {
        expectSortDeclaration(const .external(.static(.fields)));
      });
      test('getters', () {
        expectSortDeclaration(const .external(.static(.getters)));
      });
      test('setters', () {
        expectSortDeclaration(const .external(.static(.setters)));
      });
      test('methods', () {
        expectSortDeclaration(const .external(.static(.methods)));
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .external(.static(.public(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.static(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .external(.static(.public(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .external(.static(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .external(.static(.public(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.static(.public(.setters))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .external(.static(.private(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.static(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .external(.static(.private(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .external(.static(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .external(.static(.private(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.static(.private(.setters))));
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(const .external(.static(.nullable(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.static(.nullable(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .external(.static(.nullable(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .external(.static(.nullable(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .external(.static(.nullable(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.static(.nullable(.setters))));
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.static(.nullable(.initialized(.fields)))),
            );
          });
          test('nullable fields', () {
            expectSortDeclaration(
              const .external(
                .static(.nullable(.initialized(.nullable(.fields)))),
              ),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .static(.nullable(.initialized(.public(.fields)))),
                ),
              );
            });
            test('nullable fields', () {
              expectSortDeclaration(
                const .external(
                  .static(.nullable(.initialized(.nullable(.public(.fields))))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .static(.nullable(.initialized(.private(.fields)))),
                ),
              );
            });
            test('nullable fields', () {
              expectSortDeclaration(
                const .external(
                  .static(
                    .nullable(.initialized(.nullable(.private(.fields)))),
                  ),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.static(.nullable(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .static(.nullable(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.static(.nullable(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.static(.nullable(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.static(.nullable(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.static(.nullable(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.static(.nullable(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .static(.nullable(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.static(.nullable(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.static(.nullable(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.static(.nullable(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.static(.nullable(.private(.setters)))),
            );
          });
        });
      });
      group('final', () {
        test('fields', () {
          expectSortDeclaration(const .external(.static(.final_(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.static(.final_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.static(.final_(.private(.fields)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.static(.final_(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.static(.final_(.nullable(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.static(.final_(.nullable(.private(.fields))))),
              );
            });
          });
        });
      });
      group('var', () {
        test('fields', () {
          expectSortDeclaration(const .external(.static(.var_(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.static(.var_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.static(.var_(.private(.fields)))),
            );
          });
        });
      });
    });
  });
}
