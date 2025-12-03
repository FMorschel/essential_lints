import 'dart:async';

import 'package:essential_lints/src/rules/completer_error_no_stack.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(CompleterErrorNoStackTest);
  });
}

@reflectiveTest
class CompleterErrorNoStackTest extends LintTestProcessor {
  @override
  LintRule get rule => CompleterErrorNoStackRule();

  Future<void> test_completeError_differentClass_enclosing() async {
    await assertNoDiagnostics('''
class C {
  void completeError(){
    completeError();
  }
}
''');
  }

  Future<void> test_completeError_differentClass() async {
    await assertNoDiagnostics('''
class C {
  void completeError() {}
}

void f() {
  C().completeError();
}
''');
  }

  Future<void> test_completeError_noStack() async {
    await assertDiagnostics(
      '''
import 'dart:async';

void f() {
  Completer().completeError('error');
}
''',
      [lint(47, 13)],
    );
  }

  Future<void> test_completeError_subClass() async {
    await assertDiagnostics(
      '''
import 'dart:async';

abstract class C implements Completer {
  @override
  void completeError(Object error, [StackTrace? stackTrace]) {
    completeError('error');
  }
}
''',
      [lint(141, 13)],
    );
  }
}
