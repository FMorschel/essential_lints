import 'package:essential_lints/src/rules/rule.dart';
import 'package:essential_lints/src/rules/useless_else.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(UselessElseTest);
  });
}

@reflectiveTest
class UselessElseTest extends LintTestProcessor {
  @override
  LintRule get rule => UselessElseRule();

  Future<void> test_nestedIf() async {
    await assertDiagnostics(
      '''
void f(bool a) {
  if (a) {
    if (1 == 1) {
      return;
    } else {
      return;
    }
  } else {
    print('else');
  }
}
''',
      [lint(66, 4), lint(97, 4)],
    );
  }

  Future<void> test_notExiting() async {
    await assertNoDiagnostics('''
void f(bool a) {
  if (a) {
  } else {
    print('else');
  }
}
''');
  }

  Future<void> test_return() async {
    await assertDiagnostics(
      '''
void f(bool a) {
  if (a) {
    return;
  } else {
    print('else');
  }
}
''',
      [lint(44, 4)],
    );
  }

  Future<void> test_throw() async {
    await assertDiagnostics(
      '''
void f(bool a) {
  if (a) {
    throw Exception();
  } else {
    print('else');
  }
}
''',
      [lint(55, 4)],
    );
  }

  Future<void> test_notBlocks() async {
    await assertDiagnostics(
      '''
void f(bool a) {
  if (a) throw Exception();
  else print('else');
}
''',
      [lint(47, 4)],
    );
  }
}
