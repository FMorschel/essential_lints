import 'package:_internal_testing/dependencies.dart';
import 'package:essential_lints/src/fixes/essential_lint_fixes.dart';
import 'package:essential_lints/src/warnings/getters_in_member_list.dart';
import 'package:essential_lints/src/warnings/warning.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/fix_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(AddMissingMembersTest);
  });
}

@reflectiveTest
class AddMissingMembersTest extends MultiWarningFixTestProcessor
    with AnnotationsDependencyMixin {
  @override
  EssentialLintWarningFixes get fix => .addMissingMembers;

  @override
  MultiWarningRule get rule => GettersInMemberListRule();

  @override
  Future<void> setUp() async {
    await addAnnotationsDependency();
    super.setUp();
  }

  Future<void> test_addsMissingGetters_field() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value);
  final int value;

  List<Object?> members = [], other = [];
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value);
  final int value;

  List<Object?> members = [value, other], other = [];
}
''');
  }

  Future<void> test_addsMissingGetters_single() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value);
  final int value;

  List<Object?> get members => [];
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value);
  final int value;

  List<Object?> get members => [value];
}
''');
  }

  Future<void> test_addsMissingGetters_two() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value, this.value2);
  final int value;
  final int value2;

  List<Object?> get members => [];
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value, this.value2);
  final int value;
  final int value2;

  List<Object?> get members => [value, value2];
}
''');
  }
}
