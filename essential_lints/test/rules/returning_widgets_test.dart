import 'package:analyzer/utilities/package_config_file_builder.dart';
import 'package:analyzer_testing/utilities/utilities.dart';
import 'package:essential_lints/src/rules/returning_widgets.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(ReturningWidgetsTest);
  });
}

@reflectiveTest
class ReturningWidgetsTest extends LintTestProcessor {
  @override
  LintRule get rule => ReturningWidgetsRule();

  @override
  void setUp() {
    super.setUp();
    var flutterFolder = newFolder('/packages/flutter');
    newFile(
      join(flutterFolder.path, 'lib', 'src', 'widgets', 'framework.dart'),
      '''
abstract class BuildContext {}
abstract class Widget {}
abstract class StatelessWidget extends Widget {
  Widget build(BuildContext context);
}
abstract class StatefulWidget extends Widget {}
abstract class State<T extends StatefulWidget> {
  Widget build(BuildContext context);
}
class Container extends Widget {}
''',
    );
    newFile(join(flutterFolder.path, 'lib', 'widgets.dart'), '''
export 'src/widgets/framework.dart';
''');

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

  Future<void> test_functionDeclaration_returnsWidget() async {
    await assertDiagnostics(
      '''
import 'package:flutter/widgets.dart';

Widget myWidget() {
  return Container();
}
''',
      [lint(47, 8)],
    );
  }

  Future<void> test_functionDeclaration_returnsWidget_subtype() async {
    await assertDiagnostics(
      '''
import 'package:flutter/widgets.dart';

Container myWidget() {
  return Container();
}
''',
      [lint(50, 8)],
    );
  }

  Future<void> test_methodDeclaration_returnsWidget() async {
    await assertDiagnostics(
      '''
import 'package:flutter/widgets.dart';

class A {
  Widget _myWidget() {
    return Container();
  }
}
''',
      [lint(59, 9)],
    );
  }

  Future<void> test_stateBuild() async {
    await assertNoDiagnostics('''
import 'package:flutter/widgets.dart';

class MyState extends State {
  Widget build(BuildContext context) {
    return Container();
  }
}
''');
  }

  Future<void> test_stateStateless() async {
    await assertNoDiagnostics('''
import 'package:flutter/widgets.dart';

class MyState extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container();
  }
}
''');
  }
}
