import 'package:analyzer/utilities/package_config_file_builder.dart';
import 'package:analyzer_testing/utilities/utilities.dart';
import 'package:essential_lints/src/fixes/essential_lint_fixes.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:essential_lints/src/rules/same_package_direct_import.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/fix_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(SamePackageDirectImportFixTest);
  });
}

@reflectiveTest
class SamePackageDirectImportFixTest extends LintFixTestProcessor {
  @override
  EssentialLintFixes get fix => .samePackageDirectImportFix;

  @override
  LintRule get rule => SamePackageDirectImportRule();

  Future<void> test_getter() async {
    newFile(join(testPackageLibPath, 'g.dart'), 'int get getter => 0;');
    newFile(join(testPackageLibPath, 'export.dart'), "export 'g.dart';");
    await resolveTestCode('''
import 'export.dart';

void f() {
  print(getter);
}
''');
    await assertHasFix('''
import 'package:test/g.dart';

void f() {
  print(getter);
}
''');
  }

  Future<void> test_prefixed() async {
    newFile(join(testPackageLibPath, 'g.dart'), 'int get getter => 0;');
    newFile(join(testPackageLibPath, 'export.dart'), "export 'g.dart';");
    await resolveTestCode('''
import 'export.dart' as ex;

void f() {
  print(ex.getter);
}
''');
    await assertHasFix('''
import 'package:test/g.dart' as ex;

void f() {
  print(ex.getter);
}
''');
  }

  Future<void> test_type() async {
    newFile(join(testPackageLibPath, 'a.dart'), 'class A {}');
    newFile(join(testPackageLibPath, 'export.dart'), "export 'a.dart';");
    await resolveTestCode('''
import 'export.dart';

void f(A a) {}
''');
    await assertHasFix('''
import 'package:test/a.dart';

void f(A a) {}
''');
  }

  Future<void> test_type_lint() async {
    newAnalysisOptionsYamlFile(
      testPackageRootPath,
      analysisOptionsContent(
        experiments: experiments,
        rules: [rule.name, 'prefer_relative_imports'],
      ),
    );
    newFile(join(testPackageLibPath, 'a.dart'), 'class A {}');
    newFile(join(testPackageLibPath, 'export.dart'), "export 'a.dart';");
    await resolveTestCode('''
import 'export.dart';

void f(A a) {}
''');
    await assertHasFix('''
import 'a.dart';

void f(A a) {}
''');
  }

  Future<void> test_testFolder() async {
    newFile(join(testPackageLibPath, 'a.dart'), 'class A {}');
    newFile(join(testPackageLibPath, 'export.dart'), "export 'a.dart';");
    // Change it so the test file is in the `test` folder.
    testFile = newFile(join(testPackageRootPath, 'test', 'test.dart'), '');
    await resolveTestCode('''
import 'package:test/export.dart';

void f(A a) {}
''');
    await assertHasFix('''
import 'package:test/a.dart';

void f(A a) {}
''');
  }

  Future<void> test_innerPubPackage() async {
    newFile(testPackagePubspecPath, '''
${pubspecYamlContent(name: 'test')}

workspace:
  - another
''');
    var anotherPackageRootPath = join(testPackageRootPath, 'another');
    var anotherPackageLibPath = join(anotherPackageRootPath, 'lib');
    newFile(
      join(anotherPackageRootPath, 'pubspec.yaml'),
      '''
${pubspecYamlContent(name: 'another')}

resolution: workspace
''',
    );
    newPackageConfigJsonFileFromBuilder(
      testPackageRootPath,
      PackageConfigFileBuilder()
        ..add(name: 'test', rootPath: testPackageRootPath)
        ..add(name: 'another', rootPath: anotherPackageRootPath),
    );
    newFile(join(anotherPackageLibPath, 'a.dart'), 'class A {}');
    newFile(join(anotherPackageLibPath, 'export.dart'), "export 'a.dart';");
    // Change it so the test file is in the `another` package.
    testFile = newFile(
      join(anotherPackageLibPath, 'test.dart'),
      '',
    );
    await resolveTestCode('''
import 'package:another/export.dart';

void f(A a) {}
''');
    await assertHasFix('''
import 'package:another/a.dart';

void f(A a) {}
''');
  }

  Future<void> test_outerPubPackage() async {
    newFile(testPackagePubspecPath, '''
${pubspecYamlContent(name: 'test')}

workspace:
  - another
''');
    var anotherPackageRootPath = join(testPackageRootPath, 'another');
    newFile(
      join(anotherPackageRootPath, 'pubspec.yaml'),
      '''
${pubspecYamlContent(name: 'another')}

resolution: workspace
''',
    );
    newPackageConfigJsonFileFromBuilder(
      testPackageRootPath,
      PackageConfigFileBuilder()
        ..add(name: 'test', rootPath: testPackageRootPath)
        ..add(name: 'another', rootPath: anotherPackageRootPath),
    );
    newFile(join(testPackageLibPath, 'a.dart'), 'class A {}');
    newFile(join(testPackageLibPath, 'export.dart'), "export 'a.dart';");
    // Change it so the test file is in the `another` package.
    await resolveTestCode('''
import 'package:test/export.dart';

void f(A a) {}
''');
    await assertHasFix('''
import 'package:test/a.dart';

void f(A a) {}
''');
  }
}
