import 'package:_internal_testing/dependencies.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:essential_lints/src/warnings/essential_lint_warnings.dart';
import 'package:essential_lints/src/warnings/subtype_naming.dart';
import 'package:essential_lints/src/warnings/warning.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/warning_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(SubtypeNamingTest);
  });
}

@reflectiveTest
class SubtypeNamingTest extends MultiWarningTestProcessor
    with AnnotationsDependencyMixin {
  @override
  MultiWarningRule<SubWarnings> get rule => SubtypeNamingRule();

  @override
  Future<void> setUp() async {
    await addAnnotationsDependency();
    super.setUp();
  }

  Future<void> test_allInvalid() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(prefix: 'My', suffix: 'Class', containing: 'Other')
class YourService {}

class Foo extends YourService {}
''',
      [error(rule.rule, 175, 3)],
    );
  }

  Future<void> test_containingName() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(containing: 'Service')
class UserService {}

class UserServiceImpl extends UserService {}
''');
  }

  Future<void> test_correctPrefix() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(prefix: 'My')
class MyClass {}

class MyClassImpl extends MyClass {}
''');
  }

  Future<void> test_correctSuffix() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(suffix: 'Class')
class MyClass {}

class MyOtherClass extends MyClass {}
''');
  }

  Future<void> test_enum() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';
@SubtypeNaming(prefix: 'I')
enum E { e }

extension type Ext(E e) implements E {}
''',
      [error(rule.rule, 136, 3)],
    );
  }

  Future<void> test_extensionType() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';
@SubtypeNaming(prefix: 'I')
extension type E(int i) {}

extension type Ext(E e) implements E {}
''',
      [error(rule.rule, 150, 3)],
    );
  }

  Future<void> test_incorrectPrefix() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(prefix: 'My')
class MyClass {}

class YourClass extends MyClass {}
''',
      [error(rule.rule, 133, 9)],
    );
  }

  Future<void> test_incorrectSuffix() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(suffix: 'Class')
class MyClass {}

class MyClassImpl extends MyClass {}
''',
      [error(rule.rule, 136, 11)],
    );
  }

  Future<void> test_missingNameDefinition() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming()
class MyClass {}
''',
      [error(SubtypeNaming.missingNameDefinition, 80, 16)],
    );
  }

  Future<void> test_mixin() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';
@SubtypeNaming(prefix: 'I')
mixin InterfaceMixin {}

class MyClass with InterfaceMixin {}
''',
      [error(rule.rule, 138, 7)],
    );
  }

  Future<void> test_notContainingName() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(containing: 'Service')
class MyClass {}

class MyClassImpl extends MyClass {}
''',
      [error(rule.rule, 142, 11)],
    );
  }

  Future<void> test_notOnlyConcrete_abstract() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(prefix: 'My', onlyConcrete: false)
class MyClass {}

abstract class OtherClass extends MyClass {}
''',
      [error(rule.rule, 163, 10)],
    );
  }

  Future<void> test_onlyConcrete_abstract() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(prefix: 'My', onlyConcrete: true)
class MyClass {}

abstract class MyOtherClass extends MyClass {}
''');
  }

  Future<void> test_onlyConcrete_concrete() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(prefix: 'My', onlyConcrete: true)
class MyClass {}

class OtherClass extends MyClass {}
''',
      [error(rule.rule, 153, 10)],
    );
  }

  Future<void> test_validUsage() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(prefix: 'My', suffix: 'Class')
class MyClass {}
''');
  }
}
