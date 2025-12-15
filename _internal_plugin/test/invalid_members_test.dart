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

  Future<void> test_base() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';
import 'package:essential_lints_annotations/src/_internal/invalid_members.dart';
import 'package:essential_lints_annotations/src/sorting_members/sort_declarations.dart';

void foo(SortDeclaration _) {
  foo(A.another(.new(.c)));
}

@InvalidMembers([th<Methods>()])
extension type A._(Public p) implements Public {
  factory A(B _) => throw Exception();
  factory A.another(A _) => throw Exception();
}

extension type const B._(Methods m) implements Methods {
  static const c = B._(SortDeclaration.methods as Methods);
}
''',
      [lint(302, 1)],
    );
  }
}
