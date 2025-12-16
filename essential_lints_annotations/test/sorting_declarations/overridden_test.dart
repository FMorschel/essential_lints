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
      group('Var', () {
        test('field', () {
          expectSortDeclaration(
            const .overridden(.initialized(.var_(.fields))),
          );
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.initialized(.var_(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .initialized(.var_(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .initialized(.var_(.initialized(.private(.fields)))),
                ),
              );
            });
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .initialized(.var_(.initialized(.nullable(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .initialized(
                      .var_(.initialized(.nullable(.public(.fields)))),
                    ),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .initialized(
                      .var_(.initialized(.nullable(.private(.fields)))),
                    ),
                  ),
                );
              });
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.initialized(.var_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.initialized(.var_(.private(.fields)))),
            );
          });
        });
      });
      group('Final', () {
        test('field', () {
          expectSortDeclaration(
            const .overridden(.initialized(.final_(.fields))),
          );
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.initialized(.final_(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .initialized(.final_(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .initialized(.final_(.initialized(.private(.fields)))),
                ),
              );
            });
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .initialized(.final_(.initialized(.nullable(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .initialized(
                      .final_(.initialized(.nullable(.public(.fields)))),
                    ),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .initialized(
                      .final_(.initialized(.nullable(.private(.fields)))),
                    ),
                  ),
                );
              });
            });
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.initialized(.final_(.nullable(.fields)))),
            );
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .initialized(.final_(.nullable(.initialized(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .initialized(
                      .final_(.nullable(.initialized(.public(.fields)))),
                    ),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .initialized(
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
                const .overridden(
                  .initialized(.final_(.nullable(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .initialized(.final_(.nullable(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.initialized(.final_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.initialized(.final_(.private(.fields)))),
            );
          });
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
        test('nullable fields', () {
          expectSortDeclaration(
            const .overridden(.nullable(.initialized(.nullable(.fields)))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.nullable(.initialized(.public(.fields)))),
            );
          });
          test('nullable fields', () {
            expectSortDeclaration(
              const .overridden(
                .nullable(.initialized(.nullable(.public(.fields)))),
              ),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.nullable(.initialized(.private(.fields)))),
            );
          });
          test('nullable fields', () {
            expectSortDeclaration(
              const .overridden(
                .nullable(.initialized(.nullable(.private(.fields)))),
              ),
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
    group('External', () {
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(
            const .overridden(.external(.public(.fields))),
          );
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .overridden(.external(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .overridden(.external(.public(.getters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .overridden(.external(.public(.gettersSetters))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .overridden(.external(.public(.setters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .overridden(.external(.public(.methods))),
          );
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(
            const .overridden(.external(.private(.fields))),
          );
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .overridden(.external(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .overridden(.external(.private(.getters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .overridden(.external(.private(.gettersSetters))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .overridden(.external(.private(.setters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .overridden(.external(.private(.methods))),
          );
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(
            const .overridden(.external(.nullable(.fields))),
          );
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .overridden(.external(.nullable(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .overridden(.external(.nullable(.getters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .overridden(.external(.nullable(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .overridden(.external(.nullable(.methods))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .overridden(.external(.nullable(.setters))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.external(.nullable(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .overridden(
                .external(.nullable(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .overridden(.external(.nullable(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .overridden(.external(.nullable(.public(.gettersSetters)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .overridden(.external(.nullable(.public(.setters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .overridden(.external(.nullable(.public(.methods)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.external(.nullable(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .overridden(
                .external(.nullable(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .overridden(.external(.nullable(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .overridden(
                .external(.nullable(.private(.gettersSetters))),
              ),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .overridden(.external(.nullable(.private(.setters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .overridden(.external(.nullable(.private(.methods)))),
            );
          });
        });
      });
      group('operator', () {
        test('methods', () {
          expectSortDeclaration(
            const .overridden(.external(.operator(.methods))),
          );
          expectSortDeclaration(const .overridden(.external(.operator())));
        });
        group('Nullable', () {
          test('methods', () {
            expectSortDeclaration(
              const .overridden(.external(.operator(.nullable(.methods)))),
            );
            expectSortDeclaration(
              const .overridden(.external(.operator(.nullable()))),
            );
          });
        });
      });
      group('var', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.external(.var_(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.external(.var_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.external(.var_(.private(.fields)))),
            );
          });
        });
      });
      group('final', () {
        test('fields', () {
          expectSortDeclaration(
            const .overridden(.external(.final_(.fields))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.external(.final_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.external(.final_(.private(.fields)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.external(.final_(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .external(.final_(.nullable(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .external(.final_(.nullable(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .overridden(.external(.fields)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .overridden(.external(.fieldsGettersSetters)),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .overridden(.external(.getters)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .overridden(.external(.gettersSetters)));
        });
        test('methods', () {
          expectSortDeclaration(const .overridden(.external(.methods)));
        });
        test('setters', () {
          expectSortDeclaration(const .overridden(.external(.setters)));
        });
      });
    });
    group('Abstract', () {
      test('getters', () {
        expectSortDeclaration(const .overridden(.abstract(.getters)));
      });
      test('setters', () {
        expectSortDeclaration(const .overridden(.abstract(.setters)));
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
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.abstract(.nullable(.initialized(.fields)))),
            );
          });
          test('nullable fields', () {
            expectSortDeclaration(
              const .overridden(
                .abstract(.nullable(.initialized(.nullable(.fields)))),
              ),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(.nullable(.initialized(.public(.fields)))),
                ),
              );
            });
            test('nullable fields', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(
                    .nullable(.initialized(.nullable(.public(.fields)))),
                  ),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(.nullable(.initialized(.private(.fields)))),
                ),
              );
            });
            test('nullable fields', () {
              expectSortDeclaration(
                const .overridden(
                  .abstract(
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
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.late(.initialized(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.initialized(.nullable(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.initialized(.nullable(.private(.fields)))),
                ),
              );
            });
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
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.var_(.initialized(.nullable(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .late(.var_(.initialized(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .late(.var_(.initialized(.nullable(.private(.fields))))),
                  ),
                );
              });
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
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .late(.final_(.initialized(.nullable(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .late(.final_(.initialized(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .overridden(
                    .late(.final_(.initialized(.nullable(.private(.fields))))),
                  ),
                );
              });
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
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.var_(.initialized(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .var_(.initialized(.nullable(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .var_(.initialized(.nullable(.private(.fields)))),
                ),
              );
            });
          });
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
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .overridden(.final_(.initialized(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .final_(.initialized(.nullable(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .overridden(
                  .final_(.initialized(.nullable(.private(.fields)))),
                ),
              );
            });
          });
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
