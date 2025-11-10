import 'package:essential_lints/src/rules/prefer_explicitly_named_parameters.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(PreferExplicitlyNamedParameterTest);
  });
}

@reflectiveTest
class PreferExplicitlyNamedParameterTest extends RuleTestProcessor {
  @override
  LintRule get rule => PreferExplicitlyNamedParameterRule();

  Future<void> test_missingName() async {
    await assertDiagnostics(
      '''
typedef MyFunction = void Function(int, {int b});
''',
      [lint(35, 3)],
    );
  }

  Future<void> test_missingName_named() async {
    await assertDiagnostics(
      '''
typedef MyFunction = void Function(int, int n);
''',
      [lint(35, 3)],
    );
  }

  Future<void> test_missingName_optional() async {
    await assertDiagnostics(
      '''
typedef MyFunction = void Function([int]);
''',
      [lint(36, 3)],
    );
  }

  Future<void> test_missingName_two() async {
    await assertDiagnostics(
      '''
typedef MyFunction = void Function(int, int);
''',
      [lint(35, 3), lint(40, 3)],
    );
  }

  Future<void> test_noLint() async {
    await assertNoDiagnostics('''
typedef MyFunction = void Function(int n1, int n2);
''');
  }
}
