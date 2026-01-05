import 'package:essential_lints/src/rules/optional_positional_parameters.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(OptionalPositionalParameterTest);
  });
}

@reflectiveTest
class OptionalPositionalParameterTest extends LintTestProcessor {
  @override
  LintRule get rule => OptionalPositionalParametersRule();

  Future<void> test_withName() async {
    await assertDiagnostics(
      '''
void f(int a, [int? b]) {}
''',
      [lint(20, 1)],
    );
  }

  Future<void> test_withoutName() async {
    await assertDiagnostics(
      '''
typedef F = void Function(int, [int?]);
''',
      [lint(32, 4)],
    );
  }

  Future<void> test_noOptionalPositional() async {
    await assertNoDiagnostics('''
void f(int a, {int? b}) {}
''');
  }

  Future<void> test_multiple() async {
    await assertDiagnostics(
      '''
void f(int a, [int? b, int? c]) {}
''',
      [lint(20, 1)],
    );
  }
}
