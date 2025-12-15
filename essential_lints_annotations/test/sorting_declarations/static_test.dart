import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Static', () {
    test('getters', () {
      expectSortDeclaration(const .static(.getters));
    });
    test('setters', () {
      expectSortDeclaration(const .static(.setters));
    });
    group('Public', () {
      group('members', () {
        test('getters', () {
          expectSortDeclaration(const .static(.public(.getters)));
        });
        test('setters', () {
          expectSortDeclaration(const .static(.public(.setters)));
        });
        test('fields', () {
          expectSortDeclaration(const .static(.public(.fields)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .static(.public(.gettersSetters)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(const .static(.public(.fieldsGettersSetters)));
        });
        test('methods', () {
          expectSortDeclaration(const .static(.public(.methods)));
        });
      });
    });
    group('Private', () {
      group('members', () {
        test('getters', () {
          expectSortDeclaration(const .static(.private(.getters)));
        });
        test('setters', () {
          expectSortDeclaration(const .static(.private(.setters)));
        });
        test('fields', () {
          expectSortDeclaration(const .static(.private(.fields)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .static(.private(.gettersSetters)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .static(.private(.fieldsGettersSetters)),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .static(.private(.methods)));
        });
      });
    });
    group('members', () {
      test('fields', () {
        expectSortDeclaration(const .static(.fields));
      });
      test('methods', () {
        expectSortDeclaration(const .static(.methods));
      });
      test('getters', () {
        expectSortDeclaration(const .static(.getters));
      });
      test('setters', () {
        expectSortDeclaration(const .static(.setters));
      });
    });
    group('Initialized', () {
      test('fields', () {
        expectSortDeclaration(const .static(.initialized(.fields)));
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .static(.initialized(.public(.fields))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(
            const .static(.initialized(.private(.fields))),
          );
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(
            const .static(.initialized(.nullable(.fields))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.initialized(.nullable(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.initialized(.nullable(.private(.fields)))),
            );
          });
        });
      });
    });
    group('Nullable', () {
      test('fields', () {
        expectSortDeclaration(const .static(.nullable(.fields)));
      });
      test('fieldsGettersSetters', () {
        expectSortDeclaration(const .static(.nullable(.fieldsGettersSetters)));
      });
      test('getters', () {
        expectSortDeclaration(const .static(.nullable(.getters)));
      });
      test('gettersSetters', () {
        expectSortDeclaration(const .static(.nullable(.gettersSetters)));
      });
      test('methods', () {
        expectSortDeclaration(const .static(.nullable(.methods)));
      });
      test('setters', () {
        expectSortDeclaration(const .static(.nullable(.setters)));
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(
            const .static(.nullable(.initialized(.fields))),
          );
        });
        test('nullable fields', () {
          expectSortDeclaration(
            const .static(.nullable(.initialized(.nullable(.fields)))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.nullable(.initialized(.public(.fields)))),
            );
          });
          test('nullable fields', () {
            expectSortDeclaration(
              const .static(
                .nullable(.initialized(.nullable(.public(.fields)))),
              ),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.nullable(.initialized(.private(.fields)))),
            );
          });
          test('nullable fields', () {
            expectSortDeclaration(
              const .static(
                .nullable(.initialized(.nullable(.private(.fields)))),
              ),
            );
          });
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .static(.nullable(.public(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .static(.nullable(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .static(.nullable(.public(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .static(.nullable(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .static(.nullable(.public(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .static(.nullable(.public(.setters))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .static(.nullable(.private(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .static(.nullable(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .static(.nullable(.private(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .static(.nullable(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .static(.nullable(.private(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .static(.nullable(.private(.setters))));
        });
      });
    });
    group('final', () {
      test('fields', () {
        expectSortDeclaration(const .static(.final_(.fields)));
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(const .static(.final_(.initialized(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.final_(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.final_(.initialized(.private(.fields)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.final_(.initialized(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(
                  .final_(.initialized(.nullable(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(
                  .final_(.initialized(.nullable(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(const .static(.final_(.nullable(.fields))));
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.final_(.nullable(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(
                  .final_(.nullable(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(
                  .final_(.nullable(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.final_(.nullable(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.final_(.nullable(.private(.fields)))),
            );
          });
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .static(.final_(.public(.fields))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .static(.final_(.private(.fields))));
        });
      });
    });
    group('Const', () {
      test('fields', () {
        expectSortDeclaration(const .static(.const_(.fields)));
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(const .static(.const_(.initialized(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.const_(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.const_(.initialized(.private(.fields)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.const_(.initialized(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(
                  .const_(.initialized(.nullable(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(
                  .const_(.initialized(.nullable(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .static(.const_(.public(.fields))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .static(.const_(.private(.fields))));
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(const .static(.const_(.nullable(.fields))));
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.const_(.nullable(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(
                  .const_(.nullable(.initialized(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(
                  .const_(.nullable(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.const_(.nullable(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.const_(.nullable(.private(.fields)))),
            );
          });
        });
      });
    });
    group('Late', () {
      test('fields', () {
        expectSortDeclaration(const .static(.late(.fields)));
      });
      test('private', () {
        expectSortDeclaration(const .static(.late(.private(.fields))));
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .static(.late(.public(.fields))));
        });
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(const .static(.late(.initialized(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.late(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.late(.initialized(.private(.fields)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.late(.initialized(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(
                  .late(.initialized(.nullable(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(
                  .late(.initialized(.nullable(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(const .static(.late(.nullable(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.late(.nullable(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.late(.nullable(.private(.fields)))),
            );
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.late(.nullable(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(.late(.nullable(.initialized(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(
                  .late(.nullable(.initialized(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
      group('var', () {
        test('fields', () {
          expectSortDeclaration(const .static(.late(.var_(.fields))));
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.late(.var_(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(.late(.var_(.initialized(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(.late(.var_(.initialized(.private(.fields))))),
              );
            });
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(.late(.var_(.initialized(.nullable(.fields))))),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .static(
                    .late(.var_(.initialized(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .static(
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
              const .static(.late(.var_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.late(.var_(.private(.fields)))),
            );
          });
        });
      });
      group('final', () {
        test('fields', () {
          expectSortDeclaration(const .static(.late(.final_(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.late(.final_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.late(.final_(.private(.fields)))),
            );
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.late(.final_(.initialized(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(.late(.final_(.initialized(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(.late(.final_(.initialized(.private(.fields))))),
              );
            });
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(
                  .late(.final_(.initialized(.nullable(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .static(
                    .late(.final_(.initialized(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .static(
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
              const .static(.late(.final_(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(.late(.final_(.nullable(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(.late(.final_(.nullable(.private(.fields))))),
              );
            });
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(.late(.final_(.nullable(.initialized(.fields))))),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .static(
                    .late(.final_(.nullable(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .static(
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
        expectSortDeclaration(const .static(.var_(.fields)));
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(const .static(.var_(.initialized(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.var_(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.var_(.initialized(.private(.fields)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .static(.var_(.initialized(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(.var_(.initialized(.nullable(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .static(
                  .var_(.initialized(.nullable(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .static(.var_(.public(.fields))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .static(.var_(.private(.fields))));
        });
      });
    });
  });
}
