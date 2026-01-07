import 'package:analyzer/analysis_rule/analysis_rule.dart';

import 'package:essential_lints/src/fixes/essential_lint_fixes.dart';
import 'package:essential_lints/src/rules/first_getter.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/fix_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(ReplaceWithFirstTest);
  });
}

@reflectiveTest
class ReplaceWithFirstTest extends FixTestProcessor {
  @override
  EssentialLintFixes get fix => .replaceWithFirst;

  @override
  AnalysisRule get rule => FirstGetterRule();

  Future<void> test_replaceWithFirst() async {
    await resolveTestCode('''
void f(List<int> list) {
  var _ = list[0];
}
''');
    await assertHasFix('''
void f(List<int> list) {
  var _ = list.first;
}
''');
  }
}
