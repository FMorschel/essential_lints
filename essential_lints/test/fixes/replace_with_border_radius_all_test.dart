import 'package:_internal_testing/flutter_dependency_mixin.dart';
import 'package:analyzer/utilities/package_config_file_builder.dart';
import 'package:analyzer_testing/utilities/utilities.dart';
import 'package:essential_lints/src/fixes/essential_lint_fixes.dart';
import 'package:essential_lints/src/rules/border_radius_all.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/fix_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(ReplaceWithBorderRadiusAllTest);
  });
}

@reflectiveTest
class ReplaceWithBorderRadiusAllTest extends LintFixTestProcessor
    with FlutterDependencyMixin {
  @override
  EssentialLintFixes get fix => .replaceWithBorderRadiusAll;

  @override
  LintRule get rule => BorderRadiusAllRule();

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

  Future<void> test_withParameters() async {
    await resolveTestCode('''
import 'package:flutter/widgets.dart';

var border = BorderRadius.circular(2.0);
''');
    await assertHasFix('''
import 'package:flutter/widgets.dart';

var border = const BorderRadius.all(Radius.circular(2.0));
''');
  }
}
