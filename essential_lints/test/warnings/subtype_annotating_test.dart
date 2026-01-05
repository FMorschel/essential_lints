import 'package:_internal_testing/dependencies.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:essential_lints/src/warnings/essential_lint_warnings.dart';
import 'package:essential_lints/src/warnings/subtype_annotating.dart';
import 'package:essential_lints/src/warnings/warning.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/warning_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(SubtypeAnnotatingTest);
  });
}

@reflectiveTest
class SubtypeAnnotatingTest extends MultiWarningTestProcessor
    with AnnotationsDependencyMixin {
  @override
  MultiWarningRule<SubWarnings> get rule => SubtypeAnnotatingRule();

  @override
  Future<void> setUp() async {
    await addAnnotationsDependency();
    super.setUp();
  }

  Future<void> test_allMissing() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

const annotation = 0;

@SubtypeAnnotating(annotations: [SubtypeAnnotating, annotation])
class YourService {}

class Foo extends YourService {}
''',
      [error(rule.rule, 196, 3)],
    );
  }

  Future<void> test_annotationType() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeAnnotating(annotations: [SubtypeAnnotating.new])
class MyClass {}
''',
      [error(SubtypeAnnotating.constructorNotType, 113, 21)],
    );
  }

  Future<void> test_containingAnnotation() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeAnnotating(annotations: [SubtypeAnnotating])
class YourService {}

@SubtypeAnnotating(annotations: [SubtypeAnnotating])
class Foo extends YourService {}
''');
  }

  Future<void> test_deprecatedDifferentObject() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeAnnotating(annotations: [Deprecated('Use NewClass instead')])
class BaseClass {}

@Deprecated('Use NewClass instead 2')
class MySubclass extends BaseClass {}
''',
      [
        error(
          rule.rule,
          214,
          10,
          correctionContains: RegExp(r"Deprecated\('Use NewClass instead'\)"),
        ),
      ],
    );
  }

  Future<void> test_deprecatedObject() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeAnnotating(annotations: [Deprecated('Use NewClass instead')])
class BaseClass {}

@Deprecated('Use NewClass instead')
class MySubclass extends BaseClass {}
''');
  }

  Future<void> test_deprecatedType() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeAnnotating(annotations: [Deprecated])
class BaseClass {}

@Deprecated('Use NewClass instead 2')
class MySubclass extends BaseClass {}
''');
  }

  Future<void> test_enum() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeAnnotating(annotations: [SubtypeAnnotating])
enum E { e }

extension type Ext(E e) implements E {}
''',
      [error(rule.rule, 162, 3)],
    );
  }

  Future<void> test_extensionType() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeAnnotating(annotations: [SubtypeAnnotating])
extension type E(int i) {}

extension type Ext(E e) implements E {}
''',
      [error(rule.rule, 176, 3)],
    );
  }

  Future<void> test_missingAnnotation() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeAnnotating(annotations: [SubtypeAnnotating])
class MyClass {}

class YourClass extends MyClass {}
''',
      [error(rule.rule, 157, 9)],
    );
  }

  Future<void> test_mixin() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeAnnotating(annotations: [SubtypeAnnotating])
mixin InterfaceMixin {}

class MyClass with InterfaceMixin {}
''',
      [error(rule.rule, 164, 7)],
    );
  }

  Future<void> test_noAnnotation() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeAnnotating(annotations: [])
class MyClass {}
''',
      [error(SubtypeAnnotating.missingAnnotation, 81, 17)],
    );
  }

  Future<void> test_notOnlyConcrete_abstract() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeAnnotating(annotations: [SubtypeAnnotating])
class MyClass {}

abstract class MyOtherClass extends MyClass {}
''',
      [error(rule.rule, 166, 12)],
    );
  }

  Future<void> test_onlyConcrete_abstract() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeAnnotating(annotations: [SubtypeAnnotating], option: .onlyConcrete)
class MyClass {}

abstract class MyOtherClass extends MyClass {}
sealed class OtherClass extends MyClass {}
''');
  }

  Future<void> test_onlyConcrete_concrete() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeAnnotating(annotations: [SubtypeAnnotating], option: .onlyConcrete)
class MyClass {}

class OtherClass extends MyClass {}
''',
      [error(rule.rule, 180, 10)],
    );
  }

  Future<void> test_onlyAbstract_abstract() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeAnnotating(annotations: [SubtypeAnnotating], option: .onlyAbstract)
class MyClass {}

abstract class MyOtherClass extends MyClass {}
sealed class OtherClass extends MyClass {}
''',
      [lint(189, 12), lint(234, 10)],
    );
  }

  Future<void> test_onlyAbstract_concrete() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeAnnotating(annotations: [SubtypeAnnotating], option: .onlyAbstract)
class MyClass {}

class OtherClass extends MyClass {}
''');
  }

  Future<void> test_all() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeAnnotating(annotations: [SubtypeAnnotating], option: .all)
class MyClass {}

abstract class MyOtherClass extends MyClass {}

class OtherClass extends MyClass {}
''',
      [lint(180, 12), lint(219, 10)],
    );
  }
}
