import 'package:essential_lints/src/rules/first_getter.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(FirstGetterTest);
  });
}

@reflectiveTest
class FirstGetterTest extends LintTestProcessor {
  @override
  LintRule get rule => FirstGetterRule();

  @FailingTest(reason: "Mock SDK doesn't have Iterable.elementAt")
  Future<void> test_elementAt() async {
    await assertDiagnostics(
      '''
void f(List<int> numbers) {
  var firstNumber = numbers.elementAt(0);
}
''',
      [lint(64, 3)],
    );
  }

  Future<void> test_extension() async {
    await assertDiagnostics(
      '''
extension on List {
  void f() {
    var firstNumber = this[0];
  }
}
''',
      [lint(59, 3)],
    );
  }

  Future<void> test_report() async {
    await assertDiagnostics(
      '''
void f(List<int> numbers) {
  var firstNumber = numbers[0];
}
''',
      [lint(55, 3)],
    );
  }

  Future<void> test_literal() async {
    await assertDiagnostics('''
void f() {
  var firstNumber = [1, 2, 3][0];
}
''', [lint(40, 3)]);
  }
}
