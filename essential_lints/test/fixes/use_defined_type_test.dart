import 'package:essential_lints/src/fixes/essential_lint_fixes.dart';
import 'package:essential_lints/src/rules/closure_incorrect_type.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/fix_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(UseDefinedTypeTest);
  });
}

@reflectiveTest
class UseDefinedTypeTest extends LintFixTestProcessor {
  @override
  EssentialLintFixes get fix => .useDefinedType;

  @override
  LintRule get rule => ClosureIncorrectTypeRule();

  Future<void> test_argumentType_incorrect() async {
    await resolveTestCode('''
void f<T>(void Function(T) callback) {
  f<int>((num n) {});
}
''');
    await assertHasFix('''
void f<T>(void Function(T) callback) {
  f<int>((int n) {});
}
''');
  }

  Future<void> test_functionType_incorrect() async {
    await resolveTestCode('''
void f(void Function(int Function()) callback) {
  f((num Function() f) {});
}
''');
    await assertHasFix('''
void f(void Function(int Function()) callback) {
  f((int Function() f) {});
}
''');
  }

  Future<void> test_incorrectType() async {
    await resolveTestCode('''
void f(void Function(int) callback) {
  f((num n) {});
}
''');
    await assertHasFix('''
void f(void Function(int) callback) {
  f((int n) {});
}
''');
  }
}
