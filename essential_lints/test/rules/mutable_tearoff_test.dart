import 'package:essential_lints/src/rules/mutable_tearoff.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(MutableTearoffTest);
  });
}

@reflectiveTest
class MutableTearoffTest extends LintTestProcessor {
  @override
  LintRule get rule => MutableTearoffRule();

  Future<void> test_constructorTearoff() async {
    await assertNoDiagnostics('''
class A {
  void foo(A Function() f) {
    foo(A.new);
  }
}
''');
  }

  Future<void> test_fieldGetter() async {
    await assertNoDiagnostics('''
class A {
  final int field = 0;
  void foo(int _) {
    foo(field);
  }
}
''');
  }

  Future<void> test_commentReference() async {
    await assertNoDiagnostics('''
class A {
  /// This is a comment about [foo] which is [A.foo].
  void foo() {}
}
''');
  }

  Future<void> test_deepCall() async {
    await assertDiagnostics(
      '''
class A {
  void foo(void Function() f) {
    foo(field.absolute.abs);
  }

  int field = 0;
}

extension on int {
  int get absolute => abs();
}
''',
      [lint(50, 5)],
    );
  }

  Future<void> test_field() async {
    await assertDiagnostics(
      '''
class A {
  void foo(void Function() f) {
    foo(field);
  }

  void Function() field = () {};
}
''',
      [lint(50, 5)],
    );
  }

  Future<void> test_finalField() async {
    await assertDiagnostics(
      '''
class A {
  void foo(void Function() f) {
    foo(field);
  }

  final void Function() field = () {};
}
''',
      [lint(50, 5)],
    );
  }

  Future<void> test_finalField_privateClass() async {
    await assertNoDiagnostics('''
class _A {
  void foo(void Function() f) {
    foo(field);
  }

  final void Function() field = () {};
}
''');
  }

  Future<void> test_finalPrivateField() async {
    await assertNoDiagnostics('''
class A {
  void foo(void Function() f) {
    foo(_field);
  }

  final void Function() _field = () {};
}
''');
  }

  Future<void> test_functionInvocation() async {
    await assertDiagnostics(
      '''
class A {
  void foo(int Function() f) {
    foo(other().bar<int>);
  }

  A other() => A();

  T bar<T extends num>() => 42 as T;
}
''',
      [lint(49, 5)],
    );
  }

  Future<void> test_functionReference() async {
    await assertDiagnostics(
      '''
class A {
  void foo(int Function() f) {
    foo(a.bar<int>);
  }

  A a = A();

  T bar<T extends num>() => 42 as T;
}
''',
      [lint(49, 1)],
    );
  }

  Future<void> test_functionReference_finalPrivateField() async {
    await assertNoDiagnostics('''
class A {
  void foo(int Function() f) {
    foo(_a.bar<int>);
  }

  final _a = A();

  T bar<T extends num>() => 42 as T;
}
''');
  }

  Future<void> test_getter() async {
    await assertDiagnostics(
      '''
class A {
  void foo(void Function() f) {
    foo(g);
  }

  void Function() get g => () {};
}
''',
      [lint(50, 1)],
    );
  }

  Future<void> test_instanceCreation() async {
    await assertDiagnostics(
      '''
class A {
  void foo(int Function() f) {
    foo(A().bar<int>);
  }

  T bar<T extends num>() => 42 as T;
}
''',
      [lint(49, 1)],
    );
  }

  Future<void> test_localVariable() async {
    await assertNoDiagnostics('''
class A {
  void foo(void Function() f) {
    void Function() fn = () {};
    foo(fn);
  }
}
''');
  }

  Future<void> test_methodFromClass() async {
    await assertNoDiagnostics('''
class A {
  void foo(void Function() f) {
    foo(bar);
  }

  void bar() {}
}
''');
  }

  Future<void> test_parameter() async {
    await assertNoDiagnostics('''
class A {
  void foo(void Function() f) {
    foo(f);
  }
}
''');
  }

  Future<void> test_staticConstField() async {
    await assertNoDiagnostics('''
class A {
  void foo(void Function() f) {
    foo(field);
  }

  static const void Function() field = bar;

  static void bar() {}
}
''');
  }

  Future<void> test_staticFinalField() async {
    await assertNoDiagnostics('''
class A {
  void foo(void Function() f) {
    foo(field);
  }

  static final void Function() field = () {};
}
''');
  }

  Future<void> test_topLevelField() async {
    await assertNoDiagnostics('''
void Function() field = () {};

class A {
  void foo(void Function() f) {
    foo(field);
  }
}
''');
  }
}
