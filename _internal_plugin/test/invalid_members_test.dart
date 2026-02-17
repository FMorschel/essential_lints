import 'package:_internal_plugin/src/rules/invalid_members.dart';
import 'package:_internal_testing/dependencies.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(InvalidMembersTest);
  });
}

@reflectiveTest
class InvalidMembersTest extends AnalysisRuleTest
    with AnnotationsDependencyMixin {
  @override
  Future<void> setUp() async {
    rule = InvalidMembersRule();
    await addAnnotationsDependency();
    super.setUp();
  }

  Future<void> test_consider() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/src/sorting_members/sort_declarations.dart';

@deprecated
void foo(SortDeclaration _) {
  foo(.test(.tests));
}
''',
      [lint(145, 5)],
    );
  }

  Future<void> test_consider_nested() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/src/sorting_members/sort_declarations.dart';

@deprecated
void foo(SortDeclaration _) {
  foo(.test(.wrapper(.tests)));
}
''',
      [lint(154, 5)],
    );
  }
}
