import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Operator', () {
    test('operator', () {
      expectSortDeclaration(const .operator(.methods));
      expectSortDeclaration(const .operator());
    });
    group('members', () {
      test('methods', () {
        expectSortDeclaration(const .operator(.methods));
        expectSortDeclaration(const .operator());
      });
    });
    group('Nullable', () {
      test('methods', () {
        expectSortDeclaration(const .operator(.nullable(.methods)));
        expectSortDeclaration(const .operator(.nullable()));
      });
    });
    group('Dynamic', () {
      test('methods', () {
        expectSortDeclaration(const .operator(.dynamic(.methods)));
        expectSortDeclaration(const .operator(.dynamic()));
      });
      group('Typed', () {
        test('methods', () {
          expectSortDeclaration(const .operator(.typed(.methods)));
          expectSortDeclaration(const .operator(.typed()));
        });
        group('Nullable', () {
          test('methods', () {
            expectSortDeclaration(const .operator(.typed(.nullable(.methods))));
            expectSortDeclaration(const .operator(.typed(.nullable())));
          });
        });
      });
    });
  });
}
