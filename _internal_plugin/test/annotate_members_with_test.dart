import 'package:_internal_plugin/src/rules/annotate_members_with.dart';
import 'package:_internal_testing/dependencies.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(AnnotateMembersWithTest);
  });
}

@reflectiveTest
class AnnotateMembersWithTest extends AnalysisRuleTest
    with AnnotationsDependencyMixin {
  @override
  Future<void> setUp() async {
    rule = AnnotateMembersWithRule();
    await addAnnotationsDependency();
    super.setUp();
  }

  Future<void> test_missingAnnotations() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/src/_internal/annotate_members_with.dart';

@AnnotateMembersWith(deprecated)
class C {
  C();
}
''',
      [lint(133, 1)],
    );
  }

  Future<void> test_missingAnnotationType() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/src/_internal/annotate_members_with.dart';

@AnnotateMembersWith(Deprecated)
class C {
  C();
}
''',
      [lint(133, 1)],
    );
  }

  Future<void> test_noMissingAnnotationType() async {
    await assertNoDiagnostics(
      '''
import 'package:essential_lints_annotations/src/_internal/annotate_members_with.dart';

@AnnotateMembersWith(Deprecated)
class C {
  @deprecated
  C();
}
''');
  }

  Future<void> test_noMissingAnnotations() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/src/_internal/annotate_members_with.dart';

@AnnotateMembersWith(deprecated)
class C {
  @deprecated
  C();
}
''');
  }

  Future<void> test_onlyConcrete() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/src/_internal/annotate_members_with.dart';

@AnnotateMembersWith(deprecated, onlyConcrete: true)
abstract class C {
  void foo();

  void bar() {}
}
''',
      [lint(182, 3)],
    );
  }

  Future<void> test_gettersSettersFields() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/src/_internal/annotate_members_with.dart';

@AnnotateMembersWith(deprecated)
class C {
  int get value => 0;
  set value(int v) {}
  int field = 0;
}
''',
      [lint(141, 5), lint(159, 5), lint(181, 5)],
    );
  }

  Future<void> test_gettersSettersFields_onlyConcrete() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/src/_internal/annotate_members_with.dart';

@AnnotateMembersWith(deprecated, onlyConcrete: true)
abstract class C {
  int get value;
  set value(int v);
  abstract int field;
}
''');
  }

  Future<void> test_onlyPublic() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/src/_internal/annotate_members_with.dart';

@AnnotateMembersWith(deprecated, onlyPublic: true)
class C {
  void foo() {}
  void _bar() {}
}
''',
      [lint(156, 3)],
    );
  }
}
