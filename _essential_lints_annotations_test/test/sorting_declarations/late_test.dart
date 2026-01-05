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
      group('Dynamic', () {
        test('fields', () {
          expectSortDeclaration(const .late(.final_(.dynamic(.fields))));
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.final_(.dynamic(.private(.fields)))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.final_(.dynamic(.public(.fields)))),
            );
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.final_(.dynamic(.initialized(.fields)))),
            );
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .late(.final_(.dynamic(.initialized(.private(.fields))))),
              );
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .late(.final_(.dynamic(.initialized(.public(.fields))))),
              );
            });
          });
        });
      });
      group('Typed', () {
        test('fields', () {
          expectSortDeclaration(const .late(.final_(.typed(.fields))));
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.final_(.typed(.private(.fields)))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.final_(.typed(.public(.fields)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.final_(.typed(.nullable(.fields)))),
            );
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .late(.final_(.typed(.nullable(.private(.fields))))),
              );
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .late(.final_(.typed(.nullable(.public(.fields))))),
              );
            });
          });
          group('Initialized', () {
            test('fields', () {
              expectSortDeclaration(
                const .late(.final_(.typed(.nullable(.initialized(.fields))))),
              );
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .late(
                    .final_(.typed(.nullable(.initialized(.private(.fields))))),
                  ),
                );
              });
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .late(
                    .final_(.typed(.nullable(.initialized(.public(.fields))))),
                  ),
                );
              });
            });
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.final_(.typed(.initialized(.fields)))),
            );
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .late(.final_(.typed(.initialized(.private(.fields))))),
              );
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .late(.final_(.typed(.initialized(.public(.fields))))),
              );
            });
          });
        });
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
      });
    });
    group('Dynamic', () {
      test('fields', () {
        expectSortDeclaration(const .late(.dynamic(.fields)));
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(
            const .late(.dynamic(.private(.fields))),
          );
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(
            const .late(.dynamic(.public(.fields))),
          );
        });
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(
            const .late(.dynamic(.initialized(.fields))),
          );
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.dynamic(.initialized(.private(.fields)))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.dynamic(.initialized(.public(.fields)))),
            );
          });
        });
      });
    });
    group('Typed', () {
      test('fields', () {
        expectSortDeclaration(const .late(.typed(.fields)));
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(
            const .late(.typed(.private(.fields))),
          );
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(
            const .late(.typed(.public(.fields))),
          );
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(
            const .late(.typed(.nullable(.fields))),
          );
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.typed(.nullable(.private(.fields)))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.typed(.nullable(.public(.fields)))),
            );
          });
        });
        group('Initialized', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.typed(.nullable(.initialized(.fields)))),
            );
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .late(
                  .typed(.nullable(.initialized(.private(.fields)))),
                ),
              );
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .late(
                  .typed(.nullable(.initialized(.public(.fields)))),
                ),
              );
            });
          });
        });
      });
      group('Initialized', () {
        test('fields', () {
          expectSortDeclaration(
            const .late(.typed(.initialized(.fields))),
          );
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.typed(.initialized(.private(.fields)))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .late(.typed(.initialized(.public(.fields)))),
            );
          });
        });
      });
    });
  });
}
