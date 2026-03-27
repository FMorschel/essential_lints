import 'package:essential_lints/src/rules/explicit_casts.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(ExplicitCastsTest);
  });
}

@reflectiveTest
class ExplicitCastsTest extends LintTestProcessor {
  @override
  LintRule get rule => ExplicitCastsRule();

  Future<void> test_explicit_casts() async {
    await assertDiagnostics(
      '''
void f(Object value) {
  var a = value as String;
}
''',
      [lint(39, 2)],
    );
  }

  Future<void> test_explicit_casts_pattern() async {
    await assertDiagnostics(
      '''
void f(Object value) {
  switch (value) {
    case var a as String:
      print(a);
  }
}
''',
      [lint(57, 2)],
    );
  }

  Future<void> test_explicit_casts_typeParameter() async {
    await assertNoDiagnostics(
      '''
void f<T>(Object value) {
  var a = value as T;
}
''',
    );
  }
}
