import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Instance', () {
    group('Dynamic', () {
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.dynamic(.fields)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.dynamic(.fieldsGettersSetters)),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .instance(.dynamic(.getters)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .instance(.dynamic(.gettersSetters)));
        });
        test('methods', () {
          expectSortDeclaration(const .instance(.dynamic(.methods)));
        });
        test('setters', () {
          expectSortDeclaration(const .instance(.dynamic(.setters)));
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.dynamic(.public(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.dynamic(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .instance(.dynamic(.public(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .instance(.dynamic(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .instance(.dynamic(.public(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .instance(.dynamic(.public(.setters))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.dynamic(.private(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.dynamic(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .instance(.dynamic(.private(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .instance(.dynamic(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .instance(.dynamic(.private(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .instance(.dynamic(.private(.setters))));
        });
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(
            const .instance(.dynamic(.initialized(.fields))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.dynamic(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.dynamic(.initialized(.private(.fields)))),
            );
          });
        });
      });
    });
    group('Typed', () {
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.typed(.fields)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.typed(.fieldsGettersSetters)),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .instance(.typed(.getters)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .instance(.typed(.gettersSetters)));
        });
        test('methods', () {
          expectSortDeclaration(const .instance(.typed(.methods)));
        });
        test('setters', () {
          expectSortDeclaration(const .instance(.typed(.setters)));
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.typed(.public(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.typed(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .instance(.typed(.public(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .instance(.typed(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .instance(.typed(.public(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .instance(.typed(.public(.setters))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.typed(.private(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.typed(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .instance(.typed(.private(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .instance(.typed(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .instance(.typed(.private(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .instance(.typed(.private(.setters))));
        });
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(
            const .instance(.typed(.initialized(.fields))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.typed(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.typed(.initialized(.private(.fields)))),
            );
          });
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.typed(.nullable(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.typed(.nullable(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .instance(.typed(.nullable(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .instance(.typed(.nullable(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .instance(.typed(.nullable(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .instance(.typed(.nullable(.setters))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.typed(.nullable(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .typed(.nullable(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.typed(.nullable(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.typed(.nullable(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.typed(.nullable(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.typed(.nullable(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.typed(.nullable(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .typed(.nullable(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.typed(.nullable(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.typed(.nullable(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.typed(.nullable(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.typed(.nullable(.private(.setters)))),
            );
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.typed(.nullable(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .typed(.nullable(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .typed(.nullable(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
    });
    group('Abstract', () {
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.abstract(.fields)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.abstract(.fieldsGettersSetters)),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .instance(.abstract(.getters)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .instance(.abstract(.gettersSetters)));
        });
        test('methods', () {
          expectSortDeclaration(const .instance(.abstract(.methods)));
        });
        test('setters', () {
          expectSortDeclaration(const .instance(.abstract(.setters)));
        });
      });
      group('Dynamic', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.abstract(.dynamic(.fields))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(.abstract(.dynamic(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.abstract(.dynamic(.getters))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.abstract(.dynamic(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.abstract(.dynamic(.methods))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.abstract(.dynamic(.setters))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.abstract(.dynamic(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .abstract(.dynamic(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.abstract(.dynamic(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.abstract(.dynamic(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.abstract(.dynamic(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.abstract(.dynamic(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.abstract(.dynamic(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .abstract(.dynamic(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.abstract(.dynamic(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.abstract(.dynamic(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.abstract(.dynamic(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.abstract(.dynamic(.private(.setters)))),
            );
          });
        });
      });
      group('Typed', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.fields))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.getters))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.methods))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.setters))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .abstract(.typed(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .abstract(.typed(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.private(.setters)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.nullable(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .abstract(.typed(.nullable(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.nullable(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.nullable(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.nullable(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.abstract(.typed(.nullable(.setters)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .abstract(.typed(.nullable(.public(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .abstract(
                    .typed(.nullable(.public(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(
                  .abstract(.typed(.nullable(.public(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .abstract(.typed(.nullable(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(
                  .abstract(.typed(.nullable(.public(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(
                  .abstract(.typed(.nullable(.public(.setters)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .abstract(.typed(.nullable(.private(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .abstract(
                    .typed(.nullable(.private(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(
                  .abstract(.typed(.nullable(.private(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .abstract(.typed(.nullable(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(
                  .abstract(.typed(.nullable(.private(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(
                  .abstract(.typed(.nullable(.private(.setters)))),
                ),
              );
            });
          });
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(
            const .instance(.abstract(.nullable(.fields))),
          );
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.abstract(.nullable(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .instance(.abstract(.nullable(.getters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .instance(.abstract(.nullable(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .instance(.abstract(.nullable(.methods))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .instance(.abstract(.nullable(.setters))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.abstract(.nullable(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .abstract(.nullable(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.abstract(.nullable(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.abstract(.nullable(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.abstract(.nullable(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.abstract(.nullable(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.abstract(.nullable(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .abstract(.nullable(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.abstract(.nullable(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.abstract(.nullable(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.abstract(.nullable(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.abstract(.nullable(.private(.setters)))),
            );
          });
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.abstract(.public(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.abstract(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .instance(.abstract(.public(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .instance(.abstract(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .instance(.abstract(.public(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .instance(.abstract(.public(.setters))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.abstract(.private(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.abstract(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .instance(.abstract(.private(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .instance(.abstract(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .instance(.abstract(.private(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .instance(.abstract(.private(.setters))));
        });
      });
      group('Operator', () {
        test('methods', () {
          expectSortDeclaration(
            const .instance(.abstract(.operator(.methods))),
          );
        });
        group('Dynamic', () {
          test('methods', () {
            expectSortDeclaration(
              const .instance(.abstract(.operator(.dynamic(.methods)))),
            );
          });
        });
        group('Typed', () {
          test('methods', () {
            expectSortDeclaration(
              const .instance(.abstract(.operator(.typed(.methods)))),
            );
          });
          group('Nullable', () {
            test('methods', () {
              expectSortDeclaration(
                const .instance(
                  .abstract(.operator(.typed(.nullable(.methods)))),
                ),
              );
            });
          });
        });
        group('Nullable', () {
          test('methods', () {
            expectSortDeclaration(
              const .instance(.abstract(.operator(.nullable(.methods)))),
            );
          });
        });
      });
      group('var', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.abstract(.var_(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.abstract(.var_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.abstract(.var_(.private(.fields)))),
            );
          });
        });
      });
      group('final', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.abstract(.final_(.fields))));
        });
        group('Dynamic', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.abstract(.final_(.dynamic(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .abstract(.final_(.dynamic(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .abstract(.final_(.dynamic(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Typed', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.abstract(.final_(.typed(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.abstract(.final_(.typed(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .abstract(.final_(.typed(.private(.fields)))),
                ),
              );
            });
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .abstract(.final_(.typed(.nullable(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .abstract(.final_(.typed(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .abstract(.final_(.typed(.nullable(.private(.fields))))),
                  ),
                );
              });
            });
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.abstract(.final_(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .abstract(.final_(.nullable(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .abstract(.final_(.nullable(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.abstract(.final_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.abstract(.final_(.private(.fields)))),
            );
          });
        });
      });
    });
    group('Public', () {
      group('members', () {
        test('getters', () {
          expectSortDeclaration(const .instance(.public(.getters)));
        });
        test('setters', () {
          expectSortDeclaration(const .instance(.public(.setters)));
        });
        test('fields', () {
          expectSortDeclaration(const .instance(.public(.fields)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .instance(.public(.gettersSetters)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.public(.fieldsGettersSetters)),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .instance(.public(.methods)));
        });
      });
    });
    group('Private', () {
      group('members', () {
        test('getters', () {
          expectSortDeclaration(const .instance(.private(.getters)));
        });
        test('setters', () {
          expectSortDeclaration(const .instance(.private(.setters)));
        });
        test('fields', () {
          expectSortDeclaration(const .instance(.private(.fields)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .instance(.private(.gettersSetters)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.private(.fieldsGettersSetters)),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .instance(.private(.methods)));
        });
      });
    });
    group('members', () {
      test('fields', () {
        expectSortDeclaration(const .instance(.fields));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(
          const .instance(.fieldsGettersSetters),
        );
      });
      test('methods', () {
        expectSortDeclaration(const .instance(.methods));
      });
      test('getters', () {
        expectSortDeclaration(const .instance(.getters));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .instance(.gettersSetters));
      });
      test('setters', () {
        expectSortDeclaration(const .instance(.setters));
      });
    });
    group('Initialized', () {
      test('fields', () {
        expectSortDeclaration(const .instance(.initialized(.fields)));
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(
            const .instance(.initialized(.public(.fields))),
          );
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(
            const .instance(.initialized(.private(.fields))),
          );
        });
      });
    });
    group('Nullable', () {
      test('fields', () {
        expectSortDeclaration(const .instance(.nullable(.fields)));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(
          const .instance(.nullable(.fieldsGettersSetters)),
        );
      });
      test('getters', () {
        expectSortDeclaration(const .instance(.nullable(.getters)));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .instance(.nullable(.gettersSetters)));
      });
      test('methods', () {
        expectSortDeclaration(const .instance(.nullable(.methods)));
      });
      test('setters', () {
        expectSortDeclaration(const .instance(.nullable(.setters)));
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(
            const .instance(.nullable(.initialized(.fields))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.nullable(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.nullable(.initialized(.private(.fields)))),
            );
          });
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.nullable(.public(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.nullable(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .instance(.nullable(.public(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .instance(.nullable(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .instance(.nullable(.public(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .instance(.nullable(.public(.setters))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.nullable(.private(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.nullable(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .instance(.nullable(.private(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .instance(.nullable(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .instance(.nullable(.private(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .instance(.nullable(.private(.setters))));
        });
      });
    });
    group('final', () {
      test('fields', () {
        expectSortDeclaration(const .instance(.final_(.fields)));
      });
      group('Dynamic', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.final_(.dynamic(.fields))));
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.final_(.dynamic(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .final_(.dynamic(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .final_(.dynamic(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.final_(.dynamic(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.final_(.dynamic(.private(.fields)))),
            );
          });
        });
      });
      group('Typed', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.final_(.typed(.fields))));
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.final_(.typed(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .final_(.typed(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .final_(.typed(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.final_(.typed(.nullable(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .final_(.typed(.nullable(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .final_(.typed(.nullable(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
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
                const .instance(.final_(.typed(.nullable(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.final_(.typed(.nullable(.private(.fields))))),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.final_(.typed(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.final_(.typed(.private(.fields)))),
            );
          });
        });
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(
            const .instance(.final_(.initialized(.fields))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.final_(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.final_(.initialized(.private(.fields)))),
            );
          });
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.final_(.nullable(.fields))));
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.final_(.nullable(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .final_(.nullable(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .final_(.nullable(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.final_(.nullable(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.final_(.nullable(.private(.fields)))),
            );
          });
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.final_(.public(.fields))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.final_(.private(.fields))));
        });
      });
    });
    group('Late', () {
      test('fields', () {
        expectSortDeclaration(const .instance(.late(.fields)));
      });
      test('private', () {
        expectSortDeclaration(const .instance(.late(.private(.fields))));
      });
      group('Dynamic', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.late(.dynamic(.fields))));
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.dynamic(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .late(.dynamic(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .late(.dynamic(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.dynamic(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.dynamic(.private(.fields)))),
            );
          });
        });
      });
      group('Typed', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.late(.typed(.fields))));
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.typed(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.late(.typed(.initialized(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .late(.typed(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.typed(.nullable(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .late(.typed(.nullable(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .late(.typed(.nullable(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .late(.typed(.nullable(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.late(.typed(.nullable(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.late(.typed(.nullable(.private(.fields))))),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.typed(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.typed(.private(.fields)))),
            );
          });
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.late(.public(.fields))));
        });
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.late(.initialized(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.initialized(.private(.fields)))),
            );
          });
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.late(.nullable(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.nullable(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.nullable(.private(.fields)))),
            );
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.nullable(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .late(.nullable(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .late(.nullable(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
      group('var', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.late(.var_(.fields))));
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.var_(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.late(.var_(.initialized(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.late(.var_(.initialized(.private(.fields))))),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.var_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.var_(.private(.fields)))),
            );
          });
        });
      });
      group('final', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.late(.final_(.fields))));
        });
        group('Dynamic', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.final_(.dynamic(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .late(.final_(.dynamic(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .late(.final_(.dynamic(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .late(.final_(.dynamic(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.late(.final_(.dynamic(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.late(.final_(.dynamic(.private(.fields))))),
              );
            });
          });
        });
        group('Typed', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.final_(.typed(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.late(.final_(.typed(.initialized(.fields))))),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .late(.final_(.typed(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .late(.final_(.typed(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.late(.final_(.typed(.nullable(.fields))))),
              );
            });
            group('Initialized', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .late(.final_(.typed(.nullable(.initialized(.fields))))),
                  ),
                );
              });
              group('Public', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .late(
                        .final_(
                          .typed(.nullable(.initialized(.public(.fields)))),
                        ),
                      ),
                    ),
                  );
                });
              });
              group('Private', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .late(
                        .final_(
                          .typed(.nullable(.initialized(.private(.fields)))),
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
                  const .instance(
                    .late(.final_(.typed(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .late(.final_(.typed(.nullable(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.late(.final_(.typed(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.late(.final_(.typed(.private(.fields))))),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.final_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.final_(.private(.fields)))),
            );
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.final_(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.late(.final_(.initialized(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .late(.final_(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.late(.final_(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.late(.final_(.nullable(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.late(.final_(.nullable(.private(.fields))))),
              );
            });
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .late(.final_(.nullable(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .late(.final_(.nullable(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .late(
                      .final_(.nullable(.initialized(.private(.fields)))),
                    ),
                  ),
                );
              });
            });
          });
        });
      });
    });
    group('var', () {
      test('fields', () {
        expectSortDeclaration(const .instance(.var_(.fields)));
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.var_(.initialized(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.var_(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.var_(.initialized(.private(.fields)))),
            );
          });
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.var_(.public(.fields))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.var_(.private(.fields))));
        });
      });
    });
    group('Operator', () {
      test('methods', () {
        expectSortDeclaration(const .instance(.operator(.methods)));
        expectSortDeclaration(const .instance(.operator()));
      });
      group('Dynamic', () {
        test('methods', () {
          expectSortDeclaration(
            const .instance(.operator(.dynamic(.methods))),
          );
        });
      });
      group('Typed', () {
        test('methods', () {
          expectSortDeclaration(
            const .instance(.operator(.typed(.methods))),
          );
        });
        group('Nullable', () {
          test('methods', () {
            expectSortDeclaration(
              const .instance(.operator(.typed(.nullable(.methods)))),
            );
          });
        });
      });
      group('Nullable', () {
        test('methods', () {
          expectSortDeclaration(
            const .instance(.operator(.nullable(.methods))),
          );
          expectSortDeclaration(const .instance(.operator(.nullable())));
        });
      });
    });
    group('Overridden', () {
      test('overridden', () {
        expectSortDeclaration(const .instance(.overridden(.fields)));
      });
      test('getters', () {
        expectSortDeclaration(const .instance(.overridden(.getters)));
      });
      group('Dynamic', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.dynamic(.fields))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(.overridden(.dynamic(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.overridden(.dynamic(.getters))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.overridden(.dynamic(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.overridden(.dynamic(.methods))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.overridden(.dynamic(.setters))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.dynamic(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .overridden(.dynamic(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.overridden(.dynamic(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.overridden(.dynamic(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.overridden(.dynamic(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.overridden(.dynamic(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.dynamic(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .overridden(.dynamic(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.overridden(.dynamic(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.overridden(.dynamic(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.overridden(.dynamic(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.overridden(.dynamic(.private(.setters)))),
            );
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.dynamic(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.dynamic(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.dynamic(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
      group('Typed', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.fields))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.getters))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.methods))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.setters))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .overridden(.typed(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .overridden(.typed(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.private(.setters)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.nullable(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .overridden(.typed(.nullable(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.nullable(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.nullable(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.nullable(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.nullable(.setters)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.typed(.nullable(.public(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(
                    .typed(.nullable(.public(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.typed(.nullable(.public(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.typed(.nullable(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.typed(.nullable(.public(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.typed(.nullable(.public(.setters)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.typed(.nullable(.private(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(
                    .typed(.nullable(.private(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.typed(.nullable(.private(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.typed(.nullable(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.typed(.nullable(.private(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.typed(.nullable(.private(.setters)))),
                ),
              );
            });
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.typed(.nullable(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .typed(.nullable(.initialized(.public(.fields)))),
                    ),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .typed(.nullable(.initialized(.private(.fields)))),
                    ),
                  ),
                );
              });
            });
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.typed(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.typed(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.typed(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.overridden(.public(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.overridden(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .instance(.overridden(.public(.getters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .instance(.overridden(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .instance(.overridden(.public(.methods))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .instance(.overridden(.public(.setters))),
          );
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(
            const .instance(.overridden(.private(.fields))),
          );
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.overridden(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .instance(.overridden(.private(.getters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .instance(.overridden(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .instance(.overridden(.private(.methods))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .instance(.overridden(.private(.setters))),
          );
        });
      });
      group('Initialized', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.initialized(.fields))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.initialized(.private(.fields)))),
            );
          });
        });
      });
      group('Nullable', () {
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.overridden(.nullable(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .instance(.overridden(.nullable(.getters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .instance(.overridden(.nullable(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .instance(.overridden(.nullable(.methods))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .instance(.overridden(.nullable(.setters))),
          );
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.nullable(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.nullable(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.nullable(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.nullable(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .overridden(.nullable(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.overridden(.nullable(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.overridden(.nullable(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.overridden(.nullable(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.overridden(.nullable(.public(.setters)))),
            );
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.nullable(.fields))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.nullable(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .overridden(.nullable(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.overridden(.nullable(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .overridden(.nullable(.private(.gettersSetters))),
              ),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.overridden(.nullable(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.overridden(.nullable(.private(.setters)))),
            );
          });
        });
      });
      group('Abstract', () {
        group('Dynamic', () {
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.overridden(.abstract(.dynamic(.fields)))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.dynamic(.fieldsGettersSetters))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(.overridden(.abstract(.dynamic(.getters)))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.dynamic(.gettersSetters))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(.overridden(.abstract(.dynamic(.methods)))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(.overridden(.abstract(.dynamic(.setters)))),
              );
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.dynamic(.public(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(
                    .abstract(.dynamic(.public(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.dynamic(.public(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.dynamic(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.dynamic(.public(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.dynamic(.public(.setters)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.dynamic(.private(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(
                    .abstract(.dynamic(.private(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.dynamic(.private(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.dynamic(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.dynamic(.private(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.dynamic(.private(.setters)))),
                ),
              );
            });
          });
        });
        group('Typed', () {
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.overridden(.abstract(.typed(.fields)))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.typed(.fieldsGettersSetters))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(.overridden(.abstract(.typed(.getters)))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.typed(.gettersSetters))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(.overridden(.abstract(.typed(.methods)))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(.overridden(.abstract(.typed(.setters)))),
              );
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.typed(.public(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(
                    .abstract(.typed(.public(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.typed(.public(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.typed(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.typed(.public(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.typed(.public(.setters)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.typed(.private(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(
                    .abstract(.typed(.private(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.typed(.private(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.typed(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.typed(.private(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.typed(.private(.setters)))),
                ),
              );
            });
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.typed(.nullable(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(
                    .abstract(.typed(.nullable(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.typed(.nullable(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.typed(.nullable(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.typed(.nullable(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.typed(.nullable(.setters)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(.abstract(.typed(.nullable(.public(.fields))))),
                  ),
                );
              });
              test('fieldsGettersSetters', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .abstract(
                        .typed(.nullable(.public(.fieldsGettersSetters))),
                      ),
                    ),
                  ),
                );
              });
              test('getters', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .abstract(.typed(.nullable(.public(.getters)))),
                    ),
                  ),
                );
              });
              test('gettersSetters', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .abstract(.typed(.nullable(.public(.gettersSetters)))),
                    ),
                  ),
                );
              });
              test('methods', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .abstract(.typed(.nullable(.public(.methods)))),
                    ),
                  ),
                );
              });
              test('setters', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .abstract(.typed(.nullable(.public(.setters)))),
                    ),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .abstract(.typed(.nullable(.private(.fields)))),
                    ),
                  ),
                );
              });
              test('fieldsGettersSetters', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .abstract(
                        .typed(.nullable(.private(.fieldsGettersSetters))),
                      ),
                    ),
                  ),
                );
              });
              test('getters', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .abstract(.typed(.nullable(.private(.getters)))),
                    ),
                  ),
                );
              });
              test('gettersSetters', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .abstract(.typed(.nullable(.private(.gettersSetters)))),
                    ),
                  ),
                );
              });
              test('methods', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .abstract(.typed(.nullable(.private(.methods)))),
                    ),
                  ),
                );
              });
              test('setters', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .abstract(.typed(.nullable(.private(.setters)))),
                    ),
                  ),
                );
              });
            });
          });
        });
        group('Public', () {
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .overridden(.abstract(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.public(.gettersSetters)))),
            );
          });
        });
        group('Private', () {
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .overridden(.abstract(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .overridden(.abstract(.private(.gettersSetters))),
              ),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.public(.fields)))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.public(.getters)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.public(.setters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.public(.methods)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.private(.fields)))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.private(.getters)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.private(.setters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.private(.methods)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.nullable(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .overridden(.abstract(.nullable(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.nullable(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .overridden(.abstract(.nullable(.gettersSetters))),
              ),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.nullable(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.nullable(.setters)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.nullable(.public(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(
                    .abstract(.nullable(.public(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.nullable(.public(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.nullable(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.nullable(.public(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.nullable(.public(.setters)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.nullable(.private(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(
                    .abstract(.nullable(.private(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.nullable(.private(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.nullable(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.nullable(.private(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.nullable(.private(.setters)))),
                ),
              );
            });
          });
        });
        group('operator', () {
          test('methods', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.operator(.methods)))),
            );
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.operator()))),
            );
          });
          group('Dynamic', () {
            test('methods', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.operator(.dynamic(.methods)))),
                ),
              );
            });
          });
          group('Typed', () {
            test('methods', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.operator(.typed(.methods)))),
                ),
              );
            });
            group('Nullable', () {
              test('methods', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .abstract(.operator(.typed(.nullable(.methods)))),
                    ),
                  ),
                );
              });
            });
          });
          group('Nullable', () {
            test('methods', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.operator(.nullable(.methods)))),
                ),
              );
              expectSortDeclaration(
                const .instance(.overridden(.abstract(.operator(.nullable())))),
              );
            });
          });
        });
        group('members', () {
          test('methods', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.methods))),
            );
          });
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.fields))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .overridden(.abstract(.fieldsGettersSetters)),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.getters))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.gettersSetters))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.setters))),
            );
          });
        });
        group('var', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.var_(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.var_(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.var_(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('final', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.abstract(.final_(.fields)))),
            );
          });
          group('Dynamic', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.final_(.dynamic(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(.abstract(.final_(.dynamic(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .abstract(.final_(.dynamic(.private(.fields)))),
                    ),
                  ),
                );
              });
            });
          });
          group('Typed', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.final_(.typed(.fields)))),
                ),
              );
            });
            group('Nullable', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(.abstract(.final_(.typed(.nullable(.fields))))),
                  ),
                );
              });
              group('Public', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .overridden(
                        .abstract(.final_(.typed(.nullable(.public(.fields))))),
                      ),
                    ),
                  );
                });
              });
              group('Private', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .overridden(
                        .abstract(
                          .final_(.typed(.nullable(.private(.fields)))),
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
                  const .instance(
                    .overridden(.abstract(.final_(.typed(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(.abstract(.final_(.typed(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.final_(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.final_(.private(.fields)))),
                ),
              );
            });
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.abstract(.final_(.nullable(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .abstract(.final_(.nullable(.public(.fields)))),
                    ),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .abstract(.final_(.nullable(.private(.fields)))),
                    ),
                  ),
                );
              });
            });
          });
        });
      });
      group('Operator', () {
        test('methods', () {
          expectSortDeclaration(
            const .instance(.overridden(.operator(.methods))),
          );
          expectSortDeclaration(const .instance(.overridden(.operator())));
        });
        group('Dynamic', () {
          test('methods', () {
            expectSortDeclaration(
              const .instance(.overridden(.operator(.dynamic(.methods)))),
            );
          });
        });
        group('Typed', () {
          test('methods', () {
            expectSortDeclaration(
              const .instance(.overridden(.operator(.typed(.methods)))),
            );
          });
          group('Nullable', () {
            test('methods', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.operator(.typed(.nullable(.methods)))),
                ),
              );
            });
          });
        });
        group('Nullable', () {
          test('methods', () {
            expectSortDeclaration(
              const .instance(.overridden(.operator(.nullable(.methods)))),
            );
            expectSortDeclaration(
              const .instance(.overridden(.operator(.nullable()))),
            );
          });
        });
      });
      group('Late', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.overridden(.late(.fields))));
        });
        group('Dynamic', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.late(.dynamic(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.late(.dynamic(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .late(.dynamic(.initialized(.public(.fields)))),
                    ),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .late(.dynamic(.initialized(.private(.fields)))),
                    ),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.overridden(.late(.dynamic(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.late(.dynamic(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Typed', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.late(.typed(.fields)))),
            );
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.overridden(.late(.typed(.nullable(.fields))))),
              );
            });
            group('Initialized', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .late(.typed(.nullable(.initialized(.fields)))),
                    ),
                  ),
                );
              });
              group('Public', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .overridden(
                        .late(
                          .typed(.nullable(.initialized(.public(.fields)))),
                        ),
                      ),
                    ),
                  );
                });
              });
              group('Private', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .overridden(
                        .late(
                          .typed(.nullable(.initialized(.private(.fields)))),
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
                  const .instance(
                    .overridden(.late(.typed(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(.late(.typed(.nullable(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.late(.typed(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(.late(.typed(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(.late(.typed(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.overridden(.late(.typed(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.overridden(.late(.typed(.private(.fields))))),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.late(.public(.fields)))),
            );
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(const .instance(.overridden(.late(.fields))));
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.late(.private(.fields)))),
            );
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.late(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.late(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.late(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.late(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.late(.nullable(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.late(.nullable(.private(.fields)))),
                ),
              );
            });
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.late(.nullable(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .late(.nullable(.initialized(.public(.fields)))),
                    ),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .late(.nullable(.initialized(.private(.fields)))),
                    ),
                  ),
                );
              });
            });
          });
        });
        group('var', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.late(.var_(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.late(.var_(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(.late(.var_(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(.late(.var_(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.overridden(.late(.var_(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.overridden(.late(.var_(.private(.fields))))),
              );
            });
          });
        });
        group('final', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.late(.final_(.fields)))),
            );
          });
          group('Dynamic', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.overridden(.late(.final_(.dynamic(.fields))))),
              );
            });
            group('Initialized', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .late(.final_(.dynamic(.initialized(.fields)))),
                    ),
                  ),
                );
              });
              group('Public', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .overridden(
                        .late(
                          .final_(.dynamic(.initialized(.public(.fields)))),
                        ),
                      ),
                    ),
                  );
                });
              });
              group('Private', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .overridden(
                        .late(
                          .final_(.dynamic(.initialized(.private(.fields)))),
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
                  const .instance(
                    .overridden(.late(.final_(.dynamic(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(.late(.final_(.dynamic(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Typed', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.overridden(.late(.final_(.typed(.fields))))),
              );
            });
            group('Nullable', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(.late(.final_(.typed(.nullable(.fields))))),
                  ),
                );
              });
              group('Initialized', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .overridden(
                        .late(
                          .final_(.typed(.nullable(.initialized(.fields)))),
                        ),
                      ),
                    ),
                  );
                });
                group('Public', () {
                  test('fields', () {
                    expectSortDeclaration(
                      const .instance(
                        .overridden(
                          .late(
                            .final_(
                              .typed(.nullable(.initialized(.public(.fields)))),
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
                      const .instance(
                        .overridden(
                          .late(
                            .final_(
                              .typed(
                                .nullable(.initialized(.private(.fields))),
                              ),
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
                    const .instance(
                      .overridden(
                        .late(.final_(.typed(.nullable(.public(.fields))))),
                      ),
                    ),
                  );
                });
              });
              group('Private', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .overridden(
                        .late(.final_(.typed(.nullable(.private(.fields))))),
                      ),
                    ),
                  );
                });
              });
            });
            group('Initialized', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(.late(.final_(.typed(.initialized(.fields))))),
                  ),
                );
              });
              group('Public', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .overridden(
                        .late(.final_(.typed(.initialized(.public(.fields))))),
                      ),
                    ),
                  );
                });
              });
              group('Private', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .overridden(
                        .late(.final_(.typed(.initialized(.private(.fields))))),
                      ),
                    ),
                  );
                });
              });
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(.late(.final_(.typed(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(.late(.final_(.typed(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.late(.final_(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(.late(.final_(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .late(.final_(.initialized(.private(.fields)))),
                    ),
                  ),
                );
              });
            });
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.late(.final_(.nullable(.fields)))),
                ),
              );
            });
            group('Initialized', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .late(.final_(.nullable(.initialized(.fields)))),
                    ),
                  ),
                );
              });
              group('Public', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .overridden(
                        .late(
                          .final_(.nullable(.initialized(.public(.fields)))),
                        ),
                      ),
                    ),
                  );
                });
              });
              group('Private', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .overridden(
                        .late(
                          .final_(.nullable(.initialized(.private(.fields)))),
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
                  const .instance(
                    .overridden(.late(.final_(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(.late(.final_(.nullable(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.overridden(.late(.final_(.public(.fields))))),
              );
            });
          });
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.overridden(.late(.final_(.fields)))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.overridden(.late(.final_(.private(.fields))))),
              );
            });
          });
        });
      });
      group('var', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.overridden(.var_(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.var_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.var_(.private(.fields)))),
            );
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.var_(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.var_(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.overridden(.var_(.initialized(.fields)))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.var_(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
      group('final', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.overridden(.final_(.fields))));
        });
        group('Dynamic', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.final_(.dynamic(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.final_(.dynamic(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .final_(.dynamic(.initialized(.public(.fields)))),
                    ),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
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
                const .instance(
                  .overridden(.final_(.dynamic(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.final_(.dynamic(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Typed', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.final_(.typed(.fields)))),
            );
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.final_(.typed(.nullable(.fields)))),
                ),
              );
            });
            group('Initialized', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .final_(.typed(.nullable(.initialized(.fields)))),
                    ),
                  ),
                );
              });
              group('Public', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .overridden(
                        .final_(
                          .typed(.nullable(.initialized(.public(.fields)))),
                        ),
                      ),
                    ),
                  );
                });
              });
              group('Private', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .overridden(
                        .final_(
                          .typed(.nullable(.initialized(.private(.fields)))),
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
                  const .instance(
                    .overridden(.final_(.typed(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(.final_(.typed(.nullable(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.final_(.typed(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .final_(.typed(.initialized(.public(.fields)))),
                    ),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
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
                const .instance(.overridden(.final_(.typed(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.final_(.typed(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.final_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.final_(.private(.fields)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.final_(.nullable(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.final_(.nullable(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .final_(.nullable(.initialized(.public(.fields)))),
                    ),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .overridden(
                      .final_(.nullable(.initialized(.private(.fields)))),
                    ),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.final_(.nullable(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.final_(.nullable(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.overridden(.final_(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.final_(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .overridden(.final_(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.overridden(.fields)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.overridden(.fieldsGettersSetters)),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .instance(.overridden(.getters)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .instance(.overridden(.gettersSetters)));
        });
        test('methods', () {
          expectSortDeclaration(const .instance(.overridden(.methods)));
        });
        test('setters', () {
          expectSortDeclaration(const .instance(.overridden(.setters)));
        });
      });
    });
    group('New', () {
      group('Dynamic', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(const .instance(.new_(.dynamic(.fields))));
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.dynamic(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(const .instance(.new_(.dynamic(.getters))));
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.dynamic(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(const .instance(.new_(.dynamic(.methods))));
          });
          test('setters', () {
            expectSortDeclaration(const .instance(.new_(.dynamic(.setters))));
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.dynamic(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.dynamic(.public(.fieldsGettersSetters)))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.new_(.dynamic(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.dynamic(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.new_(.dynamic(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.new_(.dynamic(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.dynamic(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.dynamic(.private(.fieldsGettersSetters)))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.new_(.dynamic(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.dynamic(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.new_(.dynamic(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.new_(.dynamic(.private(.setters)))),
            );
          });
        });
        group('Initialized', () {
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.dynamic(.initialized(.fields)))),
              );
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.dynamic(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.dynamic(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
      group('Typed', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(const .instance(.new_(.typed(.fields))));
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.typed(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(const .instance(.new_(.typed(.getters))));
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.typed(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(const .instance(.new_(.typed(.methods))));
          });
          test('setters', () {
            expectSortDeclaration(const .instance(.new_(.typed(.setters))));
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.typed(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.typed(.public(.fieldsGettersSetters)))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.new_(.typed(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.typed(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.new_(.typed(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.new_(.typed(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.typed(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.typed(.private(.fieldsGettersSetters)))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.new_(.typed(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.typed(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.new_(.typed(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.new_(.typed(.private(.setters)))),
            );
          });
        });
        group('Initialized', () {
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.typed(.initialized(.fields)))),
              );
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.typed(.initialized(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.typed(.initialized(.private(.fields))))),
              );
            });
          });
        });
        group('Nullable', () {
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.typed(.nullable(.fields)))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.typed(.nullable(.fieldsGettersSetters))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(.new_(.typed(.nullable(.getters)))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(.new_(.typed(.nullable(.gettersSetters)))),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(.new_(.typed(.nullable(.methods)))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(.new_(.typed(.nullable(.setters)))),
              );
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.typed(.nullable(.public(.fields))))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.typed(.nullable(.public(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(.new_(.typed(.nullable(.public(.getters))))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.typed(.nullable(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(.new_(.typed(.nullable(.public(.methods))))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(.new_(.typed(.nullable(.public(.setters))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.typed(.nullable(.private(.fields))))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.typed(.nullable(.private(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(.new_(.typed(.nullable(.private(.getters))))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.typed(.nullable(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(.new_(.typed(.nullable(.private(.methods))))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(.new_(.typed(.nullable(.private(.setters))))),
              );
            });
          });
          group('Initialized', () {
            group('members', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.typed(.nullable(.initialized(.fields)))),
                  ),
                );
              });
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.typed(.nullable(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.typed(.nullable(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.new_(.public(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.new_(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .instance(.new_(.public(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .instance(.new_(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .instance(.new_(.public(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .instance(.new_(.public(.setters))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.new_(.private(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.new_(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .instance(.new_(.private(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .instance(.new_(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .instance(.new_(.private(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .instance(.new_(.private(.setters))));
        });
      });
      group('Initialized', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.initialized(.fields))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.initialized(.private(.fields)))),
            );
          });
        });
      });
      group('Nullable', () {
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .instance(.new_(.nullable(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .instance(.new_(.nullable(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .instance(.new_(.nullable(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .instance(.new_(.nullable(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .instance(.new_(.nullable(.setters))));
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.nullable(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.nullable(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.nullable(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.nullable(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.nullable(.public(.fieldsGettersSetters)))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.new_(.nullable(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.nullable(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.new_(.nullable(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.new_(.nullable(.public(.setters)))),
            );
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(const .instance(.new_(.nullable(.fields))));
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.nullable(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .new_(.nullable(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.new_(.nullable(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.nullable(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.new_(.nullable(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.new_(.nullable(.private(.setters)))),
            );
          });
        });
      });
      group('Abstract', () {
        group('Dynamic', () {
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.dynamic(.fields)))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.abstract(.dynamic(.fieldsGettersSetters))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.dynamic(.getters)))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.dynamic(.gettersSetters)))),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.dynamic(.methods)))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.dynamic(.setters)))),
              );
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.dynamic(.public(.fields))))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.abstract(.dynamic(.public(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.dynamic(.public(.getters))))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.abstract(.dynamic(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.dynamic(.public(.methods))))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.dynamic(.public(.setters))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.dynamic(.private(.fields))))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.abstract(.dynamic(.private(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.dynamic(.private(.getters))))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.abstract(.dynamic(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.dynamic(.private(.methods))))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.dynamic(.private(.setters))))),
              );
            });
          });
        });
        group('Typed', () {
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.typed(.fields)))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.abstract(.typed(.fieldsGettersSetters))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.typed(.getters)))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.typed(.gettersSetters)))),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.typed(.methods)))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.typed(.setters)))),
              );
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.typed(.public(.fields))))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.abstract(.typed(.public(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.typed(.public(.getters))))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.abstract(.typed(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.typed(.public(.methods))))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.typed(.public(.setters))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.typed(.private(.fields))))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.abstract(.typed(.private(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.typed(.private(.getters))))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.abstract(.typed(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.typed(.private(.methods))))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.typed(.private(.setters))))),
              );
            });
          });
          group('Nullable', () {
            group('members', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(.new_(.abstract(.typed(.nullable(.fields))))),
                );
              });
              test('fieldsGettersSetters', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.typed(.nullable(.fieldsGettersSetters)))),
                  ),
                );
              });
              test('getters', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.typed(.nullable(.getters)))),
                  ),
                );
              });
              test('gettersSetters', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.typed(.nullable(.gettersSetters)))),
                  ),
                );
              });
              test('methods', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.typed(.nullable(.methods)))),
                  ),
                );
              });
              test('setters', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.typed(.nullable(.setters)))),
                  ),
                );
              });
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.typed(.nullable(.public(.fields))))),
                  ),
                );
              });
              test('fieldsGettersSetters', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(
                      .abstract(
                        .typed(.nullable(.public(.fieldsGettersSetters))),
                      ),
                    ),
                  ),
                );
              });
              test('getters', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.typed(.nullable(.public(.getters))))),
                  ),
                );
              });
              test('gettersSetters', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(
                      .abstract(.typed(.nullable(.public(.gettersSetters)))),
                    ),
                  ),
                );
              });
              test('methods', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.typed(.nullable(.public(.methods))))),
                  ),
                );
              });
              test('setters', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.typed(.nullable(.public(.setters))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.typed(.nullable(.private(.fields))))),
                  ),
                );
              });
              test('fieldsGettersSetters', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(
                      .abstract(
                        .typed(.nullable(.private(.fieldsGettersSetters))),
                      ),
                    ),
                  ),
                );
              });
              test('getters', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.typed(.nullable(.private(.getters))))),
                  ),
                );
              });
              test('gettersSetters', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(
                      .abstract(.typed(.nullable(.private(.gettersSetters)))),
                    ),
                  ),
                );
              });
              test('methods', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.typed(.nullable(.private(.methods))))),
                  ),
                );
              });
              test('setters', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.typed(.nullable(.private(.setters))))),
                  ),
                );
              });
            });
          });
        });
        group('Public', () {
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.public(.fieldsGettersSetters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.public(.gettersSetters)))),
            );
          });
        });
        group('Private', () {
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .new_(.abstract(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.private(.gettersSetters)))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.public(.fields)))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.public(.getters)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.public(.setters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.public(.methods)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.private(.fields)))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.private(.getters)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.private(.setters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.private(.methods)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.nullable(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(
                .new_(.abstract(.nullable(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.nullable(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.nullable(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.nullable(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.nullable(.setters)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.nullable(.public(.fields))))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.abstract(.nullable(.public(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.nullable(.public(.getters))))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.abstract(.nullable(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.nullable(.public(.methods))))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.nullable(.public(.setters))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.nullable(.private(.fields))))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.abstract(.nullable(.private(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.abstract(.nullable(.private(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.abstract(.nullable(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.abstract(.nullable(.private(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.abstract(.nullable(.private(.setters)))),
                ),
              );
            });
          });
        });
        group('Operator', () {
          group('Dynamic', () {
            test('methods', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.abstract(.operator(.dynamic(.methods)))),
                ),
              );
              expectSortDeclaration(
                const .instance(.new_(.abstract(.operator(.dynamic())))),
              );
            });
          });
          group('Typed', () {
            test('methods', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.operator(.typed(.methods))))),
              );
              expectSortDeclaration(
                const .instance(.new_(.abstract(.operator(.typed())))),
              );
            });
            group('Nullable', () {
              test('methods', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.operator(.typed(.nullable(.methods))))),
                  ),
                );
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.operator(.typed(.nullable())))),
                  ),
                );
              });
            });
          });
          test('methods', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.operator(.methods)))),
            );
            expectSortDeclaration(
              const .instance(.new_(.abstract(.operator()))),
            );
          });
          group('Nullable', () {
            test('methods', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.abstract(.operator(.nullable(.methods)))),
                ),
              );
              expectSortDeclaration(
                const .instance(.new_(.abstract(.operator(.nullable())))),
              );
            });
          });
        });
        group('members', () {
          test('methods', () {
            expectSortDeclaration(const .instance(.new_(.abstract(.methods))));
          });
          test('fields', () {
            expectSortDeclaration(const .instance(.new_(.abstract(.fields))));
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(const .instance(.new_(.abstract(.getters))));
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.gettersSetters))),
            );
          });
          test('setters', () {
            expectSortDeclaration(const .instance(.new_(.abstract(.setters))));
          });
        });
        group('var', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.var_(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.var_(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.var_(.private(.fields))))),
              );
            });
          });
        });
        group('final', () {
          group('Dynamic', () {
            group('members', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(.new_(.abstract(.final_(.dynamic(.fields))))),
                );
              });
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.final_(.dynamic(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.final_(.dynamic(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Typed', () {
            group('members', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(.new_(.abstract(.final_(.typed(.fields))))),
                );
              });
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.final_(.typed(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.final_(.typed(.private(.fields))))),
                  ),
                );
              });
            });
            group('Nullable', () {
              group('members', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .new_(.abstract(.final_(.typed(.nullable(.fields))))),
                    ),
                  );
                });
              });
              group('Public', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .new_(
                        .abstract(.final_(.typed(.nullable(.public(.fields))))),
                      ),
                    ),
                  );
                });
              });
              group('Private', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .new_(
                        .abstract(
                          .final_(.typed(.nullable(.private(.fields)))),
                        ),
                      ),
                    ),
                  );
                });
              });
            });
          });
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.abstract(.final_(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.final_(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.final_(.private(.fields))))),
              );
            });
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.abstract(.final_(.nullable(.fields))))),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.final_(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.abstract(.final_(.nullable(.private(.fields))))),
                  ),
                );
              });
            });
          });
        });
      });
      group('Operator', () {
        test('methods', () {
          expectSortDeclaration(const .instance(.new_(.operator(.methods))));
          expectSortDeclaration(const .instance(.new_(.operator())));
        });
        group('Dynamic', () {
          test('methods', () {
            expectSortDeclaration(
              const .instance(.new_(.operator(.dynamic(.methods)))),
            );
          });
        });
        group('Typed', () {
          test('methods', () {
            expectSortDeclaration(
              const .instance(.new_(.operator(.typed(.methods)))),
            );
          });
          group('Nullable', () {
            test('methods', () {
              expectSortDeclaration(
                const .instance(.new_(.operator(.typed(.nullable(.methods))))),
              );
            });
          });
        });
        group('Nullable', () {
          test('methods', () {
            expectSortDeclaration(
              const .instance(.new_(.operator(.nullable(.methods)))),
            );
            expectSortDeclaration(
              const .instance(.new_(.operator(.nullable()))),
            );
          });
        });
      });
      group('Late', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.new_(.late(.fields))));
        });
        group('Dynamic', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.late(.dynamic(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.dynamic(.initialized(.fields))))),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.late(.dynamic(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.late(.dynamic(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.dynamic(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.dynamic(.private(.fields))))),
              );
            });
          });
        });
        group('Typed', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.late(.typed(.fields)))),
            );
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.typed(.nullable(.fields))))),
              );
            });
            group('Initialized', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.late(.typed(.nullable(.initialized(.fields))))),
                  ),
                );
              });
              group('Public', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .new_(
                        .late(
                          .typed(.nullable(.initialized(.public(.fields)))),
                        ),
                      ),
                    ),
                  );
                });
              });
              group('Private', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .new_(
                        .late(
                          .typed(.nullable(.initialized(.private(.fields)))),
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
                  const .instance(
                    .new_(.late(.typed(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.late(.typed(.nullable(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.typed(.initialized(.fields))))),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.late(.typed(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.late(.typed(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.typed(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.typed(.private(.fields))))),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.late(.public(.fields)))),
            );
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(const .instance(.new_(.late(.fields))));
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.late(.private(.fields)))),
            );
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.late(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.initialized(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.initialized(.private(.fields))))),
              );
            });
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.late(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.nullable(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.nullable(.private(.fields))))),
              );
            });
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.nullable(.initialized(.fields))))),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.late(.nullable(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.late(.nullable(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
        });
        group('var', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.late(.var_(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.var_(.initialized(.fields))))),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.late(.var_(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.late(.var_(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.var_(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.var_(.private(.fields))))),
              );
            });
          });
        });
        group('final', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.late(.final_(.fields)))),
            );
          });
          group('Dynamic', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.final_(.dynamic(.fields))))),
              );
            });
            group('Initialized', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.late(.final_(.dynamic(.initialized(.fields))))),
                  ),
                );
              });
              group('Public', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .new_(
                        .late(
                          .final_(.dynamic(.initialized(.public(.fields)))),
                        ),
                      ),
                    ),
                  );
                });
              });
              group('Private', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .new_(
                        .late(
                          .final_(.dynamic(.initialized(.private(.fields)))),
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
                  const .instance(
                    .new_(.late(.final_(.dynamic(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.late(.final_(.dynamic(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Typed', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.final_(.typed(.fields))))),
              );
            });
            group('Nullable', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.late(.final_(.typed(.nullable(.fields))))),
                  ),
                );
              });
              group('Initialized', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .new_(
                        .late(
                          .final_(.typed(.nullable(.initialized(.fields)))),
                        ),
                      ),
                    ),
                  );
                });
                group('Public', () {
                  test('fields', () {
                    expectSortDeclaration(
                      const .instance(
                        .new_(
                          .late(
                            .final_(
                              .typed(.nullable(.initialized(.public(.fields)))),
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
                      const .instance(
                        .new_(
                          .late(
                            .final_(
                              .typed(
                                .nullable(.initialized(.private(.fields))),
                              ),
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
                    const .instance(
                      .new_(
                        .late(.final_(.typed(.nullable(.public(.fields))))),
                      ),
                    ),
                  );
                });
              });
              group('Private', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .new_(
                        .late(.final_(.typed(.nullable(.private(.fields))))),
                      ),
                    ),
                  );
                });
              });
            });
            group('Initialized', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.late(.final_(.typed(.initialized(.fields))))),
                  ),
                );
              });
              group('Public', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .new_(
                        .late(.final_(.typed(.initialized(.public(.fields))))),
                      ),
                    ),
                  );
                });
              });
              group('Private', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .new_(
                        .late(.final_(.typed(.initialized(.private(.fields))))),
                      ),
                    ),
                  );
                });
              });
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.late(.final_(.typed(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.late(.final_(.typed(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.final_(.initialized(.fields))))),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.late(.final_(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.late(.final_(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.final_(.nullable(.fields))))),
              );
            });
            group('Initialized', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.late(.final_(.nullable(.initialized(.fields))))),
                  ),
                );
              });
              group('Public', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .new_(
                        .late(
                          .final_(.nullable(.initialized(.public(.fields)))),
                        ),
                      ),
                    ),
                  );
                });
              });
              group('Private', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .new_(
                        .late(
                          .final_(.nullable(.initialized(.private(.fields)))),
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
                  const .instance(
                    .new_(.late(.final_(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.late(.final_(.nullable(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.final_(.public(.fields))))),
              );
            });
          });
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.final_(.fields)))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.late(.final_(.private(.fields))))),
              );
            });
          });
        });
      });
      group('var', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.new_(.var_(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.var_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.var_(.private(.fields)))),
            );
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.var_(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.var_(.initialized(.public(.fields))))),
              );
            });
          });
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.var_(.initialized(.fields)))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.var_(.initialized(.private(.fields))))),
              );
            });
          });
        });
      });
      group('final', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.new_(.final_(.fields))));
        });
        group('Dynamic', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.final_(.dynamic(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.final_(.dynamic(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.final_(.dynamic(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.final_(.dynamic(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.final_(.dynamic(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.final_(.dynamic(.private(.fields))))),
              );
            });
          });
        });
        group('Typed', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.final_(.typed(.fields)))),
            );
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.final_(.typed(.nullable(.fields))))),
              );
            });
            group('Initialized', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.final_(.typed(.nullable(.initialized(.fields))))),
                  ),
                );
              });
              group('Public', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .new_(
                        .final_(
                          .typed(.nullable(.initialized(.public(.fields)))),
                        ),
                      ),
                    ),
                  );
                });
              });
              group('Private', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .instance(
                      .new_(
                        .final_(
                          .typed(.nullable(.initialized(.private(.fields)))),
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
                  const .instance(
                    .new_(.final_(.typed(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.final_(.typed(.nullable(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.final_(.typed(.initialized(.fields))))),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.final_(.typed(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.final_(.typed(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.final_(.typed(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.final_(.typed(.private(.fields))))),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.final_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.final_(.private(.fields)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.final_(.nullable(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.final_(.nullable(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.final_(.nullable(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .instance(
                    .new_(.final_(.nullable(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.final_(.nullable(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.final_(.nullable(.private(.fields))))),
              );
            });
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .instance(.new_(.final_(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(.new_(.final_(.initialized(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .instance(
                  .new_(.final_(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .instance(.new_(.fields)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(const .instance(.new_(.fieldsGettersSetters)));
        });
        test('getters', () {
          expectSortDeclaration(const .instance(.new_(.getters)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .instance(.new_(.gettersSetters)));
        });
        test('methods', () {
          expectSortDeclaration(const .instance(.new_(.methods)));
        });
        test('setters', () {
          expectSortDeclaration(const .instance(.new_(.setters)));
        });
      });
    });
  });
}
