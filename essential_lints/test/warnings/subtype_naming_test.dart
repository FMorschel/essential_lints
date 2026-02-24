import 'package:_internal_testing/dependencies.dart';
import 'package:_internal_testing/other_package.dart';
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
    with AnnotationsDependencyMixin, OtherPackageMixin {
  @override
  MultiWarningRule<dynamic, SubWarnings> get rule => SubtypeNamingRule();

  @override
  Future<void> setUp() async {
    await addAnnotationsDependency();
    createOtherPackage();
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
      [error(SubtypeNaming.missingNameDefinition, 81, 13)],
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

@SubtypeNaming(prefix: 'My')
class MyClass {}

abstract class OtherClass extends MyClass {}
''',
      [error(rule.rule, 142, 10)],
    );
  }

  Future<void> test_onlyConcrete_abstract() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(prefix: 'My', option: .onlyConcrete)
class MyClass {}

abstract class MyOtherClass extends MyClass {}
sealed class OtherClass extends MyClass {}
''');
  }

  Future<void> test_onlyConcrete_concrete() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(prefix: 'My', option: .onlyConcrete)
class MyClass {}

class OtherClass extends MyClass {}
''',
      [error(rule.rule, 156, 10)],
    );
  }

  Future<void> test_onlyAbstract_abstract() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(prefix: 'My', option: .onlyAbstract)
class MyClass {}

abstract class OtherClass extends MyClass {}
sealed class OtherClass2 extends MyClass {}
''',
      [lint(165, 10), lint(208, 11)],
    );
  }

  Future<void> test_onlyAbstract_concrete() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(prefix: 'My', option: .onlyAbstract)
class MyClass {}

class OtherClass extends MyClass {}
''');
  }

  Future<void> test_validUsage() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(prefix: 'My', suffix: 'Class')
class MyClass {}
''');
  }

  Future<void> test_onlyInstantiable_abstract() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(prefix: 'My', option: .onlyInstantiable)
class MyClass {}

abstract class MyOtherClass extends MyClass {}
''');
  }

  Future<void> test_onlyInstantiable_mixin() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(prefix: 'My', option: .onlyInstantiable)
class MyClass {}

mixin MyOtherClass on MyClass {}
''');
  }

  Future<void> test_onlyInstantiable_instantiable() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(prefix: 'My', option: .onlyInstantiable)
class MyClass {}

class OtherClass extends MyClass {}
mixin class MixinClass implements MyClass {}
''',
      [lint(160, 10), lint(202, 10)],
    );
  }

  Future<void> test_packageOption_private_samePackage() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(prefix: 'Base', packageOption: .private)
class BaseClass {}

class SubClass extends BaseClass {}
''',
      [error(rule.rule, 162, 8)],
    );
  }

  Future<void> test_packageOption_private_differentPackage() async {
    otherPackage.addFile('lib/base.dart', '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(prefix: 'Base', packageOption: .private)
class BaseClass {}
''');

    await assertNoDiagnostics('''
import 'package:other/base.dart';

class SubClass extends BaseClass {}
''');
  }

  Future<void> test_packageOption_differentPackage() async {
    // Create an external package with the annotated base class.
    otherPackage.addFile('lib/base.dart', '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(prefix: 'Base')
class BaseClass {}
''');
    await assertDiagnostics(
      '''
import 'package:other/base.dart';

class MySubclass extends BaseClass {}
''',
      [error(rule.rule, 41, 10)],
    );
  }

  Future<void> test_unnaming_stops_propagation() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(prefix: 'My')
class A {}

class MyB extends A {}

@SubtypeUnnaming(prefix: 'My')
class C extends A {}

class C1 extends C {}
''');
  }

  Future<void> test_unnaming_doesntStop_propagation_unmatched() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeNaming(prefix: 'My')
class A {}

class MyB extends A {}

@SubtypeUnnaming(prefix: 'My', suffix: 'Class')
class C extends A {}

class C1 extends C {}
''',
      [
        error(SubtypeNaming.unnecessaryUnnamingAnnotation, 146, 15),
        error(rule.rule, 199, 1),
        error(rule.rule, 221, 2),
      ],
    );
  }
}
