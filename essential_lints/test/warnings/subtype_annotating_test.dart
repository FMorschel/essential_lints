import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:essential_lints/src/warnings/essential_lint_warnings.dart';
import 'package:essential_lints/src/warnings/subtype_annotating.dart';
import 'package:essential_lints/src/warnings/warning.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/dependencies.dart';
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
    super.setUp();
    await addAnnotationsDependency();
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

@SubtypeAnnotating(annotations: [SubtypeAnnotating], onlyConcrete: true)
class MyClass {}

abstract class MyOtherClass extends MyClass {}
''');
  }

  Future<void> test_onlyConcrete_concrete() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeAnnotating(annotations: [SubtypeAnnotating], onlyConcrete: true)
class MyClass {}

class OtherClass extends MyClass {}
''',
      [error(rule.rule, 177, 10)],
    );
  }
}
