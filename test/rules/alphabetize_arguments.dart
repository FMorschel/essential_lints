import 'package:essential_lints/src/rules/alphabetize_arguments.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(AlphabetizeArgumentsTest);
  });
}

@reflectiveTest
class AlphabetizeArgumentsTest extends RuleTest {
  @override
  Rule get rule => AlphabetizeArgumentsRule();

  Future<void> test_arguments() async {
    await assertDiagnostics(
      '''
void foo({int? a, int? b, int? c}) {
  foo(b: 2, a: 1, c: 3);
}
''',
      [lint(49, 1)],
    );
  }

  Future<void> test_arguments_more() async {
    await assertDiagnostics(
      '''
void foo({int? a, int? b, int? c}) {
  foo(c: 3, b: 2, a: 1);
}
''',
      [lint(49, 1)],
    );
  }

  Future<void> test_arguments_ok() async {
    await assertNoDiagnostics('''
void foo({int? a, int? b, int? c}) {
  foo(a: 1, b: 2,  c: 3);
}
''');
  }
}
