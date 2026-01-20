import 'package:_internal_plugin/src/rules/static_enforcement.dart';
import 'package:_internal_testing/dependencies.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(StaticEnforcementTest);
  });
}

@reflectiveTest
class StaticEnforcementTest extends AnalysisRuleTest
    with AnnotationsDependencyMixin {
  @override
  Future<void> setUp() async {
    rule = StaticEnforcementRule();
    await addAnnotationsDependency();
    super.setUp();
  }

  Future<void> test_staticEnforcement() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/src/_internal/static_enforcement.dart';

@StaticEnforcement(#staticMethod)
class C {
  void instanceMethod() {}
  void staticMethod() {}
}
''',
      [lint(125, 1)],
    );
  }

  Future<void> test_existanceEnforcement() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/src/_internal/static_enforcement.dart';

@StaticEnforcement(#staticMethod)
class C {
  void instanceMethod() {}
}
''',
      [lint(125, 1)],
    );
  }

  Future<void> test_type() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/src/_internal/static_enforcement.dart';
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@StaticEnforcement(#staticMethod, th<String>())
class C {
  void instanceMethod() {}
  static void staticMethod() {}
}
''',
      [lint(218, 1)],
    );
  }

  Future<void> test_ok_type() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/src/_internal/static_enforcement.dart';
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@StaticEnforcement(#staticMethod, th<String>())
class C {
  void instanceMethod() {}
  static String staticMethod() => '';
}
''');
  }

  Future<void> test_ok() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/src/_internal/static_enforcement.dart';

@StaticEnforcement(#staticMethod)
class C {
  void instanceMethod() {}
  static void staticMethod() {}
}
''');
  }
}
