import 'package:essential_lints/src/rules/ambiguous_positional_boolean.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(AmbiguousPositionalBooleanTest);
  });
}

@reflectiveTest
class AmbiguousPositionalBooleanTest extends LintTestProcessor {
  @override
  LintRule get rule => AmbiguousPositionalBooleanRule();

  Future<void> test_function_positional() async {
    await assertDiagnostics(
      '''
void f(int a, bool b) {}
''',
      [lint(14, 4)],
    );
  }

  Future<void> test_function_nullable_positional() async {
    await assertDiagnostics(
      '''
void f(int a, bool? b) {}
''',
      [lint(14, 5)],
    );
  }

  Future<void> test_function_literal() async {
    await assertDiagnostics(
      '''
typedef F = void Function(int a, bool b);
''',
      [lint(33, 4)],
    );
  }

  Future<void> test_function_literal_parameter() async {
    await assertDiagnostics(
      '''
void foo(void Function(int a, bool b) f) {}
''',
      [lint(30, 4)],
    );
  }

  Future<void> test_super_parameter() async {
    await assertDiagnostics(
      '''
class C {
  C(this.a);
  bool a;
}

class D extends C {
  D(int _, super.a);
}
''',
      [lint(67, 5)],
    );
  }

  Future<void> test_this_parameter() async {
    await assertDiagnostics(
      '''
class C {
  C(int _, this.a);
  bool a;
}
''',
      [lint(21, 4)],
    );
  }

  Future<void> test_overriden_parameter() async {
    await assertDiagnostics(
      '''
class D extends C {
  @override
  void m(int a, b) {}
}
class C {
  void m(int a, bool b) {}
}
''',
      [lint(48, 1), lint(82, 4)],
    );
  }

  Future<void> test_method_positional() async {
    await assertDiagnostics(
      '''
class C {
  void m(int a, bool b) {}
}
''',
      [lint(26, 4)],
    );
  }

  Future<void> test_operator() async {
    await assertNoDiagnostics('''
class C {
  void operator []=(int index, bool value) {}
}
''');
  }

  Future<void> test_constructor_positional() async {
    await assertDiagnostics(
      '''
class A {
  A(int a, bool b);
}
''',
      [lint(21, 4)],
    );
  }

  Future<void> test_first_param_bool_allowed() async {
    await assertNoDiagnostics('''
void f(bool a, int b) {}
''');
  }
}
