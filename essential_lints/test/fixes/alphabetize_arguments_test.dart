import 'package:essential_lints/src/fixes/essential_lint_fixes.dart';
import 'package:essential_lints/src/rules/alphabetize_arguments.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/fix_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(AlphabetizeArgumentsTest);
  });
}

@reflectiveTest
class AlphabetizeArgumentsTest extends FixTestProcessor {
  @override
  EssentialLintFixes get fix => .alphabetizeArguments;

  @override
  LintRule get rule => AlphabetizeArgumentsRule();

  Future<void> test_alphabetizeNamedArguments() async {
    await resolveTestCode('''
void foo({int? a, int? b, int? c}) {
  foo(b: 2, a: 1, c: 3);
}
''');
    await assertHasFix('''
void foo({int? a, int? b, int? c}) {
  foo(a: 1, b: 2, c: 3);
}
''');
  }

  Future<void> test_alphabetizeNamedArguments_newLines() async {
    await resolveTestCode('''
void foo({int? a, int? b, int? c}) {
  foo(
    c: 3,
    b: 2,
    a: 1
  );
}
''');
    await assertHasFix('''
void foo({int? a, int? b, int? c}) {
  foo(
    a: 1,
    b: 2,
    c: 3
  );
}
''');
  }
}
