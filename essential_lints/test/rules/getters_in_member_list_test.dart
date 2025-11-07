import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:essential_lints/src/rules/essential_lint_rules.dart';
import 'package:essential_lints/src/rules/getters_in_member_list.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/dependencies.dart';
import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(GettersInMemberListTest);
  });
}

@reflectiveTest
class GettersInMemberListTest extends RuleTestProcessor
    with AnnotationsDependencyMixin {
  @override
  Rule get rule => GettersInMemberListRule();

  @override
  void setUp() {
    super.setUp();
    addAnnotationsDependency();
  }

  Future<void> test_findsAnnotation_worksWithGetter() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value);
  final int value;

  List<Object?> get members => [];
}
''',
      [lint(195, 7)],
    );
  }

  Future<void> test_findsAnnotation_worksWithField() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value);
  final int value;

  late List<Object?> members = [];
}
''',
      [lint(196, 7)],
    );
  }

  Future<void> test_findsAnnotation_worksWithFieldInList() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  late List<Object?> members = [], other = [];
}
''',
      [lint(159, 7)],
    );
  }

  Future<void> test_findsAnnotation_worksWithDifferentName() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'list')
class A {
  late List<Object?> list = [], other = [];
}
''',
      [lint(156, 4)],
    );
  }

  Future<void> test_findsAnnotation_excludeItself() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value);
  final int value;

  List<Object?> get members => [];
}
''',
      [lint(195, 7, correctionContains: RegExp(r"^(?!.*'members').+$"))],
    );
  }

  Future<void> test_findsAnnotation_includesField() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value);
  final int value;

  List<Object?> get members => [];
}
''',
      [lint(195, 7, correctionContains: 'value')],
    );
  }

  Future<void> test_findsAnnotation_includesGetter() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
abstract class A {
  int get value;

  List<Object?> get members => [];
}
''',
      [lint(185, 7, correctionContains: 'value')],
    );
  }

  Future<void> test_findsAnnotation_includesFieldList() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
abstract class A {
  int? value, otherValue;

  List<Object?> get members => [];
}
''',
      [
        lint(
          194,
          7,
          correctionContains: RegExp(
            r"^(?=.*'value')(?=.*'otherValue').+$",
          ),
        ),
      ],
    );
  }

  Future<void> test_findsAnnotation_includesOnlyField() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members', getters: false)
abstract class A {
  int? value;
  int get otherValue;

  List<Object?> get members => [];
}
''',
      [
        lint(
          220,
          7,
          correctionContains: RegExp(
            r"^(?=.*'value')(?!.*'otherValue').+$",
          ),
        ),
      ],
    );
  }

  Future<void> test_findsAnnotation_includesOnlyGetter() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members', fields: false)
abstract class A {
  int? value;
  int get otherValue;

  List<Object?> get members => [];
}
''',
      [
        lint(
          219,
          7,
          correctionContains: RegExp(
            r"^(?!.*'value')(?=.*'otherValue').+$",
          ),
        ),
      ],
    );
  }

  Future<void> test_findsAnnotation_includesOnlyType() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members', types: [th<int>()])
abstract class A {
  int? value;
  int get otherValue;

  List<Object?> get members => [];
}
''',
      [
        lint(
          224,
          7,
          correctionContains: RegExp(
            r"^(?!.*'value')(?=.*'otherValue').+$",
          ),
        ),
      ],
    );
  }

  Future<void> test_findsAnnotation_includesOnlyType_nullable() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members', types: [th<int?>()])
abstract class A {
  int? value;
  int get otherValue;

  List<Object?> get members => [];
}
''',
      [
        lint(
          225,
          7,
          correctionContains: RegExp(
            r"^(?=.*'value')(?!.*'otherValue').+$",
          ),
        ),
      ],
    );
  }

  Future<void> test_findsAnnotation_emptyName() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: '')
class A {}
''',
      [
        error(
          EssentialLintRules.emptyMemberListNameGettersInMemberList.code,
          117,
          2,
        ),
      ],
    );
  }

  Future<void> test_findsAnnotation_notClass() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
void foo() {}
''',
      [
        error(
          EssentialLintRules.notClassGettersInMemberList.code,
          81, 19)],
    );
  }

  Future<void> test_findsAnnotation_missingMember() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  int? value;
}
''',
      [
        error(
          EssentialLintRules.missingInstanceGettersInMemberList.code,
          134, 1)],
    );
  }

  Future<void> test_findsAnnotation_staticMember() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  static List<Object?> get members => [];
}
''',
      [
        error(
          EssentialLintRules.missingInstanceGettersInMemberList.code,
          134, 1)],
    );
  }
}
