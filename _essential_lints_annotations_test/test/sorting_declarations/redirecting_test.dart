import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Redirecting', () {
    test('redirecting', () {
      expectSortDeclaration(const .redirecting(.constructors));
    });
    group('members', () {
      test('constructors', () {
        expectSortDeclaration(const .redirecting(.constructors));
      });
    });
    group('Public', () {
      test('constructors', () {
        expectSortDeclaration(const .redirecting(.public(.constructors)));
      });
    });
    group('Private', () {
      test('constructors', () {
        expectSortDeclaration(const .redirecting(.private(.constructors)));
      });
    });
    group('Unnamed', () {
      test('constructors', () {
        expectSortDeclaration(const .redirecting(.unnamed(.constructors)));
      });
    });
    group('Named', () {
      test('constructors', () {
        expectSortDeclaration(const .redirecting(.named(.constructors)));
      });
      group('Public', () {
        test('constructors', () {
          expectSortDeclaration(
            const .redirecting(.named(.public(.constructors))),
          );
        });
      });
      group('Private', () {
        test('constructors', () {
          expectSortDeclaration(
            const .redirecting(.named(.private(.constructors))),
          );
        });
      });
    });
  });
}
