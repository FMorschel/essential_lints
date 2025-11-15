import 'package:essential_lints/src/fixes/essential_lint_fixes.dart';
import 'package:essential_lints/src/rules/alphabetize_enum_constants.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/fix_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(SortEnumConstantsTest);
  });
}

@reflectiveTest
class SortEnumConstantsTest extends LintFixTestProcessor {
  @override
  EssentialLintFixes get fix => .sortEnumConstants;

  @override
  LintRule get rule => AlphabetizeEnumConstantsRule();

  Future<void> test_documented() async {
    await resolveTestCode('''
enum MyEnum {
  /// Letter A
  a,
  /// Letter D
  d,
  /// Letter E
  e,
  /// Letter B
  b,
  /// Letter C
  c
}
''');
    await assertHasFix('''
enum MyEnum {
  /// Letter A
  a,
  /// Letter B
  b,
  /// Letter C
  c,
  /// Letter D
  d,
  /// Letter E
  e
}
''');
  }

  Future<void> test_enumConstantsNotAlphabetized() async {
    await resolveTestCode('''
enum Colors {
  blue,
  red,
  green,
}
''');
    await assertHasFix('''
enum Colors {
  blue,
  green,
  red,
}
''');
  }

  Future<void> test_enumConstantsNotAlphabetized_parameters() async {
    await resolveTestCode('''
enum Colors {
  blue(0),
  red(2),
  green(1);

  const Colors(double value);
}
''');
    await assertHasFix('''
enum Colors {
  blue(0),
  green(1),
  red(2);

  const Colors(double value);
}
''');
  }
}
