import 'package:analyzer/utilities/package_config_file_builder.dart';
import 'package:analyzer_testing/utilities/utilities.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:essential_lints/src/rules/same_package_direct_import.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(SamePackageDirectImportTest);
  });
}

@reflectiveTest
class SamePackageDirectImportTest extends LintTestProcessor {
  @override
  LintRule get rule => SamePackageDirectImportRule();

  Future<void> test_getter() async {
    newFile(join(testPackageLibPath, 'g.dart'), 'int get getter => 0;');
    newFile(join(testPackageLibPath, 'export.dart'), "export 'g.dart';");
    await assertDiagnostics(
      '''
import 'export.dart';

void f() {
  print(getter);
}
''',
      [lint(7, 13)],
    );
  }

  Future<void> test_package() async {
    newFile(join(testPackageLibPath, 'g.dart'), 'int get getter => 0;');
    newFile(join(testPackageLibPath, 'export.dart'), "export 'g.dart';");
    await assertDiagnostics(
      '''
import 'package:test/export.dart' as ex;

void f() {
  print(ex.getter);
}
''',
      [lint(7, 26)],
    );
  }

  Future<void> test_package_other() async {
    newFile(
      join(workspaceRootPath, 'other', 'lib', 'g.dart'),
      'int get getter => 0;',
    );
    newFile(
      join(workspaceRootPath, 'other', 'lib', 'export.dart'),
      "export 'g.dart';",
    );
    newPackageConfigJsonFileFromBuilder(
      testPackageRootPath,
      PackageConfigFileBuilder()..add(
        name: 'other',
        rootPath: join(workspaceRootPath, 'other'),
      ),
    );
    pubspecYamlContent(
      dependencies: ['other'],
    );
    await assertNoDiagnostics('''
import 'package:other/export.dart';

void f() {
  print(getter);
}
''');
  }

  Future<void> test_prefixed() async {
    newFile(join(testPackageLibPath, 'g.dart'), 'int get getter => 0;');
    newFile(join(testPackageLibPath, 'export.dart'), "export 'g.dart';");
    await assertDiagnostics(
      '''
import 'export.dart' as ex;

void f() {
  print(ex.getter);
}
''',
      [lint(7, 13)],
    );
  }

  Future<void> test_type() async {
    newFile(join(testPackageLibPath, 'a.dart'), 'class A {}');
    newFile(join(testPackageLibPath, 'export.dart'), "export 'a.dart';");
    await assertDiagnostics(
      '''
import 'export.dart';

void f(A a) {}
''',
      [lint(7, 13)],
    );
  }
}
