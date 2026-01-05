import 'package:_internal_plugin/src/rules/invalid_modifiers.dart';
import 'package:_internal_testing/dependencies.dart';
import 'package:analyzer/src/error/codes.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:logging/logging.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

void main() {
  // Set up logging to print to console
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

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

void foo(SortDeclaration _) {
  foo(.test(.test(.tests)));
}
''',
      [
        error(HintCode.deprecatedMemberUseWithMessage, 127, 4),
        error(HintCode.deprecatedMemberUseWithMessage, 133, 4),
        lint(133, 4),
        error(HintCode.deprecatedMemberUseWithMessage, 139, 5),
      ],
    );
  }

  Future<void> test_consider_nested() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/src/sorting_members/sort_declarations.dart';

void foo(SortDeclaration _) {
  foo(.test(.wrapper(.test(.tests))));
}
''',
      [
        error(HintCode.deprecatedMemberUseWithMessage, 127, 4),
        error(HintCode.deprecatedMemberUseWithMessage, 133, 7),
        error(HintCode.deprecatedMemberUseWithMessage, 142, 4),
        lint(142, 4),
        error(HintCode.deprecatedMemberUseWithMessage, 148, 5),
      ],
    );
  }
}
