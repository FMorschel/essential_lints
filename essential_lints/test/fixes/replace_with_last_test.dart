import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:essential_lints/src/fixes/essential_lint_fixes.dart';
import 'package:essential_lints/src/rules/last_getter.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/fix_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(ReplaceWithLastTest);
  });
}

@reflectiveTest
class ReplaceWithLastTest extends FixTestProcessor {
  @override
  EssentialLintFixes get fix => .replaceWithLast;

  @override
  AnalysisRule get rule => LastGetterRule();

  Future<void> test_replaceWithFirst() async {
    await resolveTestCode('''
void f(List<int> list) {
  var _ = list[list.length - 1];
}
''');
    await assertHasFix('''
void f(List<int> list) {
  var _ = list.last;
}
''');
  }
}
