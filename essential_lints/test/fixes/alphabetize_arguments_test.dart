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
class AlphabetizeArgumentsTest extends LintFixTestProcessor {
  @override
  EssentialLintFixes get fix => .alphabetizeArguments;

  @override
  LintRule get rule => AlphabetizeArgumentsRule();

  Future<void> test_newLines() async {
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

  Future<void> test_newLines_withPositional() async {
    await resolveTestCode('''
void foo(int x, int y, {int? a, int? b, int? c}) {
  foo(
    0,
    c: 3,
    1,
    b: 2,
    a: 1
  );
}
''');
    await assertHasFix('''
void foo(int x, int y, {int? a, int? b, int? c}) {
  foo(
    0,
    a: 1,
    1,
    b: 2,
    c: 3
  );
}
''');
  }

  Future<void> test_part() async {
    newFile(join(testPackageLibPath, 'main.dart'), "part 'test.dart';");
    await resolveTestCode('''
part of 'main.dart';

void foo({int? a, int? b, int? c}) {
  foo(
    c: 3,
    b: 2,
    a: 1
  );
}
''');
    await assertHasFix('''
part of 'main.dart';

void foo({int? a, int? b, int? c}) {
  foo(
    a: 1,
    b: 2,
    c: 3
  );
}
''');
  }

  Future<void> test_withPositional() async {
    await resolveTestCode('''
void foo(int x, int y, {int? a, int? b, int? c}) {
  foo(0, b: 2, 1, a: 1, c: 3);
}
''');
    await assertHasFix('''
void foo(int x, int y, {int? a, int? b, int? c}) {
  foo(0, a: 1, 1, b: 2, c: 3);
}
''');
  }

  Future<void> test_works() async {
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
}
