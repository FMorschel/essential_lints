import 'package:_internal_testing/flutter_dependency_mixin.dart';
import 'package:essential_lints/src/rules/border_all.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(BorderAllTest);
  });
}

@reflectiveTest
class BorderAllTest extends LintTestProcessor with FlutterDependencyMixin {
  @override
  LintRule get rule => BorderAllRule();

  @override
  void setUp() {
    createFlutterMock();
    super.setUp();
  }

  Future<void> test_borderAllUsage() async {
    await assertDiagnostics(
      '''
import 'package:flutter/widgets.dart';

var border = Border.all();
''',
      [lint(53, 10)],
    );
  }

  Future<void> test_withParameters() async {
    await assertDiagnostics(
      '''
import 'package:flutter/widgets.dart';

var border = Border.all(width: 2.0);
''',
      [lint(53, 10)],
    );
  }

  Future<void> test_otherConstructors() async {
    await assertNoDiagnostics('''
import 'package:flutter/widgets.dart';

var border = Border();
''');
  }
}
