import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('External', () {
    group('Instance', () {
      group('Dynamic', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.dynamic(.fields))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.dynamic(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.instance(.dynamic(.getters))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.dynamic(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.dynamic(.methods))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.instance(.dynamic(.setters))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.dynamic(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .instance(.dynamic(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.instance(.dynamic(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.dynamic(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.dynamic(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.instance(.dynamic(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.dynamic(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .instance(.dynamic(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.instance(.dynamic(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.dynamic(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.dynamic(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.instance(.dynamic(.private(.setters)))),
            );
          });
        });
      });
      group('Typed', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(const .external(.instance(.typed(.fields))));
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.typed(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(const .external(.instance(.typed(.getters))));
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.typed(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(const .external(.instance(.typed(.methods))));
          });
          test('setters', () {
            expectSortDeclaration(const .external(.instance(.typed(.setters))));
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.typed(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .instance(.typed(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.instance(.typed(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.typed(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.typed(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.instance(.typed(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.typed(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .instance(.typed(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.instance(.typed(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.typed(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.typed(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.instance(.typed(.private(.setters)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.typed(.nullable(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .instance(.typed(.nullable(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.instance(.typed(.nullable(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.typed(.nullable(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.typed(.nullable(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.instance(.typed(.nullable(.setters)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.typed(.nullable(.public(.fields))))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.typed(.nullable(.public(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.typed(.nullable(.public(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.typed(.nullable(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(
                  .instance(.typed(.nullable(.public(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.typed(.nullable(.public(.setters)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .instance(.typed(.nullable(.private(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.typed(.nullable(.private(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.typed(.nullable(.private(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.typed(.nullable(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(
                  .instance(.typed(.nullable(.private(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.typed(.nullable(.private(.setters)))),
                ),
              );
            });
          });
        });
      });
      group('Public', () {
        group('members', () {
          test('getters', () {
            expectSortDeclaration(
              const .external(.instance(.public(.getters))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.instance(.public(.setters))),
            );
          });
          test('fields', () {
            expectSortDeclaration(const .external(.instance(.public(.fields))));
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.public(.gettersSetters))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.public(.fieldsGettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.public(.methods))),
            );
          });
        });
      });
      group('Private', () {
        group('members', () {
          test('getters', () {
            expectSortDeclaration(
              const .external(.instance(.private(.getters))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.instance(.private(.setters))),
            );
          });
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.private(.fields))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.private(.gettersSetters))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.private(.fieldsGettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.private(.methods))),
            );
          });
        });
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .external(.instance(.fields)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.instance(.fieldsGettersSetters)),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .external(.instance(.methods)));
        });
        test('getters', () {
          expectSortDeclaration(const .external(.instance(.getters)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .external(.instance(.gettersSetters)));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.instance(.setters)));
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(const .external(.instance(.nullable(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.instance(.nullable(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .external(.instance(.nullable(.getters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .external(.instance(.nullable(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .external(.instance(.nullable(.methods))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .external(.instance(.nullable(.setters))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.nullable(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .instance(.nullable(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.instance(.nullable(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.nullable(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.nullable(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.instance(.nullable(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.nullable(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .instance(.nullable(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.instance(.nullable(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.nullable(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.nullable(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.instance(.nullable(.private(.setters)))),
            );
          });
        });
      });
      group('final', () {
        test('fields', () {
          expectSortDeclaration(const .external(.instance(.final_(.fields))));
        });
        group('Dynamic', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.final_(.dynamic(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.final_(.dynamic(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .instance(.final_(.dynamic(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Typed', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.final_(.typed(.fields)))),
            );
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.final_(.typed(.nullable(.fields))))),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.final_(.typed(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.final_(.typed(.nullable(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.final_(.typed(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.final_(.typed(.private(.fields))))),
              );
            });
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.final_(.nullable(.fields)))),
            );
          });

          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .instance(.final_(.nullable(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .instance(.final_(.nullable(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.final_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.final_(.private(.fields)))),
            );
          });
        });
      });
      group('var', () {
        test('fields', () {
          expectSortDeclaration(const .external(.instance(.var_(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.var_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.var_(.private(.fields)))),
            );
          });
        });
      });
      group('Operator', () {
        test('methods', () {
          expectSortDeclaration(
            const .external(.instance(.operator(.methods))),
          );
          expectSortDeclaration(const .external(.instance(.operator())));
        });
        group('Dynamic', () {
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.operator(.dynamic(.methods)))),
            );
          });
        });
        group('Typed', () {
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.operator(.typed(.methods)))),
            );
          });
          group('Nullable', () {
            test('methods', () {
              expectSortDeclaration(
                const .external(
                  .instance(.operator(.typed(.nullable(.methods)))),
                ),
              );
            });
          });
        });
        group('Nullable', () {
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.operator(.nullable(.methods)))),
            );
            expectSortDeclaration(
              const .external(.instance(.operator(.nullable()))),
            );
          });
        });
      });
      group('Overridden', () {
        test('overridden', () {
          expectSortDeclaration(
            const .external(.instance(.overridden(.fields))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .external(.instance(.overridden(.getters))),
          );
        });
        group('Dynamic', () {
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.overridden(.dynamic(.fields)))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.dynamic(.fieldsGettersSetters))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(.instance(.overridden(.dynamic(.getters)))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.dynamic(.gettersSetters))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(.instance(.overridden(.dynamic(.methods)))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(.instance(.overridden(.dynamic(.setters)))),
              );
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.dynamic(.public(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(
                    .overridden(.dynamic(.public(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.dynamic(.public(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.dynamic(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.dynamic(.public(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.dynamic(.public(.setters)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.dynamic(.private(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(
                    .overridden(.dynamic(.private(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.dynamic(.private(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.dynamic(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.dynamic(.private(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.dynamic(.private(.setters)))),
                ),
              );
            });
          });
        });
        group('Typed', () {
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.overridden(.typed(.fields)))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.typed(.fieldsGettersSetters))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(.instance(.overridden(.typed(.getters)))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.typed(.gettersSetters))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(.instance(.overridden(.typed(.methods)))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(.instance(.overridden(.typed(.setters)))),
              );
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.typed(.public(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(
                    .overridden(.typed(.public(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.typed(.public(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.typed(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.typed(.public(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.typed(.public(.setters)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.typed(.private(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(
                    .overridden(.typed(.private(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.typed(.private(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.typed(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.typed(.private(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.typed(.private(.setters)))),
                ),
              );
            });
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.typed(.nullable(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(
                    .overridden(.typed(.nullable(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.typed(.nullable(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.typed(.nullable(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.typed(.nullable(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.typed(.nullable(.setters)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.overridden(.typed(.nullable(.public(.fields))))),
                  ),
                );
              });
              test('fieldsGettersSetters', () {
                expectSortDeclaration(
                  const .external(
                    .instance(
                      .overridden(
                        .typed(.nullable(.public(.fieldsGettersSetters))),
                      ),
                    ),
                  ),
                );
              });
              test('getters', () {
                expectSortDeclaration(
                  const .external(
                    .instance(
                      .overridden(.typed(.nullable(.public(.getters)))),
                    ),
                  ),
                );
              });
              test('gettersSetters', () {
                expectSortDeclaration(
                  const .external(
                    .instance(
                      .overridden(.typed(.nullable(.public(.gettersSetters)))),
                    ),
                  ),
                );
              });
              test('methods', () {
                expectSortDeclaration(
                  const .external(
                    .instance(
                      .overridden(.typed(.nullable(.public(.methods)))),
                    ),
                  ),
                );
              });
              test('setters', () {
                expectSortDeclaration(
                  const .external(
                    .instance(
                      .overridden(.typed(.nullable(.public(.setters)))),
                    ),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .instance(
                      .overridden(.typed(.nullable(.private(.fields)))),
                    ),
                  ),
                );
              });
              test('fieldsGettersSetters', () {
                expectSortDeclaration(
                  const .external(
                    .instance(
                      .overridden(
                        .typed(.nullable(.private(.fieldsGettersSetters))),
                      ),
                    ),
                  ),
                );
              });
              test('getters', () {
                expectSortDeclaration(
                  const .external(
                    .instance(
                      .overridden(.typed(.nullable(.private(.getters)))),
                    ),
                  ),
                );
              });
              test('gettersSetters', () {
                expectSortDeclaration(
                  const .external(
                    .instance(
                      .overridden(.typed(.nullable(.private(.gettersSetters)))),
                    ),
                  ),
                );
              });
              test('methods', () {
                expectSortDeclaration(
                  const .external(
                    .instance(
                      .overridden(.typed(.nullable(.private(.methods)))),
                    ),
                  ),
                );
              });
              test('setters', () {
                expectSortDeclaration(
                  const .external(
                    .instance(
                      .overridden(.typed(.nullable(.private(.setters)))),
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
              const .external(.instance(.overridden(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .instance(.overridden(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.instance(.overridden(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.overridden(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.overridden(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.instance(.overridden(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.overridden(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .instance(.overridden(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.instance(.overridden(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(
                .instance(.overridden(.private(.gettersSetters))),
              ),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.overridden(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.instance(.overridden(.private(.setters)))),
            );
          });
        });
        group('Nullable', () {
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .instance(.overridden(.nullable(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.instance(.overridden(.nullable(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(
                .instance(.overridden(.nullable(.gettersSetters))),
              ),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.overridden(.nullable(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.instance(.overridden(.nullable(.setters)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.nullable(.public(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(
                    .overridden(.nullable(.public(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.nullable(.public(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.nullable(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.nullable(.public(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.nullable(.public(.setters)))),
                ),
              );
            });
          });
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.overridden(.nullable(.fields)))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.nullable(.private(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(
                    .overridden(.nullable(.private(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.nullable(.private(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.nullable(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.nullable(.private(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.nullable(.private(.setters)))),
                ),
              );
            });
          });
        });
        group('Operator', () {
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.overridden(.operator(.methods)))),
            );
            expectSortDeclaration(
              const .external(.instance(.overridden(.operator()))),
            );
          });
          group('Dynamic', () {
            test('methods', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.operator(.dynamic(.methods)))),
                ),
              );
            });
          });
          group('Typed', () {
            test('methods', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.operator(.typed(.methods)))),
                ),
              );
            });
            group('Nullable', () {
              test('methods', () {
                expectSortDeclaration(
                  const .external(
                    .instance(
                      .overridden(.operator(.typed(.nullable(.methods)))),
                    ),
                  ),
                );
              });
            });
          });
          group('Nullable', () {
            test('methods', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.operator(.nullable(.methods)))),
                ),
              );
              expectSortDeclaration(
                const .external(.instance(.overridden(.operator(.nullable())))),
              );
            });
          });
        });
        group('var', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.overridden(.var_(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.var_(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.var_(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('final', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.overridden(.final_(.fields)))),
            );
          });
          group('Dynamic', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.final_(.dynamic(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.overridden(.final_(.dynamic(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .instance(
                      .overridden(.final_(.dynamic(.private(.fields)))),
                    ),
                  ),
                );
              });
            });
          });
          group('Typed', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.final_(.typed(.fields)))),
                ),
              );
            });
            group('Nullable', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.overridden(.final_(.typed(.nullable(.fields))))),
                  ),
                );
              });
              group('Public', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .external(
                      .instance(
                        .overridden(
                          .final_(.typed(.nullable(.public(.fields)))),
                        ),
                      ),
                    ),
                  );
                });
              });
              group('Private', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .external(
                      .instance(
                        .overridden(
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
                  const .external(
                    .instance(.overridden(.final_(.typed(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.overridden(.final_(.typed(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.final_(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.final_(.private(.fields)))),
                ),
              );
            });
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .instance(.overridden(.final_(.nullable(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .instance(
                      .overridden(.final_(.nullable(.public(.fields)))),
                    ),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .instance(
                      .overridden(.final_(.nullable(.private(.fields)))),
                    ),
                  ),
                );
              });
            });
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.overridden(.fields))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.overridden(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.instance(.overridden(.getters))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.overridden(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.overridden(.methods))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.instance(.overridden(.setters))),
            );
          });
        });
      });
      group('New', () {
        group('Dynamic', () {
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.dynamic(.fields)))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.new_(.dynamic(.fieldsGettersSetters))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.dynamic(.getters)))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.dynamic(.gettersSetters)))),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.dynamic(.methods)))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.dynamic(.setters)))),
              );
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.dynamic(.public(.fields))))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.new_(.dynamic(.public(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.dynamic(.public(.getters))))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.new_(.dynamic(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.dynamic(.public(.methods))))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.dynamic(.public(.setters))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.dynamic(.private(.fields))))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.new_(.dynamic(.private(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.dynamic(.private(.getters))))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.new_(.dynamic(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.dynamic(.private(.methods))))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.dynamic(.private(.setters))))),
              );
            });
          });
        });
        group('Typed', () {
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.typed(.fields)))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.new_(.typed(.fieldsGettersSetters))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.typed(.getters)))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.typed(.gettersSetters)))),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.typed(.methods)))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.typed(.setters)))),
              );
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.typed(.public(.fields))))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.new_(.typed(.public(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.typed(.public(.getters))))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.new_(.typed(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.typed(.public(.methods))))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.typed(.public(.setters))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.typed(.private(.fields))))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.new_(.typed(.private(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.typed(.private(.getters))))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.new_(.typed(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.typed(.private(.methods))))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.typed(.private(.setters))))),
              );
            });
          });
          group('Nullable', () {
            group('members', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(.instance(.new_(.typed(.nullable(.fields))))),
                );
              });
              test('fieldsGettersSetters', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.typed(.nullable(.fieldsGettersSetters)))),
                  ),
                );
              });
              test('getters', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.typed(.nullable(.getters)))),
                  ),
                );
              });
              test('gettersSetters', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.typed(.nullable(.gettersSetters)))),
                  ),
                );
              });
              test('methods', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.typed(.nullable(.methods)))),
                  ),
                );
              });
              test('setters', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.typed(.nullable(.setters)))),
                  ),
                );
              });
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.typed(.nullable(.public(.fields))))),
                  ),
                );
              });
              test('fieldsGettersSetters', () {
                expectSortDeclaration(
                  const .external(
                    .instance(
                      .new_(.typed(.nullable(.public(.fieldsGettersSetters)))),
                    ),
                  ),
                );
              });
              test('getters', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.typed(.nullable(.public(.getters))))),
                  ),
                );
              });
              test('gettersSetters', () {
                expectSortDeclaration(
                  const .external(
                    .instance(
                      .new_(.typed(.nullable(.public(.gettersSetters)))),
                    ),
                  ),
                );
              });
              test('methods', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.typed(.nullable(.public(.methods))))),
                  ),
                );
              });
              test('setters', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.typed(.nullable(.public(.setters))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.typed(.nullable(.private(.fields))))),
                  ),
                );
              });
              test('fieldsGettersSetters', () {
                expectSortDeclaration(
                  const .external(
                    .instance(
                      .new_(.typed(.nullable(.private(.fieldsGettersSetters)))),
                    ),
                  ),
                );
              });
              test('getters', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.typed(.nullable(.private(.getters))))),
                  ),
                );
              });
              test('gettersSetters', () {
                expectSortDeclaration(
                  const .external(
                    .instance(
                      .new_(.typed(.nullable(.private(.gettersSetters)))),
                    ),
                  ),
                );
              });
              test('methods', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.typed(.nullable(.private(.methods))))),
                  ),
                );
              });
              test('setters', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.typed(.nullable(.private(.setters))))),
                  ),
                );
              });
            });
          });
        });
        test('overridden', () {
          expectSortDeclaration(const .external(.instance(.new_(.fields))));
        });
        test('getters', () {
          expectSortDeclaration(const .external(.instance(.new_(.getters))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.new_(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.new_(.public(.fieldsGettersSetters)))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.instance(.new_(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.new_(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.new_(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.instance(.new_(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.new_(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .instance(.new_(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.instance(.new_(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.new_(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.new_(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.instance(.new_(.private(.setters)))),
            );
          });
        });
        group('Nullable', () {
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .instance(.new_(.nullable(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.instance(.new_(.nullable(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.new_(.nullable(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.new_(.nullable(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.instance(.new_(.nullable(.setters)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.nullable(.public(.fields))))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.new_(.nullable(.public(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.nullable(.public(.getters))))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.new_(.nullable(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.nullable(.public(.methods))))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.nullable(.public(.setters))))),
              );
            });
          });
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.nullable(.fields)))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.nullable(.private(.fields))))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.new_(.nullable(.private(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.new_(.nullable(.private(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.new_(.nullable(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(
                  .instance(.new_(.nullable(.private(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(
                  .instance(.new_(.nullable(.private(.setters)))),
                ),
              );
            });
          });
        });
        group('Operator', () {
          test('methods', () {
            expectSortDeclaration(
              const .external(.instance(.new_(.operator(.methods)))),
            );
            expectSortDeclaration(
              const .external(.instance(.new_(.operator()))),
            );
          });
          group('Dynamic', () {
            test('methods', () {
              expectSortDeclaration(
                const .external(
                  .instance(.new_(.operator(.dynamic(.methods)))),
                ),
              );
            });
          });
          group('Typed', () {
            test('methods', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.operator(.typed(.methods))))),
              );
            });
            group('Nullable', () {
              test('methods', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.operator(.typed(.nullable(.methods))))),
                  ),
                );
              });
            });
          });
          group('Nullable', () {
            test('methods', () {
              expectSortDeclaration(
                const .external(
                  .instance(.new_(.operator(.nullable(.methods)))),
                ),
              );
              expectSortDeclaration(
                const .external(.instance(.new_(.operator(.nullable())))),
              );
            });
          });
        });
        group('var', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.new_(.var_(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.var_(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.var_(.private(.fields))))),
              );
            });
          });
        });
        group('final', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.instance(.new_(.final_(.fields)))),
            );
          });
          group('Dynamic', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.final_(.dynamic(.fields))))),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.final_(.dynamic(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.final_(.dynamic(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Typed', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.final_(.typed(.fields))))),
              );
            });
            group('Nullable', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.final_(.typed(.nullable(.fields))))),
                  ),
                );
              });
              group('Public', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .external(
                      .instance(
                        .new_(.final_(.typed(.nullable(.public(.fields))))),
                      ),
                    ),
                  );
                });
              });
              group('Private', () {
                test('fields', () {
                  expectSortDeclaration(
                    const .external(
                      .instance(
                        .new_(.final_(.typed(.nullable(.private(.fields))))),
                      ),
                    ),
                  );
                });
              });
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.final_(.typed(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.final_(.typed(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.final_(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.final_(.private(.fields))))),
              );
            });
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.instance(.new_(.final_(.nullable(.fields))))),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.final_(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .instance(.new_(.final_(.nullable(.private(.fields))))),
                  ),
                );
              });
            });
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(const .external(.instance(.new_(.fields))));
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.new_(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(const .external(.instance(.new_(.getters))));
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.instance(.new_(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(const .external(.instance(.new_(.methods))));
          });
          test('setters', () {
            expectSortDeclaration(const .external(.instance(.new_(.setters))));
          });
        });
      });
    });
    group('New', () {
      group('Dynamic', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(const .external(.new_(.dynamic(.fields))));
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(.new_(.dynamic(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(const .external(.new_(.dynamic(.getters))));
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.new_(.dynamic(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(const .external(.new_(.dynamic(.methods))));
          });
          test('setters', () {
            expectSortDeclaration(const .external(.new_(.dynamic(.setters))));
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.new_(.dynamic(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(.new_(.dynamic(.public(.fieldsGettersSetters)))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.new_(.dynamic(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.new_(.dynamic(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.new_(.dynamic(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.new_(.dynamic(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.new_(.dynamic(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(.new_(.dynamic(.private(.fieldsGettersSetters)))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.new_(.dynamic(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.new_(.dynamic(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.new_(.dynamic(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.new_(.dynamic(.private(.setters)))),
            );
          });
        });
      });
      group('Typed', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(const .external(.new_(.typed(.fields))));
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(.new_(.typed(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(const .external(.new_(.typed(.getters))));
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.new_(.typed(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(const .external(.new_(.typed(.methods))));
          });
          test('setters', () {
            expectSortDeclaration(const .external(.new_(.typed(.setters))));
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.new_(.typed(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(.new_(.typed(.public(.fieldsGettersSetters)))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.new_(.typed(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.new_(.typed(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.new_(.typed(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.new_(.typed(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.new_(.typed(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(.new_(.typed(.private(.fieldsGettersSetters)))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.new_(.typed(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.new_(.typed(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.new_(.typed(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.new_(.typed(.private(.setters)))),
            );
          });
        });
        group('Nullable', () {
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.new_(.typed(.nullable(.fields)))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .new_(.typed(.nullable(.fieldsGettersSetters))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(.new_(.typed(.nullable(.getters)))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(.new_(.typed(.nullable(.gettersSetters)))),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(.new_(.typed(.nullable(.methods)))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(.new_(.typed(.nullable(.setters)))),
              );
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.new_(.typed(.nullable(.public(.fields))))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .new_(.typed(.nullable(.public(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(.new_(.typed(.nullable(.public(.getters))))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .new_(.typed(.nullable(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(.new_(.typed(.nullable(.public(.methods))))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(.new_(.typed(.nullable(.public(.setters))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.new_(.typed(.nullable(.private(.fields))))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .new_(.typed(.nullable(.private(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(.new_(.typed(.nullable(.private(.getters))))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .new_(.typed(.nullable(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(.new_(.typed(.nullable(.private(.methods))))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(.new_(.typed(.nullable(.private(.setters))))),
              );
            });
          });
        });
      });
      test('overridden', () {
        expectSortDeclaration(const .external(.new_(.fields)));
      });
      test('getters', () {
        expectSortDeclaration(const .external(.new_(.getters)));
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .external(.new_(.public(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.new_(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .external(.new_(.public(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .external(.new_(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .external(.new_(.public(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.new_(.public(.setters))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .external(.new_(.private(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.new_(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .external(.new_(.private(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .external(.new_(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .external(.new_(.private(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.new_(.private(.setters))));
        });
      });
      group('Nullable', () {
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.new_(.nullable(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .external(.new_(.nullable(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .external(.new_(.nullable(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .external(.new_(.nullable(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.new_(.nullable(.setters))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.new_(.nullable(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(.new_(.nullable(.public(.fieldsGettersSetters)))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.new_(.nullable(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.new_(.nullable(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.new_(.nullable(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.new_(.nullable(.public(.setters)))),
            );
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(const .external(.new_(.nullable(.fields))));
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.new_(.nullable(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .new_(.nullable(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.new_(.nullable(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.new_(.nullable(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.new_(.nullable(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.new_(.nullable(.private(.setters)))),
            );
          });
        });
      });
      group('Operator', () {
        test('methods', () {
          expectSortDeclaration(const .external(.new_(.operator(.methods))));
          expectSortDeclaration(const .external(.new_(.operator())));
        });
        group('Dynamic', () {
          test('methods', () {
            expectSortDeclaration(
              const .external(.new_(.operator(.dynamic(.methods)))),
            );
          });
        });
        group('Typed', () {
          test('methods', () {
            expectSortDeclaration(
              const .external(.new_(.operator(.typed(.methods)))),
            );
          });
          group('Nullable', () {
            test('methods', () {
              expectSortDeclaration(
                const .external(.new_(.operator(.typed(.nullable(.methods))))),
              );
            });
          });
        });
        group('Nullable', () {
          test('methods', () {
            expectSortDeclaration(
              const .external(.new_(.operator(.nullable(.methods)))),
            );
            expectSortDeclaration(
              const .external(.new_(.operator(.nullable()))),
            );
          });
        });
      });
      group('var', () {
        test('fields', () {
          expectSortDeclaration(const .external(.new_(.var_(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.new_(.var_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.new_(.var_(.private(.fields)))),
            );
          });
        });
      });
      group('final', () {
        test('fields', () {
          expectSortDeclaration(const .external(.new_(.final_(.fields))));
        });
        group('Dynamic', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.new_(.final_(.dynamic(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.new_(.final_(.dynamic(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.new_(.final_(.dynamic(.private(.fields))))),
              );
            });
          });
        });
        group('Typed', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.new_(.final_(.typed(.fields)))),
            );
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.new_(.final_(.typed(.nullable(.fields))))),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .new_(.final_(.typed(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .new_(.final_(.typed(.nullable(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.new_(.final_(.typed(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.new_(.final_(.typed(.private(.fields))))),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.new_(.final_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.new_(.final_(.private(.fields)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.new_(.final_(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.new_(.final_(.nullable(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.new_(.final_(.nullable(.private(.fields))))),
              );
            });
          });
        });
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .external(.new_(.fields)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(const .external(.new_(.fieldsGettersSetters)));
        });
        test('getters', () {
          expectSortDeclaration(const .external(.new_(.getters)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .external(.new_(.gettersSetters)));
        });
        test('methods', () {
          expectSortDeclaration(const .external(.new_(.methods)));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.new_(.setters)));
        });
      });
    });
    group('operator', () {
      test('methods', () {
        expectSortDeclaration(const .external(.operator(.methods)));
        expectSortDeclaration(const .external(.operator()));
      });
      group('Dynamic', () {
        test('methods', () {
          expectSortDeclaration(
            const .external(.operator(.dynamic(.methods))),
          );
          expectSortDeclaration(const .external(.operator(.dynamic())));
        });
      });
      group('Typed', () {
        test('methods', () {
          expectSortDeclaration(const .external(.operator(.typed(.methods))));
          expectSortDeclaration(const .external(.operator(.typed())));
        });
        group('Nullable', () {
          test('methods', () {
            expectSortDeclaration(
              const .external(.operator(.typed(.nullable(.methods)))),
            );
            expectSortDeclaration(
              const .external(.operator(.typed(.nullable()))),
            );
          });
        });
      });
      group('Nullable', () {
        test('methods', () {
          expectSortDeclaration(
            const .external(.operator(.nullable(.methods))),
          );
          expectSortDeclaration(const .external(.operator(.nullable())));
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
    group('Final', () {
      test('final_', () {
        expectSortDeclaration(const .external(.final_(.fields)));
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .external(.final_(.fields)));
        });
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
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.final_(.nullable(.public(.fields)))),
            );
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(const .external(.final_(.nullable(.fields))));
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
      group('Dynamic', () {
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.final_(.dynamic(.public(.fields)))),
            );
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(const .external(.final_(.dynamic(.fields))));
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.final_(.dynamic(.private(.fields)))),
            );
          });
        });
      });
      group('Typed', () {
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.final_(.typed(.public(.fields)))),
            );
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(const .external(.final_(.typed(.fields))));
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.final_(.typed(.private(.fields)))),
            );
          });
        });
        group('Nullable', () {
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.final_(.typed(.nullable(.public(.fields))))),
              );
            });
          });
          group('members', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.final_(.typed(.nullable(.fields)))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .final_(.typed(.nullable(.private(.fields)))),
                ),
              );
            });
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
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .external(.static(.fields)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.static(.fieldsGettersSetters)),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .external(.static(.getters)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .external(.static(.gettersSetters)));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.static(.setters)));
        });
        test('methods', () {
          expectSortDeclaration(const .external(.static(.methods)));
        });
      });
      group('Dynamic', () {
        test('fields', () {
          expectSortDeclaration(const .external(.static(.dynamic(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.static(.dynamic(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .external(.static(.dynamic(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .external(.static(.dynamic(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .external(.static(.dynamic(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.static(.dynamic(.setters))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.static(.dynamic(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .static(.dynamic(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.static(.dynamic(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.static(.dynamic(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.static(.dynamic(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.static(.dynamic(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.static(.dynamic(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .static(.dynamic(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.static(.dynamic(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.static(.dynamic(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.static(.dynamic(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.static(.dynamic(.private(.setters)))),
            );
          });
        });
      });
      group('Typed', () {
        test('fields', () {
          expectSortDeclaration(const .external(.static(.typed(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.static(.typed(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .external(.static(.typed(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .external(.static(.typed(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .external(.static(.typed(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.static(.typed(.setters))));
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.static(.typed(.nullable(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .static(.typed(.nullable(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.static(.typed(.nullable(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.static(.typed(.nullable(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.static(.typed(.nullable(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.static(.typed(.nullable(.setters)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.static(.typed(.nullable(.public(.fields))))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .static(.typed(.nullable(.public(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(.static(.typed(.nullable(.public(.getters))))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .static(.typed(.nullable(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(.static(.typed(.nullable(.public(.methods))))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(.static(.typed(.nullable(.public(.setters))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.static(.typed(.nullable(.private(.fields))))),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .static(.typed(.nullable(.private(.fieldsGettersSetters)))),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(.static(.typed(.nullable(.private(.getters))))),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .static(.typed(.nullable(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(.static(.typed(.nullable(.private(.methods))))),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(.static(.typed(.nullable(.private(.setters))))),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.static(.typed(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(.static(.typed(.public(.fieldsGettersSetters)))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.static(.typed(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.static(.typed(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.static(.typed(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.static(.typed(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.static(.typed(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(.static(.typed(.private(.fieldsGettersSetters)))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.static(.typed(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.static(.typed(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.static(.typed(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.static(.typed(.private(.setters)))),
            );
          });
        });
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
        group('Dynamic', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.static(.final_(.dynamic(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.static(.final_(.dynamic(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.static(.final_(.dynamic(.private(.fields))))),
              );
            });
          });
        });
        group('Typed', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.static(.final_(.typed(.fields)))),
            );
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.static(.final_(.typed(.nullable(.fields))))),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .static(.final_(.typed(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .static(.final_(.typed(.nullable(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.static(.final_(.typed(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.static(.final_(.typed(.private(.fields))))),
              );
            });
          });
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
    group('Overridden', () {
      test('overridden', () {
        expectSortDeclaration(const .external(.overridden(.fields)));
      });
      test('getters', () {
        expectSortDeclaration(const .external(.overridden(.getters)));
      });
      group('Dynamic', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.overridden(.dynamic(.fields))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(.overridden(.dynamic(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.overridden(.dynamic(.getters))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.overridden(.dynamic(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.overridden(.dynamic(.methods))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.overridden(.dynamic(.setters))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.overridden(.dynamic(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .overridden(.dynamic(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.overridden(.dynamic(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.overridden(.dynamic(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.overridden(.dynamic(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.overridden(.dynamic(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.overridden(.dynamic(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .overridden(.dynamic(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.overridden(.dynamic(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.overridden(.dynamic(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.overridden(.dynamic(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.overridden(.dynamic(.private(.setters)))),
            );
          });
        });
      });
      group('Typed', () {
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.fields))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.fieldsGettersSetters))),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.getters))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.gettersSetters))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.methods))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.setters))),
            );
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .overridden(.typed(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .overridden(.typed(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.private(.setters)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.nullable(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .overridden(.typed(.nullable(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.nullable(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.nullable(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.nullable(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.overridden(.typed(.nullable(.setters)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .overridden(.typed(.nullable(.public(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .overridden(
                    .typed(.nullable(.public(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(
                  .overridden(.typed(.nullable(.public(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .overridden(.typed(.nullable(.public(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(
                  .overridden(.typed(.nullable(.public(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(
                  .overridden(.typed(.nullable(.public(.setters)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .overridden(.typed(.nullable(.private(.fields)))),
                ),
              );
            });
            test('fieldsGettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .overridden(
                    .typed(.nullable(.private(.fieldsGettersSetters))),
                  ),
                ),
              );
            });
            test('getters', () {
              expectSortDeclaration(
                const .external(
                  .overridden(.typed(.nullable(.private(.getters)))),
                ),
              );
            });
            test('gettersSetters', () {
              expectSortDeclaration(
                const .external(
                  .overridden(.typed(.nullable(.private(.gettersSetters)))),
                ),
              );
            });
            test('methods', () {
              expectSortDeclaration(
                const .external(
                  .overridden(.typed(.nullable(.private(.methods)))),
                ),
              );
            });
            test('setters', () {
              expectSortDeclaration(
                const .external(
                  .overridden(.typed(.nullable(.private(.setters)))),
                ),
              );
            });
          });
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .external(.overridden(.public(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.overridden(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .external(.overridden(.public(.getters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .external(.overridden(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .external(.overridden(.public(.methods))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .external(.overridden(.public(.setters))),
          );
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(
            const .external(.overridden(.private(.fields))),
          );
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.overridden(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .external(.overridden(.private(.getters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .external(.overridden(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .external(.overridden(.private(.methods))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .external(.overridden(.private(.setters))),
          );
        });
      });
      group('Nullable', () {
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.overridden(.nullable(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(
            const .external(.overridden(.nullable(.getters))),
          );
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .external(.overridden(.nullable(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(
            const .external(.overridden(.nullable(.methods))),
          );
        });
        test('setters', () {
          expectSortDeclaration(
            const .external(.overridden(.nullable(.setters))),
          );
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.overridden(.nullable(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .overridden(.nullable(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.overridden(.nullable(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.overridden(.nullable(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.overridden(.nullable(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.overridden(.nullable(.public(.setters)))),
            );
          });
        });
        group('members', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.overridden(.nullable(.fields))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.overridden(.nullable(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .overridden(.nullable(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.overridden(.nullable(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(
                .overridden(.nullable(.private(.gettersSetters))),
              ),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.overridden(.nullable(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.overridden(.nullable(.private(.setters)))),
            );
          });
        });
      });
      group('Operator', () {
        test('methods', () {
          expectSortDeclaration(
            const .external(.overridden(.operator(.methods))),
          );
          expectSortDeclaration(const .external(.overridden(.operator())));
        });
        group('Dynamic', () {
          test('methods', () {
            expectSortDeclaration(
              const .external(.overridden(.operator(.dynamic(.methods)))),
            );
          });
        });
        group('Typed', () {
          test('methods', () {
            expectSortDeclaration(
              const .external(.overridden(.operator(.typed(.methods)))),
            );
          });
          group('Nullable', () {
            test('methods', () {
              expectSortDeclaration(
                const .external(
                  .overridden(.operator(.typed(.nullable(.methods)))),
                ),
              );
            });
          });
        });
        group('Nullable', () {
          test('methods', () {
            expectSortDeclaration(
              const .external(.overridden(.operator(.nullable(.methods)))),
            );
            expectSortDeclaration(
              const .external(.overridden(.operator(.nullable()))),
            );
          });
        });
      });
      group('var', () {
        test('fields', () {
          expectSortDeclaration(const .external(.overridden(.var_(.fields))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.overridden(.var_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.overridden(.var_(.private(.fields)))),
            );
          });
        });
      });
      group('final', () {
        test('fields', () {
          expectSortDeclaration(const .external(.overridden(.final_(.fields))));
        });
        group('Dynamic', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.overridden(.final_(.dynamic(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .overridden(.final_(.dynamic(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .overridden(.final_(.dynamic(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Typed', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.overridden(.final_(.typed(.fields)))),
            );
          });
          group('Nullable', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .overridden(.final_(.typed(.nullable(.fields)))),
                ),
              );
            });
            group('Public', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .overridden(.final_(.typed(.nullable(.public(.fields))))),
                  ),
                );
              });
            });
            group('Private', () {
              test('fields', () {
                expectSortDeclaration(
                  const .external(
                    .overridden(.final_(.typed(.nullable(.private(.fields))))),
                  ),
                );
              });
            });
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(.overridden(.final_(.typed(.public(.fields))))),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .overridden(.final_(.typed(.private(.fields)))),
                ),
              );
            });
          });
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.overridden(.final_(.public(.fields)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.overridden(.final_(.private(.fields)))),
            );
          });
        });
        group('Nullable', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.overridden(.final_(.nullable(.fields)))),
            );
          });
          group('Public', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .overridden(.final_(.nullable(.public(.fields)))),
                ),
              );
            });
          });
          group('Private', () {
            test('fields', () {
              expectSortDeclaration(
                const .external(
                  .overridden(.final_(.nullable(.private(.fields)))),
                ),
              );
            });
          });
        });
      });
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .external(.overridden(.fields)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.overridden(.fieldsGettersSetters)),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .external(.overridden(.getters)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .external(.overridden(.gettersSetters)));
        });
        test('methods', () {
          expectSortDeclaration(const .external(.overridden(.methods)));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.overridden(.setters)));
        });
      });
    });
    group('Typed', () {
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .external(.typed(.fields)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(const .external(.typed(.fieldsGettersSetters)));
        });
        test('getters', () {
          expectSortDeclaration(const .external(.typed(.getters)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .external(.typed(.gettersSetters)));
        });
        test('methods', () {
          expectSortDeclaration(const .external(.typed(.methods)));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.typed(.setters)));
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .external(.typed(.public(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.typed(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .external(.typed(.public(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .external(.typed(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .external(.typed(.public(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.typed(.public(.setters))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .external(.typed(.private(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.typed(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .external(.typed(.private(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .external(.typed(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .external(.typed(.private(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.typed(.private(.setters))));
        });
      });
      group('Nullable', () {
        test('fields', () {
          expectSortDeclaration(const .external(.typed(.nullable(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.typed(.nullable(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .external(.typed(.nullable(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .external(.typed(.nullable(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .external(.typed(.nullable(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.typed(.nullable(.setters))));
        });
        group('Public', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.typed(.nullable(.public(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .typed(.nullable(.public(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.typed(.nullable(.public(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.typed(.nullable(.public(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.typed(.nullable(.public(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.typed(.nullable(.public(.setters)))),
            );
          });
        });
        group('Private', () {
          test('fields', () {
            expectSortDeclaration(
              const .external(.typed(.nullable(.private(.fields)))),
            );
          });
          test('fieldsGettersSetters', () {
            expectSortDeclaration(
              const .external(
                .typed(.nullable(.private(.fieldsGettersSetters))),
              ),
            );
          });
          test('getters', () {
            expectSortDeclaration(
              const .external(.typed(.nullable(.private(.getters)))),
            );
          });
          test('gettersSetters', () {
            expectSortDeclaration(
              const .external(.typed(.nullable(.private(.gettersSetters)))),
            );
          });
          test('methods', () {
            expectSortDeclaration(
              const .external(.typed(.nullable(.private(.methods)))),
            );
          });
          test('setters', () {
            expectSortDeclaration(
              const .external(.typed(.nullable(.private(.setters)))),
            );
          });
        });
      });
    });
    group('Dynamic', () {
      group('members', () {
        test('fields', () {
          expectSortDeclaration(const .external(.dynamic(.fields)));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.dynamic(.fieldsGettersSetters)),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .external(.dynamic(.getters)));
        });
        test('gettersSetters', () {
          expectSortDeclaration(const .external(.dynamic(.gettersSetters)));
        });
        test('methods', () {
          expectSortDeclaration(const .external(.dynamic(.methods)));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.dynamic(.setters)));
        });
      });
      group('Public', () {
        test('fields', () {
          expectSortDeclaration(const .external(.dynamic(.public(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.dynamic(.public(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .external(.dynamic(.public(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .external(.dynamic(.public(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .external(.dynamic(.public(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.dynamic(.public(.setters))));
        });
      });
      group('Private', () {
        test('fields', () {
          expectSortDeclaration(const .external(.dynamic(.private(.fields))));
        });
        test('fieldsGettersSetters', () {
          expectSortDeclaration(
            const .external(.dynamic(.private(.fieldsGettersSetters))),
          );
        });
        test('getters', () {
          expectSortDeclaration(const .external(.dynamic(.private(.getters))));
        });
        test('gettersSetters', () {
          expectSortDeclaration(
            const .external(.dynamic(.private(.gettersSetters))),
          );
        });
        test('methods', () {
          expectSortDeclaration(const .external(.dynamic(.private(.methods))));
        });
        test('setters', () {
          expectSortDeclaration(const .external(.dynamic(.private(.setters))));
        });
      });
    });
  });
}
