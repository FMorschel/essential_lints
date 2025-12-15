import 'package:_internal_testing/flutter_dependency_mixin.dart';
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
class ReturningWidgetsTest extends LintTestProcessor
    with FlutterDependencyMixin {
  @override
  LintRule get rule => ReturningWidgetsRule();

  @override
  void setUp() {
    createFlutterMock();
    super.setUp();
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
