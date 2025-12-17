import 'package:_internal_testing/dependencies.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:essential_lints/src/warnings/sorting_members.dart';
import 'package:essential_lints/src/warnings/warning.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/warning_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(SortingMembersTest);
  });
}

@reflectiveTest
class SortingMembersTest extends WarningTestProcessor
    with AnnotationsDependencyMixin {
  @override
  WarningRule get rule => SortingMembersRule();

  @override
  Future<void> setUp() async {
    await addAnnotationsDependency();
    super.setUp();
  }

  Future<void> test_unnamedConstructorFirst() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .unnamed(.constructors),
  .constructors,
})
class A {
  A.named();
  A();
}
''',
      [error(rule.diagnosticCode, 170, 1)],
    );
  }

  Future<void> test_unnamedConstructorLast() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .constructors,
  .unnamed(.constructors),
})
class A {
  A();
  A.named();
}
''',
      [error(rule.diagnosticCode, 166, 5)],
    );
  }
}
