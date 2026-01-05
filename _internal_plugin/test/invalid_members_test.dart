import 'package:_internal_plugin/src/rules/invalid_members.dart';
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

void foo(SortDeclaration _) {
  foo(.test(.tests));
}
''',
      [
        error(HintCode.deprecatedMemberUseWithMessage, 127, 4),
        error(HintCode.deprecatedMemberUseWithMessage, 133, 5),
        lint(133, 5),
      ],
    );
  }

  Future<void> test_consider_nested() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/src/sorting_members/sort_declarations.dart';

void foo(SortDeclaration _) {
  foo(.test(.wrapper(.tests)));
}
''',
      [
        error(HintCode.deprecatedMemberUseWithMessage, 127, 4),
        error(HintCode.deprecatedMemberUseWithMessage, 133, 7),
        error(HintCode.deprecatedMemberUseWithMessage, 142, 5),
        lint(142, 5),
      ],
    );
  }
}
