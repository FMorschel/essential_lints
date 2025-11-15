import 'package:essential_lints/src/rules/alphabetize_enum_constants.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(AlphabetizeEnumConstantsTest);
  });
}

@reflectiveTest
class AlphabetizeEnumConstantsTest extends LintTestProcessor {
  @override
  LintRule get rule => AlphabetizeEnumConstantsRule();

  Future<void> test_enumConstantsAlphabetized() async {
    await assertNoDiagnostics('''
enum Colors {
  blue,
  green,
  red,
}
''');
  }

  Future<void> test_enumConstantsAlphabetized_parameters() async {
    await assertNoDiagnostics('''
enum Colors {
  blue(0),
  green(1),
  red(2);

  const Colors(double value);
}
''');
  }

  Future<void> test_enumConstantsNotAlphabetized() async {
    await assertDiagnostics(
      '''
enum Colors {
  blue,
  red,
  green,
}
''',
      [
        lint(31, 5),
      ],
    );
  }

  Future<void> test_enumConstantsNotAlphabetized_parameters() async {
    await assertDiagnostics(
      '''
enum Colors {
  blue(0),
  red(2),
  green(1);

  const Colors(double value);
}
''',
      [
        lint(37, 5),
      ],
    );
  }

  Future<void> test_singleDiagnostic() async {
    await assertDiagnostics(
      '''
enum Colors {
  a,
  d,
  e,
  b,
  c
}
''',
      [
        lint(31, 1),
      ],
    );
  }
}
