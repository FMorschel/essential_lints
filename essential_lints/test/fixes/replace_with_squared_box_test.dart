import 'package:_internal_testing/flutter_dependency_mixin.dart';
import 'package:analyzer/utilities/package_config_file_builder.dart';
import 'package:analyzer_testing/utilities/utilities.dart';
import 'package:essential_lints/src/fixes/essential_lint_fixes.dart';
import 'package:essential_lints/src/rules/empty_container.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/fix_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(ReplaceWithSquaredBoxTest);
  });
}

@reflectiveTest
class ReplaceWithSquaredBoxTest extends LintFixTestProcessor
    with FlutterDependencyMixin {
  @override
  EssentialLintFixes get fix => .replaceWithSizedBox;

  @override
  LintRule get rule => EmptyContainerRule();

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
    await assertHasFix('''
import 'package:flutter/widgets.dart';

var widget = SizedBox.shrink();
''');
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
    SizedBox.shrink(),
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
  foo(child: SizedBox.shrink());
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
  foo(SizedBox.shrink());
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
    await assertHasFix('''
import 'package:flutter/widgets.dart';

void foo({required Widget child}) {
  foo(child: SizedBox.shrink());
}
''');
  }

  Future<void> test_removeExpression_requiredParameter() async {
    await resolveTestCode('''
import 'package:flutter/widgets.dart';

void foo(Widget child) {
  foo(Container());
}
''');
    await assertHasFix('''
import 'package:flutter/widgets.dart';

void foo(Widget child) {
  foo(SizedBox.shrink());
}
''');
  }

  Future<void> test_removeExpression_return() async {
    await resolveTestCode('''
import 'package:flutter/widgets.dart';

Widget build() {
  return Container();
}
''');
    await assertHasFix('''
import 'package:flutter/widgets.dart';

Widget build() {
  return SizedBox.shrink();
}
''');
  }

  Future<void> test_removeExpression_yield() async {
    await resolveTestCode('''
import 'package:flutter/widgets.dart';

Iterable<Widget> build() sync* {
  yield Container();
}
''');
    await assertHasFix('''
import 'package:flutter/widgets.dart';

Iterable<Widget> build() sync* {
  yield SizedBox.shrink();
}
''');
  }
}
