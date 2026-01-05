import 'package:_internal_testing/flutter_dependency_mixin.dart';
import 'package:essential_lints/src/rules/empty_container.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(EmptyContainerTest);
  });
}

@reflectiveTest
class EmptyContainerTest extends LintTestProcessor with FlutterDependencyMixin {
  @override
  LintRule get rule => EmptyContainerRule();

  @override
  void setUp() {
    createFlutterMock();
    super.setUp();
  }

  Future<void> test_emptyContainer() async {
    await assertDiagnostics(
      '''
import 'package:flutter/widgets.dart';

var container = Container();
''',
      [lint(56, 9)],
    );
  }

  Future<void> test_container_withParameters() async {
    await assertNoDiagnostics('''
import 'package:flutter/widgets.dart';

var container = Container(
  padding: EdgeInsets.all(8.0),
);
''');
  }
}
