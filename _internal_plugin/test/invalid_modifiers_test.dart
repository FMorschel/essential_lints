import 'package:_internal_plugin/src/rules/invalid_modifiers.dart';
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
    rule = InvalidModifiersRule();
    await addAnnotationsDependency();
    super.setUp();
  }

  Future<void> test_shorthandAccess() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';
import 'package:essential_lints_annotations/src/_internal/invalid_modifiers.dart';
import 'package:essential_lints_annotations/src/sorting_members/sort_declarations.dart';

void foo(SortDeclaration _) {
  foo(A.another(.new(.b)));
}

@InvalidModifiers([th<Private>()])
extension type A._(Public p) implements Public {
  factory A(B _) => throw Exception();
  factory A.another(A _) => throw Exception();
}

extension type const B._(Private m) implements Private {
  static const b = B._(SortDeclaration.private(.fields) as Private);
}
''',
      [lint(304, 1)],
    );
  }

  Future<void> test_shorthandConstructorInvocation() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';
import 'package:essential_lints_annotations/src/_internal/invalid_modifiers.dart';
import 'package:essential_lints_annotations/src/sorting_members/sort_declarations.dart';

void foo(SortDeclaration _) {
  foo(A.another(.new(.new())));
}

@InvalidModifiers([th<Private>()])
extension type A._(Public p) implements Public {
  factory A(B _) => throw Exception();
  factory A.another(A _) => throw Exception();
}

extension type const B._(Private m) implements Private {
  B(): m = SortDeclaration.private(.fields) as Private;
}
''',
      [lint(304, 3)],
    );
  }
}
