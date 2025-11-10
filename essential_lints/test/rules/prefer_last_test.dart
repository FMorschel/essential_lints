import 'package:essential_lints/src/rules/prefer_last.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(PreferLastTest);
  });
}

@reflectiveTest
class PreferLastTest extends RuleTestProcessor {
  @override
  LintRule get rule => PreferLastRule();

  Future<void> test_report() async {
    await assertDiagnostics(
      '''
void f(List<int> numbers) {
  var lastNumber = numbers[numbers.length - 1];
}
''',
      [lint(54, 20)],
    );
  }

  Future<void> test_other_index() async {
    await assertNoDiagnostics('''
void f(List<int> numbers, List<int> others) {
  var lastNumber = numbers[others.length - 1];
}
''');
  }

  Future<void> test_other_target() async {
    await assertNoDiagnostics('''
void f(List<int> numbers, List<int> others) {
  var lastNumber = numbers[others.length - 1];
}
''');
  }

  Future<void> test_extension() async {
    await assertDiagnostics(
      '''
extension on List {
  void f() {
    var lastNumber = this[length - 1];
  }
}
''',
      [lint(58, 12)],
    );
  }

  @FailingTest(reason: "Mock SDK doesn't have Iterable.elementAt")
  Future<void> test_elementAt() async {
    await assertDiagnostics(
      '''
void f(List<int> numbers) {
  var lastNumber = numbers.elementAt(numbers.length - 1);
}
''',
      [lint(65, 18)],
    );
  }
}
