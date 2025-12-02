import 'package:essential_lints/src/rules/new_instance_cascade.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(NewInstanceCascadeTest);
  });
}

@reflectiveTest
class NewInstanceCascadeTest extends LintTestProcessor {
  @override
  LintRule get rule => NewInstanceCascadeRule();

  Future<void> test_fieldAccess() async {
    await assertDiagnostics(
      '''
class A {
  A foo = A();
  void bar() {}
}

var a = A()..foo..bar();
''',
      [lint(57, 3)],
    );
  }

  Future<void> test_getterAccess() async {
    await assertDiagnostics(
      '''
class A {
  A get foo => A();
  void bar() {}
}

var a = A()..foo..bar();
''',
      [lint(62, 3)],
    );
  }

  Future<void> test_methodInvocation() async {
    await assertDiagnostics(
      '''
class A {
  A foo() => A();
  void bar() {}
}

var a = A()..foo()..bar();
''',
      [lint(60, 3)],
    );
  }

  Future<void> test_multipleDiagnostics() async {
    await assertDiagnostics(
      '''
class A {
  A foo() => A();
  void bar() {}
}

var a = A()..foo()..bar()..foo();
''',
      [lint(60, 3), lint(74, 3)],
    );
  }

  Future<void> test_subtype() async {
    await assertDiagnostics(
      '''
class A {
  B foo() => B();
  void bar() {}
}

class B extends A {}

var a = A()..foo()..bar();
''',
      [lint(82, 3)],
    );
  }
}
