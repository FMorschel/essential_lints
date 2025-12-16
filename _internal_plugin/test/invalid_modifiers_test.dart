import 'package:_internal_plugin/src/rules/invalid_modifiers.dart';
import 'package:_internal_testing/dependencies.dart';
import 'package:analyzer/src/error/codes.dart';
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
    rule = InvalidModifiersRule();
    await addAnnotationsDependency();
    super.setUp();
  }

  Future<void> test_consider() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/src/sorting_members/sort_declarations.dart';

void foo(SortDeclaration _) {
  foo(.test(.test2(.tests)));
}
''',
      [error(HintCode.deprecatedMemberUseWithMessage, 127, 4), lint(133, 5)],
    );
  }

  Future<void> test_noConsider() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/src/sorting_members/sort_declarations.dart';

void foo(SortDeclaration _) {
  foo(.test(.test(.tests)));
}
''',
      [
        error(HintCode.deprecatedMemberUseWithMessage, 127, 4),
      ],
    );
  }
}
