import 'package:_internal_testing/dependencies.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:essential_lints/src/warnings/essential_lint_warnings.dart';
import 'package:essential_lints/src/warnings/getters_in_member_list.dart';
import 'package:essential_lints/src/warnings/warning.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/warning_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(GettersInMemberListTest);
  });
}

@reflectiveTest
class GettersInMemberListTest extends MultiWarningTestProcessor
    with AnnotationsDependencyMixin {
  @override
  MultiWarningRule get rule => GettersInMemberListRule();

  @override
  Future<void> setUp() async {
    await addAnnotationsDependency();
    super.setUp();
  }

  @FailingTest(issue: 'https://github.com/dart-lang/sdk/issues/61597')
  Future<void> test_findsAnnotation_emptyName() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: Symbol.empty)
class A {}
''',
      [
        error(
          GettersInMemberList.invalidMemberListName,
          117,
          1,
        ),
      ],
    );
  }

  Future<void> test_findsAnnotation_excludeItself() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members)
class A {
  A(this.value);
  final int value;

  List<Object?> get members => [];
}
''',
      [lint(194, 7, correctionContains: RegExp(r"^(?!.*'members').+$"))],
    );
  }

  Future<void> test_findsAnnotation_includesField() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members)
class A {
  A(this.value);
  final int value;

  List<Object?> get members => [];
}
''',
      [lint(194, 7, correctionContains: 'value')],
    );
  }

  Future<void> test_findsAnnotation_includesFieldList() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members)
abstract class A {
  int? value, otherValue;

  List<Object?> get members => [];
}
''',
      [
        lint(
          193,
          7,
          correctionContains: RegExp(
            r"^(?=.*'value')(?=.*'otherValue').+$",
          ),
        ),
      ],
    );
  }

  Future<void> test_findsAnnotation_includesGetter() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members)
abstract class A {
  int get value;

  List<Object?> get members => [];
}
''',
      [lint(184, 7, correctionContains: 'value')],
    );
  }

  Future<void> test_findsAnnotation_includesOnlyField() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members, getters: false)
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

@GettersInMemberList(memberListName: #members, fields: false)
abstract class A {
  int? value;
  int get otherValue;

  List<Object?> get members => [];
}
''',
      [
        lint(
          218,
          7,
          correctionContains: RegExp(
            r"^(?!.*'value')(?=.*'otherValue').+$",
          ),
        ),
      ],
    );
  }

  Future<void> test_findsAnnotation_includesOnlySubtype() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members, superTypes: [th<int>()])
abstract class A {
  int? value;
  int get otherValue;

  List<Object?> get members => [];
}
''',
      [
        lint(
          228,
          7,
          correctionContains: RegExp(
            r"^(?!.*'value')(?=.*'otherValue').+$",
          ),
        ),
      ],
    );
  }

  Future<void> test_findsAnnotation_includesOnlySubtype_nullable() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members, superTypes: [th<int?>()])
abstract class A {
  int? value;
  int get otherValue;

  List<Object?> get members => [];
}
''',
      [
        lint(
          229,
          7,
          correctionContains: RegExp(
            r"^(?=.*'value')(?=.*'otherValue').+$",
          ),
        ),
      ],
    );
  }

  Future<void> test_findsAnnotation_includesOnlyType() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members, types: [th<int>()])
abstract class A {
  int? value;
  int get otherValue;

  List<Object?> get members => [];
}
''',
      [
        lint(
          223,
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

@GettersInMemberList(memberListName: #members, types: [th<int?>()])
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
            r"^(?=.*'value')(?!.*'otherValue').+$",
          ),
        ),
      ],
    );
  }

  Future<void> test_findsAnnotation_missingMember() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members)
class A {
  int? value;
}
''',
      [
        error(
          GettersInMemberList.missingList,
          133,
          1,
          correctionContains: 'an instance',
        ),
      ],
    );
  }

  Future<void> test_findsAnnotation_nomMember() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members)
class A {
  A(this.value);
  final int value;

  List<Object?> get members => [value, 0];
}
''',
      [
        error(
          GettersInMemberList.nonMemberIn,
          213,
          1,
        ),
      ],
    );
  }

  Future<void> test_findsAnnotation_nomMember_nullable() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

int? get nullableInt => null;

@GettersInMemberList(memberListName: #members)
class A {
  A(this.value, this.value2);
  final int value;
  final int value2;

  List<Object?> get members => [value, ?nullableInt, value2];
}
''',
      [
        error(
          GettersInMemberList.nonMemberIn,
          277,
          12,
        ),
      ],
    );
  }

  Future<void> test_findsAnnotation_static() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members)
class A {
  A(this.value);
  final int value;

  static const int staticValue = 0;

  List<Object?> get members => [value, staticValue];
}
''',
      [
        error(
          GettersInMemberList.nonMemberIn,
          250,
          11,
        ),
      ],
    );
  }

  Future<void> test_findsAnnotation_staticMember() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members)
class A {
  static List<Object?> get members => [];
}
''',
      [
        error(
          GettersInMemberList.missingList,
          133,
          1,
          correctionContains: 'an instance',
        ),
      ],
    );
  }

  Future<void> test_findsAnnotation_worksWithDifferentName() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #list)
class A {
  late List<Object?> list = [], other = [];
}
''',
      [lint(155, 4)],
    );
  }

  Future<void> test_findsAnnotation_worksWithField() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members)
class A {
  A(this.value);
  final int value;

  late List<Object?> members = [];
}
''',
      [lint(195, 7)],
    );
  }

  Future<void> test_findsAnnotation_worksWithFieldInList() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members)
class A {
  late List<Object?> members = [], other = [];
}
''',
      [lint(158, 7)],
    );
  }

  Future<void> test_findsAnnotation_worksWithGetter() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members)
class A {
  A(this.value);
  final int value;

  List<Object?> get members => [];
}
''',
      [lint(194, 7)],
    );
  }

  Future<void> test_staticOnly() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members, membersOption: .static)
class A {
  A(this.value);
  final int value;

  static const int staticValue = 0;

  List<Object?> get members => [staticValue];
}
''');
  }

  Future<void> test_staticOnly_diagnostic() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members, membersOption: .static)
class A {
  static const int staticValue = 0;

  List<Object?> get members => [];
}
''',
      [lint(218, 7, correctionContains: 'staticValue')],
    );
  }

  Future<void> test_staticAndInstance() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members, membersOption: .all)
class A {
  int? value;

  static const int staticValue = 0;

  List<Object?> get members => [];
}
''',
      [
        lint(
          230,
          7,
          correctionContains: RegExp(
            r"^(?=.*'staticValue')(?=.*'value').+$",
          ),
        ),
      ],
    );
  }

  Future<void> test_staticList() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members, membersOption: .static)
class A {
  static const int staticValue = 0;

  static List<Object?> get members => [staticValue];
}
''');
  }

  Future<void> test_staticList_missing() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: #members, membersOption: .static)
class A {
  static const int staticValue = 0;
}
''',
      [
        error(
          GettersInMemberList.missingList,
          157,
          1,
          correctionContains: RegExp(r'^(?!.*an instance).+$'),
        ),
      ],
    );
  }
}
