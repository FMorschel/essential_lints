import 'package:essential_lints/src/rules/duplicate_value.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(DuplicateValueTest);
  });
}

@reflectiveTest
class DuplicateValueTest extends LintTestProcessor {
  @override
  LintRule get rule => DuplicateValueRule();

  Future<void> test_duplicate_and() async {
    await assertDiagnostics(
      '''
void f(bool a) {
  if (a && a) {}
}
''',
      [lint(28, 1)],
    );
  }

  Future<void> test_duplicate_or() async {
    await assertDiagnostics(
      '''
void f(bool a) {
  if (a || a) {}
}
''',
      [lint(28, 1)],
    );
  }

  Future<void> test_duplicate_equal() async {
    await assertDiagnostics(
      '''
void f(bool a) {
  if (a == a) {}
}
''',
      [lint(28, 1)],
    );
  }

  Future<void> test_duplicate_different() async {
    await assertDiagnostics(
      '''
void f(bool a) {
  if (a != a) {}
}
''',
      [lint(28, 1)],
    );
  }

  Future<void> test_duplicate_carret() async {
    await assertDiagnostics(
      '''
void f(bool a) {
  if (a ^ a) {}
}
''',
      [lint(27, 1)],
    );
  }

  Future<void> test_duplicate_carret_int() async {
    await assertNoDiagnostics('''
void f(int a) {
  if (a ^ a == 0) {}
}
''');
  }

  Future<void> test_duplicate_expression() async {
    await assertDiagnostics(
      '''
void f(int value) {
  if (value == 5 || value == 5) {}
}
''',
      [lint(40, 10)],
    );
  }

  Future<void> test_duplicate_onSwitchExpression_or() async {
    await assertDiagnostics(
      '''
int f(int value) {
  return switch (value) {
    3 || 3 => 1,
    _ => 3,
  };
}
''',
      [lint(54, 1)],
    );
  }

  Future<void> test_duplicate_onSwitchExpression_and() async {
    await assertDiagnostics(
      '''
int f(int value) {
  return switch (value) {
    3 && 3 => 1,
    _ => 3,
  };
}
''',
      [lint(54, 1)],
    );
  }

  Future<void> test_duplicate_onSwitchStatement_or() async {
    await assertDiagnostics(
      '''
int f(int value) {
  switch (value) {
    case 3 || 3:
      return 1;
    default:
      return 3;
  }
}
''',
      [lint(52, 1)],
    );
  }

  Future<void> test_duplicate_onSwitchStatement_and() async {
    await assertDiagnostics(
      '''
int f(int value) {
  switch (value) {
    case 3 && 3:
      return 1;
    default:
      return 3;
  }
}
''',
      [lint(52, 1)],
    );
  }
}
