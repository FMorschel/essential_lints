import 'package:essential_lints/src/rules/equal_statement.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(EqualStatementTest);
  });
}

@reflectiveTest
class EqualStatementTest extends LintTestProcessor {
  @override
  LintRule get rule => EqualStatementRule();

  Future<void> test_expression_differentStatements() async {
    await assertNoDiagnostics('''
int f(int value) {
  return switch (value) {
    1 => 1,
    2 => 2,
    3 => 3,
    _ => 4,
  };
}
''');
  }

  Future<void> test_expression_equalStatements() async {
    await assertDiagnostics(
      '''
int f(int value) {
  return switch (value) {
    1 => 1,
    2 => 3,
    3 => 1,
    _ => 2,
  };
}
''',
      [lint(75, 2)],
    );
  }

  Future<void> test_statement_differentStatements() async {
    await assertNoDiagnostics('''
int f(int value) {
  switch (value) {
    case 1:
      return 1;
    case 2:
      return 2;
    case 3:
      print('three');
      return 1;
    default:
      return 4;
  }
}
''');
  }

  Future<void> test_statement_equalStatements() async {
    await assertDiagnostics(
      '''
int f(int value) {
  switch (value) {
    case 1:
      return 1;
    case 2:
      return 3;
    case 3:
      return 1;
    default:
      return 2;
  }
}
''',
      [lint(98, 4)],
    );
  }
}
