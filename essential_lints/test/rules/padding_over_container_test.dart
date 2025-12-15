import 'package:_internal_testing/flutter_dependency_mixin.dart';
import 'package:analyzer/utilities/package_config_file_builder.dart';
import 'package:analyzer_testing/utilities/utilities.dart';
import 'package:essential_lints/src/rules/padding_over_container.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(PaddingOverContainerTest);
  });
}

@reflectiveTest
class PaddingOverContainerTest extends LintTestProcessor
    with FlutterDependencyMixin {
  @override
  LintRule get rule => PaddingOverContainerRule();

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

  Future<void> test_noReport_paddingOverNonContainer() async {
    await assertNoDiagnostics('''
import 'package:flutter/widgets.dart';

void f() {
  Padding(
    padding: EdgeInsets.all(8),
    child: Padding(
      padding: EdgeInsets.all(4),
    ),
  );
}
''');
  }

  Future<void> test_reportsPaddingOverContainer() async {
    await assertDiagnostics(
      '''
import 'package:flutter/widgets.dart';

void f() {
  Padding(
    padding: EdgeInsets.all(8),
    child: Container(),
  );
}
''',
      [lint(53, 7)],
    );
  }
}
