import 'package:analyzer/utilities/package_config_file_builder.dart';
import 'package:analyzer_testing/utilities/utilities.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:essential_lints/src/rules/unnecessary_setstate.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/flutter_dependency_mixin.dart';
import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(UnnecessarySetstateTest);
  });
}

@reflectiveTest
class UnnecessarySetstateTest extends LintTestProcessor
    with FlutterDependencyMixin {
  @override
  LintRule get rule => UnnecessarySetstateRule();

  @override
  void setUp() {
    super.setUp();
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

  Future<void> test_inBuild() async {
    await assertDiagnostics(
      '''
import 'package:flutter/widgets.dart';

abstract class MyState extends State {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Container();
  }
}
''',
      [lint(134, 8)],
    );
  }

  Future<void> test_inBuild_other() async {
    await assertDiagnostics(
      '''
import 'package:flutter/widgets.dart';

abstract class MyState extends State {
  @override
  Widget build(BuildContext context) {
    other();
    return Container();
  }

  void other() {
    setState(() {});
  }
}
''',
      [lint(134, 5)],
    );
  }

  Future<void> test_inBuild_other_async() async {
    await assertNoDiagnostics('''
import 'package:flutter/widgets.dart';

abstract class MyState extends State {
  @override
  Widget build(BuildContext context) {
    other();
    return Container();
  }

  void other() async {
    setState(() {});
  }
}
''');
  }

  Future<void> test_inBuild_other_generator() async {
    await assertDiagnostics(
      '''
import 'package:flutter/widgets.dart';

abstract class MyState extends State {
  @override
  Widget build(BuildContext context) {
    for (var _ in other()) {}
    return Container();
  }

  Iterable<int> other() sync* {
    setState(() {});
    yield 1;
  }
}
''',
      [lint(148, 5)],
    );
  }

  Future<void> test_inBuild_other_getter() async {
    await assertDiagnostics(
      '''
import 'package:flutter/widgets.dart';

abstract class MyState extends State {
  @override
  Widget build(BuildContext context) {
    this.other;
    return Container();
  }

  int get other {
    setState(() {});
    return 1;
  }
}
''',
      [lint(139, 5)],
    );
  }

  Future<void> test_inBuild_other_getter_unqualified() async {
    await assertDiagnostics(
      '''
import 'package:flutter/widgets.dart';

abstract class MyState extends State {
  @override
  Widget build(BuildContext context) {
    other;
    return Container();
  }

  int get other {
    setState(() {});
    return 1;
  }
}
''',
      [lint(134, 5)],
    );
  }

  Future<void> test_inBuild_other_setter() async {
    await assertDiagnostics(
      '''
import 'package:flutter/widgets.dart';

abstract class MyState extends State {
  @override
  Widget build(BuildContext context) {
    this.other = 0;
    return Container();
  }

  set other(int value) {
    setState(() {});
  }
}
''',
      [lint(134, 10)],
    );
  }

  Future<void> test_inBuild_other_setter_unqualified() async {
    await assertDiagnostics(
      '''
import 'package:flutter/widgets.dart';

abstract class MyState extends State {
  @override
  Widget build(BuildContext context) {
    other = 0;
    return Container();
  }

  set other(int value) {
    setState(() {});
  }
}
''',
      [lint(134, 5)],
    );
  }

  Future<void> test_inBuild_qualified() async {
    await assertDiagnostics(
      '''
import 'package:flutter/widgets.dart';

abstract class MyState extends State {
  @override
  Widget build(BuildContext context) {
    this.setState(() {});
    return Container();
  }
}
''',
      [lint(139, 8)],
    );
  }

  Future<void> test_inDidChangeDependencies() async {
    await assertDiagnostics(
      '''
import 'package:flutter/widgets.dart';

abstract class MyState extends State {
  @override
  void didChangeDependencies() {
    setState(() {});
    super.didChangeDependencies();
  }
}
''',
      [lint(128, 8)],
    );
  }

  Future<void> test_inDidUpdateWidget() async {
    await assertDiagnostics(
      '''
import 'package:flutter/widgets.dart';

abstract class MyState extends State {
  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }
}
''',
      [lint(146, 8)],
    );
  }

  Future<void> test_inDispose() async {
    await assertDiagnostics(
      '''
import 'package:flutter/widgets.dart';

abstract class MyState extends State {
  @override
  void dispose() {
    setState(() {});
    super.dispose();
  }
}
''',
      [lint(114, 8)],
    );
  }

  Future<void> test_inInitState() async {
    await assertDiagnostics(
      '''
import 'package:flutter/widgets.dart';

abstract class MyState extends State {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }
}
''',
      [lint(139, 8)],
    );
  }
}
