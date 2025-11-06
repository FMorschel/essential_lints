import '../../lib/src/rules/double_literal_format.dart';
import '../../lib/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(DoubleLiteralFormatTest);
  });
}

@reflectiveTest
class DoubleLiteralFormatTest extends RuleTestProcessor {
  @override
  Rule get rule => DoubleLiteralFormatRule();

  Future<void> test_leadingZero_number() async {
    await assertDiagnostics(
      '''
var _ = 01.2;
''',
      [lint(8, 4)],
    );
  }

  Future<void> test_leadingZero() async {
    await assertNoDiagnostics('''
var _ = 0.2;
''');
  }

  Future<void> test_trailingZero_number() async {
    await assertDiagnostics(
      '''
var _ = 0.200;
''',
      [lint(8, 5)],
    );
  }

  Future<void> test_trailingZero() async {
    await assertNoDiagnostics('''
var _ = 0.0;
''');
  }

  Future<void> test_trailingZero_number_exponential() async {
    await assertDiagnostics(
      '''
var _ = 0.200e1;
''',
      [lint(8, 7)],
    );
  }

  Future<void> test_trailingZero_exponential() async {
    await assertNoDiagnostics('''
var _ = 0.0e+1;
''');
  }

  Future<void> test_exponential_leadingZeros() async {
    await assertDiagnostics(
      '''
var _ = 0.0e+01;
''',
      [lint(8, 7)],
    );
  }

  Future<void> test_noLeadingZero() async {
    await assertDiagnostics(
      '''
var _ = .0e+1;
''',
      [lint(8, 5)],
    );
  }

  Future<void> test_decimal_and_exponential() async {
    await assertDiagnostics(
      '''
var _ = 1.1e01;
''',
      [lint(8, 6)],
    );
  }

  Future<void> test_exponential_only() async {
    await assertDiagnostics(
      '''
var _ = 1e05;
''',
      [lint(8, 4)],
    );
  }
}
