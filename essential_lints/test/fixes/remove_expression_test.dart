import 'package:essential_lints/src/fixes/essential_lint_fixes.dart';
import 'package:essential_lints/src/wanrings/getters_in_member_list.dart';
import 'package:essential_lints/src/wanrings/warning.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/dependencies.dart';
import '../src/fix_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(RemoveExpressionTest);
  });
}

@reflectiveTest
class RemoveExpressionTest extends MultiWarningFixTestProcessor
    with AnnotationsDependencyMixin {
  @override
  EssentialLintWarningFixes get fix => .removeExpression;

  @override
  MultiWarningRule get rule => GettersInMemberListRule();

  @override
  Future<void> setUp() async {
    await super.setUp();
    addAnnotationsDependency();
  }

  Future<void> test_removeExpression_first() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value);
  final int value;

  List<Object?> get members => [0, value];
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

  Future<void> test_removeExpression_last() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value);
  final int value;

  List<Object?> get members => [value, 0];
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

  Future<void> test_removeExpression_nullable() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

int? get nullableInt => null;

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value, this.value2);
  final int value;
  final int value2;

  List<Object?> get members => [value, ?nullableInt, value2];
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

int? get nullableInt => null;

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value, this.value2);
  final int value;
  final int value2;

  List<Object?> get members => [value, value2];
}
''');
  }

  Future<void> test_removeExpression_second() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value, this.value2);
  final int value;
  final int value2;

  List<Object?> get members => [value, 0, value2];
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
