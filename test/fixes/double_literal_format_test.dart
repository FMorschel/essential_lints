import 'package:essential_lints/src/fixes/essential_lint_fixes.dart';
import 'package:essential_lints/src/rules/double_literal_format.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/fix_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(DoubleLiteralFormatTest);
  });
}

@reflectiveTest
class DoubleLiteralFormatTest extends FixTestProcessor {
  @override
  EssentialLintFixes get fix => .doubleLiteralFormat;

  @override
  Rule get rule => DoubleLiteralFormatRule();

  Future<void> test_leadingZero_number() async {
    await resolveTestCode('''
void f() {
  var _ = 01.2;
}
''');
    await assertHasFix('''
void f() {
  var _ = 1.2;
}
''');
  }

  Future<void> test_trailingZero_number() async {
    await resolveTestCode('''
void f() {
  var _ = 0.200;
}
''');
    await assertHasFix('''
void f() {
  var _ = 0.2;
}
''');
  }

  Future<void> test_trailingZero_number_exponential() async {
    await resolveTestCode('''
void f() {
  var _ = 0.200e1;
}
''');
    await assertHasFix('''
void f() {
  var _ = 0.2e1;
}
''');
  }

  Future<void> test_exponential_leadingZeros() async {
    await resolveTestCode('''
void f() {
  var _ = 0.0e+01;
}
''');
    await assertHasFix('''
void f() {
  var _ = 0.0e+1;
}
''');
  }

  Future<void> test_noLeadingZero() async {
    await resolveTestCode('''
void f() {
  var _ = .0e+1;
}
''');
    await assertHasFix('''
void f() {
  var _ = 0.0e+1;
}
''');
  }
}
