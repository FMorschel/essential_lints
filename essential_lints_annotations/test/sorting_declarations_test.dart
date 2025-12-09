import 'package:essential_lints_annotations/src/sorting_members/sort_declarations.dart';
import 'package:test/test.dart';

void main() {
  group('SortDeclaration', () {
    group('member', () {
      test('constructor', () {
        expect(SortDeclaration.constructor(#test), isNotNull);
      });
      test('field', () {
        expect(SortDeclaration.field(#test), isNotNull);
      });
      test('getter', () {
        expect(SortDeclaration.getter(#test), isNotNull);
      });
      test('method', () {
        expect(SortDeclaration.method(#test), isNotNull);
      });
      test('setter', () {
        expect(SortDeclaration.setter(#test), isNotNull);
      });
    });
    group('members', () {
      test('constructors', () {
        expect(SortDeclaration.constructors, isNotNull);
      });
      test('fields', () {
        expect(SortDeclaration.fields, isNotNull);
      });
      test('fieldsGettersSetters', () {
        expect(SortDeclaration.fieldsGettersSetters, isNotNull);
      });
      test('getters', () {
        expect(SortDeclaration.getters, isNotNull);
      });
      test('gettersSetters', () {
        expect(SortDeclaration.gettersSetters, isNotNull);
      });
      test('methods', () {
        expect(SortDeclaration.methods, isNotNull);
      });
      test('setters', () {
        expect(SortDeclaration.setters, isNotNull);
      });
    });
    group('Overriden', () {
      var overridden = SortDeclaration.overridden;
      group('members', () {
        test('fields', () {
          expect(overridden(.fields), isNotNull);
        });
        test('fieldsGettersSetters', () {
          expect(overridden(.fieldsGettersSetters), isNotNull);
        });
        test('getters', () {
          expect(overridden(.getters), isNotNull);
        });
        test('gettersSetters', () {
          expect(overridden(.gettersSetters), isNotNull);
        });
        test('methods', () {
          expect(overridden(.methods), isNotNull);
        });
        test('setters', () {
          expect(overridden(.setters), isNotNull);
        });
      });
      group('Initialized', () {
        group('members', () {
          test('fields', () {
            expect(overridden(.initialized(.fields)), isNotNull);
          });
        });
      });
      group('External', () {
        var external = SortDeclaration.external;
        group('members', () {
          test('constructors', () {
            expect(external(.constructors), isNotNull);
          });
          test('fields', () {
            expect(external(.fields), isNotNull);
          });
          test('fieldsGettersSetters', () {
            expect(external(.fieldsGettersSetters), isNotNull);
          });
          test('getters', () {
            expect(external(.getters), isNotNull);
          });
          test('gettersSetters', () {
            expect(external(.gettersSetters), isNotNull);
          });
          test('methods', () {
            expect(external(.methods), isNotNull);
          });
          test('setters', () {
            expect(external(.setters), isNotNull);
          });
        });
      });
    });
    group('External', () {
      var external = SortDeclaration.external;
      group('members', () {
        test('constructors', () {
          expect(external(.constructors), isNotNull);
        });
        test('fields', () {
          expect(external(.fields), isNotNull);
        });
        test('fieldsGettersSetters', () {
          expect(external(.fieldsGettersSetters), isNotNull);
        });
        test('getters', () {
          expect(external(.getters), isNotNull);
        });
        test('gettersSetters', () {
          expect(external(.gettersSetters), isNotNull);
        });
        test('methods', () {
          expect(external(.methods), isNotNull);
        });
        test('setters', () {
          expect(external(.setters), isNotNull);
        });
      });
    });
    group('Initialized', () {
      var initialized = SortDeclaration.initialized;
      group('members', () {
        test('fields', () {
          expect(initialized(.fields), isNotNull);
        });
      });
    });
  });
}
