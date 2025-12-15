import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Named', () {
    test('named', () {
      expectSortDeclaration(const .named(.constructors));
    });
    group('members', () {
      test('constructors', () {
        expectSortDeclaration(const .named(.constructors));
      });
    });
    group('Public', () {
      test('constructors', () {
        expectSortDeclaration(const .named(.public(.constructors)));
      });
    });
    group('Private', () {
      test('constructors', () {
        expectSortDeclaration(const .named(.private(.constructors)));
      });
    });
  });
}
