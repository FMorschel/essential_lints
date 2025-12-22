// ignore_for_file: deprecated_member_use testing

import 'package:test/test.dart';

import 'expect_sort_declaration.dart';

void main() {
  group('Test', () {
    test('tests', () {
      // ignore: _internal_plugin/invalid_members test
      expectSortDeclaration(const .test(.tests));
      // ignore: _internal_plugin/invalid_modifiers, _internal_plugin/invalid_members test
      expectSortDeclaration(const .test(.test(.tests)));
      // ignore: _internal_plugin/invalid_modifiers, _internal_plugin/invalid_members test
      expectSortDeclaration(const .test(.wrapper(.tests)));
      // ignore: _internal_plugin/invalid_modifiers, _internal_plugin/invalid_members test
      expectSortDeclaration(const .test(.wrapper(.test(.tests))));
    });
  });
}
