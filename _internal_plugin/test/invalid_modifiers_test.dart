import 'package:_internal_plugin/src/rules/invalid_modifiers.dart';
import 'package:_internal_testing/dependencies.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(InvalidModifiersTest);
  });
}

@reflectiveTest
class InvalidModifiersTest extends AnalysisRuleTest
    with AnnotationsDependencyMixin {
  @override
  Future<void> setUp() async {
    rule = InvalidModifiersRule();
    await addAnnotationsDependency();
    super.setUp();
  }

  Future<void> test_base() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/src/sorting_members/sort_declarations.dart';

@deprecated
void foo(SortDeclaration _) {
  foo(.test(.test(.tests)));
}
''',
      [lint(145, 4)],
    );
  }

  Future<void> test_consider_nested() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/src/sorting_members/sort_declarations.dart';

@deprecated
void foo(SortDeclaration _) {
  foo(.test(.wrapper(.test(.tests))));
}
''',
      [lint(154, 4)],
    );
  }
}
