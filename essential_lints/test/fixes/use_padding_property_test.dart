import 'package:_internal_testing/flutter_dependency_mixin.dart';
import 'package:essential_lints/src/fixes/essential_lint_fixes.dart';
import 'package:essential_lints/src/rules/padding_over_container.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/fix_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(UsePaddingPropertyFixTest);
  });
}

@reflectiveTest
class UsePaddingPropertyFixTest extends LintFixTestProcessor
    with FlutterDependencyMixin {
  @override
  EssentialLintFixes get fix => .usePaddingProperty;

  @override
  LintRule get rule => PaddingOverContainerRule();

  @override
  void setUp() {
    createFlutterMock();
    super.setUp();
  }

  Future<void> test_usePaddingProperty() async {
    await resolveTestCode('''
import 'package:flutter/widgets.dart';

void f() {
  Padding(
    padding: EdgeInsets.all(8),
    child: Container(),
  );
}
''');
    await assertHasFix('''
import 'package:flutter/widgets.dart';

void f() {
  Container(
    padding: EdgeInsets.all(8),
  );
}
''');
  }

  Future<void> test_usePaddingProperty_existingChild() async {
    await resolveTestCode('''
import 'package:flutter/widgets.dart';

void f() {
  Padding(
    padding: EdgeInsets.all(8),
    child: Container(
      child: Container(),
    ),
  );
}
''');
    await assertHasFix('''
import 'package:flutter/widgets.dart';

void f() {
  Container(
    padding: EdgeInsets.all(8),
    child: Container(),
  );
}
''');
  }

  Future<void> test_usePaddingProperty_existingPadding() async {
    await resolveTestCode('''
import 'package:flutter/widgets.dart';

void f() {
  Padding(
    padding: EdgeInsets.all(8),
    child: Container(
      padding: EdgeInsets.all(8),
    ),
  );
}
''');
    await assertNoFix();
  }
}
