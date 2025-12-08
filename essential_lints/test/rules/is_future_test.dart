import 'package:essential_lints/src/rules/is_future.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(IsFutureTest);
  });
}

@reflectiveTest
class IsFutureTest extends LintTestProcessor {
  @override
  LintRule get rule => IsFutureRule();

  Future<void> test_isDynamic() async {
    await assertDiagnostics('''
import 'dart:async';

void f<T>(FutureOr<T> value) {
  if (value is Future) {}
}
''', [lint(68, 6)]);
  }

  Future<void> test_isNotFuture() async {
    await assertNoDiagnostics('''
import 'dart:async';

void f<T extends int>(FutureOr<T> value) {
  if (value is Future) {}
}
''');
  }

  Future<void> test_isDynamic_doubleBound() async {
    await assertDiagnostics('''
import 'dart:async';

void f<T, O extends T>(FutureOr<O> value) {
  if (value is Future) {}
}
''', [lint(81, 6)]);
  }
}
