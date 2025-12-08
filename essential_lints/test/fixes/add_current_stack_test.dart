import 'package:essential_lints/src/fixes/essential_lint_fixes.dart';
import 'package:essential_lints/src/rules/completer_error_no_stack.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/fix_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(AddCurrentStackTest);
  });
}

@reflectiveTest
class AddCurrentStackTest extends LintFixTestProcessor {
  @override
  EssentialLintFixes get fix => .addCurrentStack;

  @override
  LintRule get rule => CompleterErrorNoStackRule();

  Future<void> test_completeError_noStack() async {
    await resolveTestCode('''
import 'dart:async';
void f() {
  Completer().completeError('error');
}
''');
    await assertHasFix('''
import 'dart:async';
void f() {
  Completer().completeError('error', StackTrace.current);
}
''');
  }

  Future<void> test_completeError_tryCatch() async {
    await resolveTestCode('''
import 'dart:async';
void f() {
  try {
  } catch (e, s) {
    Completer().completeError(e);
  }
}
''');
    await assertHasFix('''
import 'dart:async';
void f() {
  try {
  } catch (e, s) {
    Completer().completeError(e, s);
  }
}
''', filter: (diagnostic) => diagnostic.diagnosticCode == rule.diagnosticCode);
  }

  Future<void> test_completeError_tryCatchOuterScope() async {
    await resolveTestCode('''
import 'dart:async';
void f() {
  try {
  } catch (e, s) {
    {
      Completer().completeError(e);
    }
  }
}
''');
    await assertHasFix('''
import 'dart:async';
void f() {
  try {
  } catch (e, s) {
    {
      Completer().completeError(e, StackTrace.current);
    }
  }
}
''', filter: (diagnostic) => diagnostic.diagnosticCode == rule.diagnosticCode);
  }
}
