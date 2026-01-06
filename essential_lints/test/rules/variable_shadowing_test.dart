import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:essential_lints/src/rules/variable_shadowing.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(VariableShadowingTest);
  });
}

@reflectiveTest
class VariableShadowingTest extends LintTestProcessor {
  @override
  LintRule get rule => VariableShadowingRule();

  Future<void> test_variableDeclaration_notShadowing() async {
    await assertNoDiagnostics('''
void f() {
  var a = 1;
  {
    var o = 2;
    print(o);
  }
}
''');
  }

  Future<void> test_variableDeclaration_shadowingBlock() async {
    await assertDiagnostics(
      '''
void f() {
  var a = 1;
  {
    var a = 2;
    print(a);
  }
}
''',
      [lint(36, 1)],
    );
  }

  Future<void> test_variableDeclaration_shadowingContext() async {
    await assertDiagnostics(
      '''
void f() {
  var a = 1;
  {
    var a = 2;
    print(a);
  }
}
''',
      [
        lint(
          36,
          1,
          contextMessages: [
            contextMessage(
              testFile,
              17,
              1,
            ),
          ],
        ),
      ],
    );
  }

  Future<void> test_variableDeclaration_shadowingGlobal() async {
    await assertNoDiagnostics('''
var a = 0;
void f() {
  var a = 1;
  print(a);
}
''');
  }

  Future<void> test_variableDeclaration_shadowingClassField() async {
    await assertNoDiagnostics('''
class C {
  var a = 0;
  void m() {
    var a = 1;
    print(a);
  }
}
''');
  }

  Future<void> test_variableDeclarationPattern_notShadowing() async {
    await assertNoDiagnostics('''
void f(int a) {
  if (a case var o) {
    print(o);
  }
}
''');
  }

  Future<void> test_variableDeclarationPattern_shadowing() async {
    await assertDiagnostics(
      '''
void f(int a) {
  if (a case var a) {
    print(a);
  }
}
''',
      [lint(33, 1)],
    );
  }

  Future<void> test_variableDeclaration_shadowingParameter() async {
    await assertDiagnostics(
      '''
void f(int a) {
  var a = 2;
  print(a);
}
''',
      [lint(22, 1)],
    );
  }

  Future<void> test_variableDeclaration_shadowingParameter_method() async {
    await assertDiagnostics(
      '''
class C {
  void m(int a) {
    var a = 2;
    print(a);
  }
}
''',
      [lint(36, 1)],
    );
  }

  Future<void> test_variableDeclaration_shadowingParameter_constructor() async {
    await assertDiagnostics(
      '''
class C {
  C(int a) {
    var a = 2;
    print(a);
  }
}
''',
      [lint(31, 1)],
    );
  }

  Future<void> test_innerBlock_shadowingClassFieldGetterSetter() async {
    await assertNoDiagnostics('''
class C {
  int a = 0;
  int get g => 0;
  set s(int value) {}
  void m() {
    for (var i in const []) {
      var a = i;
      var g = i;
      var s = i;
      print(a);
    }
  }
}
''');
  }

  Future<void> test_innerBlock_shadowingTopLevelFieldGetterSetter() async {
    await assertNoDiagnostics('''
int a = 0;
int get g => 0;
set s(int value) {}

void f() {
  for (var i in const []) {
    var a = i;
    var g = i;
    var s = i;
    print(a);
  }
}
''');
  }
}
