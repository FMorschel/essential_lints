import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:essential_lints/src/fixes/essential_lint_fixes.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/fix_test.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(AlphabetizeArgumentsTest);
  });
}

@reflectiveTest
class AlphabetizeArgumentsTest extends FixTest {
  @override
  FixKind get fixKind => EssentialLintFixes.alphabetizeArguments.fixKind;

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
}
