import 'package:essential_lints/src/rules/boolean_assignment.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(BooleanAssignmentTest);
  });
}

@reflectiveTest
class BooleanAssignmentTest extends LintTestProcessor {
  @override
  LintRule get rule => BooleanAssignmentRule();

  Future<void> test_if() async {
    await assertDiagnostics(
      '''
void f(bool a) {
  if (a = true) {}
}
''',
      [lint(25, 1)],
    );
  }

  Future<void> test_variableDeclaration() async {
    await assertDiagnostics(
      '''
void f(bool a) {
  var _ = a = true;
}
''',
      [lint(29, 1)],
    );
  }

  Future<void> test_while() async {
    await assertDiagnostics(
      '''
void f(bool a) {
  while (a = true) {}
}
''',
      [lint(28, 1)],
    );
  }

  Future<void> test_conditionalExpression() async {
    await assertDiagnostics(
      '''
void f(bool a, bool b) {
  (a = b) ? 1 : 0;
}
''',
      [lint(30, 1)],
    );
  }

  Future<void> test_when() async {
    await assertDiagnostics(
      '''
void f(bool a) {
  if (a case var _ when a = true) {}
}
''',
      [lint(43, 1)],
    );
  }

  Future<void> test_forPartsWithDeclarations() async {
    await assertDiagnostics(
      '''
void f(bool a) {
  for (var i = 0; a = true; i++) {}
}
''',
      [lint(37, 1)],
    );
  }

  Future<void> test_forPartsWithExpression() async {
    await assertDiagnostics(
      '''
void f(bool a) {
  for (0; a = true;) {}
}
''',
      [lint(29, 1)],
    );
  }

  Future<void> test_forPartsWithPattern() async {
    await assertDiagnostics(
      '''
void f(bool a) {
  for (var int(:isEven) = 0; a = true;) {}
}
''',
      [lint(48, 1)],
    );
  }

  Future<void> test_assertInitializer() async {
    await assertDiagnostics(
      '''
class A {
  A(bool a) : assert(a = true);
}
''',
      [lint(33, 1)],
    );
  }

  Future<void> test_assertStatement() async {
    await assertDiagnostics(
      '''
void f(bool a) {
  assert(a = true);
}
''',
      [lint(28, 1)],
    );
  }

  Future<void> test_returnStatement() async {
    await assertDiagnostics(
      '''
bool f(bool a) {
  return a = true;
}
''',
      [lint(28, 1)],
    );
  }

  Future<void> test_assignmentExpression() async {
    await assertDiagnostics(
      '''
void f(bool a) {
  bool x;
  x = a = true;
}
''',
      [lint(35, 1)],
    );
  }

  Future<void> test_argumentList() async {
    await assertDiagnostics(
      '''
void f(bool a) {
  f(a = true);
}
''',
      [lint(23, 1)],
    );
  }

  Future<void> test_argumentList_named() async {
    await assertDiagnostics(
      '''
void f({required bool a}) {
  f(a: a = true);
}
''',
      [lint(37, 1)],
    );
  }
}
