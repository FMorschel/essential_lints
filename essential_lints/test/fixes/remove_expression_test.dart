import 'package:_internal_testing/dependencies.dart';
import 'package:_internal_testing/flutter_dependency_mixin.dart';
import 'package:analyzer/utilities/package_config_file_builder.dart';
import 'package:analyzer_testing/utilities/utilities.dart';
import 'package:essential_lints/src/fixes/essential_lint_fixes.dart';
import 'package:essential_lints/src/rules/empty_container.dart';
import 'package:essential_lints/src/warnings/getters_in_member_list.dart';
import 'package:essential_lints/src/warnings/warning.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/fix_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(RemoveEmptyContainerExpressionTest);
    defineReflectiveTests(RemoveExpressionTest);
  });
}

@reflectiveTest
class RemoveEmptyContainerExpressionTest extends WarningFixTestProcessor
    with FlutterDependencyMixin {
  @override
  EssentialLintWarningFixes get fix => .removeExpression;

  @override
  EmptyContainerRule get rule => EmptyContainerRule();

  @override
  Future<void> setUp() async {
    await super.setUp();
    createFlutterMock();
    newPackageConfigJsonFileFromBuilder(
      testPackageRootPath,
      PackageConfigFileBuilder()..add(
        name: 'flutter',
        rootPath: flutterFolder.path,
      ),
    );
    pubspecYamlContent(
      dependencies: ['flutter'],
    );
  }

  Future<void> test_removeExpression_assignment() async {
    await resolveTestCode('''
import 'package:flutter/widgets.dart';

var widget = Container();
''');
    await assertNoFix();
  }

  Future<void> test_removeExpression_list() async {
    await resolveTestCode('''
import 'package:flutter/widgets.dart';

List<Widget> build(BuildContext context) {
  return [
    Container(),
    Padding(padding: EdgeInsets.all(8.0)),
  ];
}
''');
    await assertHasFix('''
import 'package:flutter/widgets.dart';

List<Widget> build(BuildContext context) {
  return [
    Padding(padding: EdgeInsets.all(8.0)),
  ];
}
''');
  }

  Future<void> test_removeExpression_optionalNamedParameter() async {
    await resolveTestCode('''
import 'package:flutter/widgets.dart';

void foo({Widget? child}) {
  foo(child: Container());
}
''');
    await assertHasFix('''
import 'package:flutter/widgets.dart';

void foo({Widget? child}) {
  foo();
}
''');
  }

  Future<void> test_removeExpression_optionalParameter() async {
    await resolveTestCode('''
import 'package:flutter/widgets.dart';

void foo([Widget? child]) {
  foo(Container());
}
''');
    await assertHasFix('''
import 'package:flutter/widgets.dart';

void foo([Widget? child]) {
  foo();
}
''');
  }

  Future<void> test_removeExpression_requiredNamedParameter() async {
    await resolveTestCode('''
import 'package:flutter/widgets.dart';

void foo({required Widget child}) {
  foo(child: Container());
}
''');
    await assertNoFix();
  }

  Future<void> test_removeExpression_requiredParameter() async {
    await resolveTestCode('''
import 'package:flutter/widgets.dart';

void foo(Widget child) {
  foo(Container());
}
''');
    await assertNoFix();
  }

  Future<void> test_removeExpression_return() async {
    await resolveTestCode('''
import 'package:flutter/widgets.dart';

Widget build() {
  return Container();
}
''');
    await assertNoFix();
  }

  Future<void> test_removeExpression_yield() async {
    await resolveTestCode('''
import 'package:flutter/widgets.dart';

Iterable<Widget> build() sync* {
  yield Container();
}
''');
    await assertNoFix();
  }
}

@reflectiveTest
class RemoveExpressionTest extends MultiWarningFixTestProcessor
    with AnnotationsDependencyMixin {
  @override
  EssentialLintWarningFixes get fix => .removeExpression;

  @override
  MultiWarningRule get rule => GettersInMemberListRule();

  @override
  Future<void> setUp() async {
    await super.setUp();
    await addAnnotationsDependency();
  }

  Future<void> test_removeExpression_first() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value);
  final int value;

  List<Object?> get members => [0, value];
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value);
  final int value;

  List<Object?> get members => [value];
}
''');
  }

  Future<void> test_removeExpression_last() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value);
  final int value;

  List<Object?> get members => [value, 0];
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value);
  final int value;

  List<Object?> get members => [value];
}
''');
  }

  Future<void> test_removeExpression_nullable() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

int? get nullableInt => null;

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value, this.value2);
  final int value;
  final int value2;

  List<Object?> get members => [value, ?nullableInt, value2];
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

int? get nullableInt => null;

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value, this.value2);
  final int value;
  final int value2;

  List<Object?> get members => [value, value2];
}
''');
  }

  Future<void> test_removeExpression_second() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value, this.value2);
  final int value;
  final int value2;

  List<Object?> get members => [value, 0, value2];
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value, this.value2);
  final int value;
  final int value2;

  List<Object?> get members => [value, value2];
}
''');
  }
}
