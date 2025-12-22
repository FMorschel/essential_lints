import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Abstract', () {
    group('Typed', () {
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .abstract(.typed(.fields)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .abstract(.typed(.fieldsGettersSetters)),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .abstract(.typed(.getters)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .abstract(.typed(.gettersSetters)));
        });
        test('methods', () {
          expectSortDeclaration(const .abstract(.typed(.methods)));
        });
        test('setters', () {
          expectSortDeclaration(const .abstract(.typed(.setters)));
        });
      });
      group('Nullable', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(const .abstract(.typed(.nullable(.fields))));
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .abstract(.typed(.nullable(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(const .abstract(.typed(.nullable(.getters))));
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .abstract(.typed(.nullable(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(const .abstract(.typed(.nullable(.methods))));
          });
          test('setters', () {
            expectSortDeclaration(const .abstract(.typed(.nullable(.setters))));
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .abstract(.typed(.nullable(.public(.fields)))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .abstract(.typed(.nullable(.public(.getters)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .abstract(.typed(.nullable(.public(.setters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .abstract(.typed(.nullable(.public(.methods)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .abstract(.typed(.nullable(.public(.gettersSetters)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .abstract(
                .typed(.nullable(.public(.fieldsGettersSetters))),
              ),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .abstract(.typed(.nullable(.private(.fields)))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .abstract(.typed(.nullable(.private(.getters)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .abstract(.typed(.nullable(.private(.setters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .abstract(.typed(.nullable(.private(.methods)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .abstract(.typed(.nullable(.private(.gettersSetters)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .abstract(
                .typed(.nullable(.private(.fieldsGettersSetters))),
              ),
            );
          });
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .abstract(.typed(.public(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .abstract(.typed(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .abstract(.typed(.public(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .abstract(.typed(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .abstract(.typed(.public(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .abstract(.typed(.public(.setters))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .abstract(.typed(.private(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .abstract(.typed(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .abstract(.typed(.private(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .abstract(.typed(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .abstract(.typed(.private(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .abstract(.typed(.private(.setters))));
        });
      });
    });
    group('members', () {
      test('methods', () {
        expectSortDeclaration(const .abstract(.methods));
      });
      test('fields', () {
        expectSortDeclaration(const .abstract(.fields));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(
          const .abstract(.fieldsGettersSetters),
        );
      });
      test('fields', () {
        expectSortDeclaration(const .abstract(.getters));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .abstract(.gettersSetters));
      });
      test('setters', () {
        expectSortDeclaration(const .abstract(.setters));
      });
    });
    group('Nullable', () {
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .abstract(.nullable(.fields)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .abstract(.nullable(.fieldsGettersSetters)),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .abstract(.nullable(.getters)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .abstract(.nullable(.gettersSetters)));
        });
        test('methods', () {
          expectSortDeclaration(const .abstract(.nullable(.methods)));
        });
        test('setters', () {
          expectSortDeclaration(const .abstract(.nullable(.setters)));
        });
      });
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
          expectSortDeclaration(const .abstract(.nullable(.private(.getters))));
        });
        test('setters', () {
          expectSortDeclaration(const .abstract(.nullable(.private(.setters))));
        });
        test('methods', () {
          expectSortDeclaration(const .abstract(.nullable(.private(.methods))));
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
      group('Dynamic', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(const .abstract(.dynamic(.fields)));
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .abstract(.dynamic(.fieldsGettersSetters)),
            );
          });
          test('getters', () {
            expectSortDeclaration(const .abstract(.dynamic(.getters)));
          });
          test('gettersSetters', () {
            expectSortDeclaration(const .abstract(.dynamic(.gettersSetters)));
          });
          test('methods', () {
            expectSortDeclaration(const .abstract(.dynamic(.methods)));
          });
          test('setters', () {
            expectSortDeclaration(const .abstract(.dynamic(.setters)));
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(const .abstract(.dynamic(.public(.fields))));
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .abstract(.dynamic(.public(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(const .abstract(.dynamic(.public(.getters))));
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .abstract(.dynamic(.public(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(const .abstract(.dynamic(.public(.methods))));
          });
          test('setters', () {
            expectSortDeclaration(const .abstract(.dynamic(.public(.setters))));
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(const .abstract(.dynamic(.private(.fields))));
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .abstract(.dynamic(.private(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .abstract(.dynamic(.private(.getters))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .abstract(.dynamic(.private(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .abstract(.dynamic(.private(.methods))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .abstract(.dynamic(.private(.setters))),
            );
          });
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
    group('Operator', () {
      group('Dynamic', () {
        test('methods', () {
          expectSortDeclaration(const .abstract(.operator(.dynamic(.methods))));
          expectSortDeclaration(const .abstract(.operator(.dynamic())));
        });
      });
      group('Typed', () {
        test('methods', () {
          expectSortDeclaration(const .abstract(.operator(.typed(.methods))));
          expectSortDeclaration(const .abstract(.operator(.typed())));
        });
        group('Nullable', () {
          test('methods', () {
            expectSortDeclaration(
              const .abstract(.operator(.typed(.nullable(.methods)))),
            );
            expectSortDeclaration(
              const .abstract(.operator(.typed(.nullable()))),
            );
          });
        });
      });
      group('Nullable', () {
        test('methods', () {
          expectSortDeclaration(
            const .abstract(.operator(.nullable(.methods))),
          );
          expectSortDeclaration(const .abstract(.operator(.nullable())));
        });
        test('methods', () {
          expectSortDeclaration(
            const .abstract(.operator(.methods)),
          );
          expectSortDeclaration(const .abstract(.operator()));
        });
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
        group('Typed', () {
          group('members', () {
            test('fields', () {
              expectSortDeclaration(const .abstract(.final_(.typed(.fields))));
            });
          });
          group('Nullable', () {
            group('members', () {
              test('fields', () {
                expectSortDeclaration(
                  const .abstract(.final_(.typed(.nullable(.fields)))),
                );
              });
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .abstract(.final_(.typed(.nullable(.public(.fields))))),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .abstract(
                    .final_(.typed(.nullable(.private(.fields)))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .abstract(.final_(.typed(.public(.fields)))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .abstract(.final_(.typed(.private(.fields)))),
              );
            });
          });
          group('Dynamic', () {
            test('fields', () {
              expectSortDeclaration(
                const .abstract(.final_(.dynamic(.fields))),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .abstract(.final_(.dynamic(.public(.fields)))),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .abstract(.final_(.dynamic(.private(.fields)))),
                );
              });
            });
          });
        });
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
    group('final', () {
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
}
