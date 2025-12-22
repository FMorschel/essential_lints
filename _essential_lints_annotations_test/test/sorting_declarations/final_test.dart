import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Final', () {
    test('final_', () {
      expectSortDeclaration(const .final_(.fields));
    });
    group('members', () {
      test('fields', () {
        expectSortDeclaration(const .final_(.fields));
      });
    });
    group('Initialized', () {
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .final_(.initialized(.public(.fields))));
        });
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .final_(.initialized(.fields)));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(
            const .final_(.initialized(.private(.fields))),
          );
        });
      });
    });
    group('Public', () {
      test('fields', () {
        expectSortDeclaration(const .final_(.public(.fields)));
      });
    });
    group('Private', () {
      test('fields', () {
        expectSortDeclaration(const .final_(.private(.fields)));
      });
    });
    group('Nullable', () {
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .final_(.nullable(.public(.fields))));
        });
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .final_(.nullable(.fields)));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .final_(.nullable(.private(.fields))));
        });
      });
      group('Initialized', () {
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .final_(.nullable(.initialized(.public(.fields)))),
            );
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .final_(.nullable(.initialized(.fields))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .final_(.nullable(.initialized(.private(.fields)))),
            );
          });
        });
      });
    });
    group('Dynamic', () {
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .final_(.dynamic(.public(.fields))));
        });
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .final_(.dynamic(.fields)));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .final_(.dynamic(.private(.fields))));
        });
      });
      group('Initialized', () {
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .final_(.dynamic(.initialized(.public(.fields)))),
            );
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .final_(.dynamic(.initialized(.fields))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .final_(.dynamic(.initialized(.private(.fields)))),
            );
          });
        });
      });
    });
    group('Typed', () {
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .final_(.typed(.public(.fields))));
        });
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .final_(.typed(.fields)));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .final_(.typed(.private(.fields))));
        });
      });
      group('Initialized', () {
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .final_(.typed(.initialized(.public(.fields)))),
            );
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .final_(.typed(.initialized(.fields))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .final_(.typed(.initialized(.private(.fields)))),
            );
          });
        });
        group('Nullable', () {
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .final_(.typed(.nullable(.public(.fields)))),
              );
            });
          });
          group('members', () {
            test('fields', () {
              expectSortDeclaration(const .final_(.typed(.nullable(.fields))));
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .final_(.typed(.nullable(.private(.fields)))),
              );
            });
          });
          group('Initialized', () {
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .final_(
                    .typed(.nullable(.initialized(.public(.fields)))),
                  ),
                );
              });
            });
            group('members', () {
              test('fields', () {
                expectSortDeclaration(
                  const .final_(.typed(.nullable(.initialized(.fields)))),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .final_(
                    .typed(.nullable(.initialized(.private(.fields)))),
                  ),
                );
              });
            });
          });
        });
      });
    });
  });
}
