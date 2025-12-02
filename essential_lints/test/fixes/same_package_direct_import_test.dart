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
}
