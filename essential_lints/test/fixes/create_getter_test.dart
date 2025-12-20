import 'package:_internal_testing/dependencies.dart';
import 'package:essential_lints/src/fixes/essential_lint_fixes.dart';
import 'package:essential_lints/src/warnings/getters_in_member_list.dart';
import 'package:essential_lints/src/warnings/warning.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/fix_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(CreateGetterTest);
  });
}

@reflectiveTest
class CreateGetterTest extends MultiWarningFixTestProcessor
    with AnnotationsDependencyMixin {
  @override
  EssentialLintWarningFixes get fix => .createGetter;

  @override
  MultiWarningRule get rule => GettersInMemberListRule();

  @override
  Future<void> setUp() async {
    await addAnnotationsDependency();
    super.setUp();
  }

  Future<void> test_createGetter_containsMember() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members)
class A {
  A();
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members)
class A {
  A();
  List<Object?> get members => [];
}
''');
  }

  Future<void> test_createGetter_emptyOneLine() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members)
class A {}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members)
class A {
  List<Object?> get members => [];
}
''');
  }

  Future<void> test_createGetter_missing() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members)
class A {
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members)
class A {
  List<Object?> get members => [];
}
''');
  }

  Future<void> test_createGetter_static() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members)
class A {
  static List<Object?> get members => [];
}
''');
    await assertNoFix();
  }
}
