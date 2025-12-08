import 'package:analyzer/utilities/package_config_file_builder.dart';
import 'package:analyzer_testing/utilities/utilities.dart';
import 'package:essential_lints/src/rules/border_radius_all.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/flutter_dependency_mixin.dart';
import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(BorderRadiusAllTest);
  });
}

@reflectiveTest
class BorderRadiusAllTest extends LintTestProcessor
    with FlutterDependencyMixin {
  @override
  LintRule get rule => BorderRadiusAllRule();

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

  Future<void> test_borderRadiusCircularUsage() async {
    await assertDiagnostics(
      '''
import 'package:flutter/widgets.dart';

var border = BorderRadius.circular(8);
''',
      [lint(53, 21)],
    );
  }

  Future<void> test_otherConstructors() async {
    await assertNoDiagnostics('''
import 'package:flutter/widgets.dart';

var border = BorderRadius.all(Radius.circular(8));
''');
  }
}
