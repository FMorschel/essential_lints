import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Late', () {
    test('late', () {
      expectSortDeclaration(const .late(.fields));
    });
    group('members', () {
      test('fields', () {
        expectSortDeclaration(const .late(.fields));
      });
    });
    group('Public', () {
      test('fields', () {
        expectSortDeclaration(const .late(.public(.fields)));
      });
    });
    group('Private', () {
      test('fields', () {
        expectSortDeclaration(const .late(.private(.fields)));
      });
    });
    group('Initialized', () {
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .late(.initialized(.public(.fields))));
        });
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .late(.initialized(.fields)));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .late(.initialized(.private(.fields))));
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(const .late(.initialized(.nullable(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.initialized(.nullable(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.initialized(.nullable(.private(.fields)))),
            );
          });
        });
      });
    });
    group('Nullable', () {
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .late(.nullable(.public(.fields))));
        });
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .late(.nullable(.fields)));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .late(.nullable(.private(.fields))));
        });
      });
      group('Initialized', () {
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.nullable(.initialized(.public(.fields)))),
            );
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.nullable(.initialized(.fields))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.nullable(.initialized(.private(.fields)))),
            );
          });
        });
      });
    });
    group('var', () {
      test('fields', () {
        expectSortDeclaration(const .late(.var_(.fields)));
      });
    });
    group('final', () {
      test('fields', () {
        expectSortDeclaration(const .late(.final_(.fields)));
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .late(.final_(.public(.fields))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .late(.final_(.private(.fields))));
        });
      });
      group('Initialized', () {
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.final_(.initialized(.public(.fields)))),
            );
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(const .late(.final_(.initialized(.fields))));
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.final_(.initialized(.private(.fields)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.final_(.initialized(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .late(.final_(.initialized(.nullable(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .late(
                  .final_(.initialized(.nullable(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
      group('Nullable', () {
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.final_(.nullable(.public(.fields)))),
            );
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(const .late(.final_(.nullable(.fields))));
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.final_(.nullable(.private(.fields)))),
            );
          });
        });
        group('Initialized', () {
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .late(.final_(.nullable(.initialized(.public(.fields))))),
              );
            });
          });
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .late(.final_(.nullable(.initialized(.fields)))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .late(
                  .final_(.nullable(.initialized(.private(.fields)))),
                ),
              );
            });
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .late(
                  .final_(.nullable(.initialized(.nullable(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .late(
                    .final_(
                      .nullable(.initialized(.nullable(.public(.fields)))),
                    ),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .late(
                    .final_(
                      .nullable(.initialized(.nullable(.private(.fields)))),
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
        expectSortDeclaration(const .late(.var_(.fields)));
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .late(.var_(.public(.fields))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .late(.var_(.private(.fields))));
        });
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(const .late(.var_(.initialized(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.var_(.initialized(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.var_(.initialized(.private(.fields)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.var_(.initialized(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .late(.var_(.initialized(.nullable(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .late(.var_(.initialized(.nullable(.private(.fields))))),
              );
            });
          });
        });
      });
    });
  });
}
