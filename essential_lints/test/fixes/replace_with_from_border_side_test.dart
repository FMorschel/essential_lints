import 'package:analyzer/utilities/package_config_file_builder.dart';
import 'package:analyzer_testing/utilities/utilities.dart';
import 'package:essential_lints/src/fixes/essential_lint_fixes.dart';
import 'package:essential_lints/src/rules/border_all.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/fix_test_processor.dart';
import '../src/flutter_dependency_mixin.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(ReplaceWithFromBorderSideTest);
  });
}

@reflectiveTest
class ReplaceWithFromBorderSideTest extends LintFixTestProcessor
    with FlutterDependencyMixin {
  @override
  EssentialLintFixes get fix => .replaceWithFromBorderSide;

  @override
  LintRule get rule => BorderAllRule();

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

  Future<void> test_borderAllUsage() async {
    await resolveTestCode('''
import 'package:flutter/widgets.dart';

var border = Border.all();
''');
    await assertHasFix('''
import 'package:flutter/widgets.dart';

var border = const Border.fromBorderSide(BorderSide());
''');
  }

  Future<void> test_withParameters() async {
    await resolveTestCode('''
import 'package:flutter/widgets.dart';

var border = Border.all(width: 2.0);
''');
    await assertHasFix('''
import 'package:flutter/widgets.dart';

var border = const Border.fromBorderSide(BorderSide(width: 2.0));
''');
  }
}
