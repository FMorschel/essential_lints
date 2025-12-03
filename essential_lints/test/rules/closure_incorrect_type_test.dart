import 'package:essential_lints/src/rules/closure_incorrect_type.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(ClosureIncorrectTypeTest);
  });
}

@reflectiveTest
class ClosureIncorrectTypeTest extends LintTestProcessor {
  @override
  LintRule get rule => ClosureIncorrectTypeRule();

  Future<void> test_argumentType() async {
    await assertNoDiagnostics('''
void f<T>(void Function(T) callback) {
  f<int>((int n) {});
}
''');
  }

  Future<void> test_argumentType_incorrect() async {
    await assertDiagnostics(
      '''
void f<T>(void Function(T) callback) {
  f<int>((num n) {});
}
''',
      [lint(49, 5)],
    );
  }

  Future<void> test_argumentType_notDefined() async {
    await assertNoDiagnostics('''
void f<T>(void Function(T) callback) {
  f((dynamic n) {});
}
''');
  }

  Future<void> test_argumentType_notDefined2() async {
    await assertNoDiagnostics('''
void f<T>(void Function(T) callback) {
  f((Object? n) {});
}
''');
  }

  Future<void> test_correctType() async {
    await assertNoDiagnostics('''
void f(void Function(int) callback) {
  f((int n) {});
}
''');
  }

  Future<void> test_functionType() async {
    await assertNoDiagnostics('''
void f(void Function(int Function()) callback) {
  f((int Function() f) {});
}
''');
  }

  Future<void> test_functionType_incorrect() async {
    await assertDiagnostics(
      '''
void f(void Function(int Function()) callback) {
  f((num Function() f) {});
}
''',
      [lint(54, 16)],
    );
  }

  Future<void> test_incorrectType() async {
    await assertDiagnostics(
      '''
void f(void Function(int) callback) {
  f((num n) {});
}
''',
      [lint(43, 5)],
    );
  }
}
