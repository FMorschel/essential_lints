import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:essential_lints/src/warnings/essential_lint_warnings.dart';
import 'package:essential_lints/src/warnings/getters_in_member_list.dart';
import 'package:essential_lints/src/warnings/warning.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/dependencies.dart';
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
    super.setUp();
    await addAnnotationsDependency();
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
          GettersInMemberList.invalidMemberListName,
          117,
          2,
        ),
      ],
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

  Future<void> test_findsAnnotation_includesOnlySubtype() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members', superTypes: [th<int>()])
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

@GettersInMemberList(memberListName: 'members', superTypes: [th<int?>()])
abstract class A {
  int? value;
  int get otherValue;

  List<Object?> get members => [];
}
''',
      [
        lint(
          230,
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

  Future<void> test_findsAnnotation_invalidName() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: '0 test')
class A {}
''',
      [
        error(
          GettersInMemberList.invalidMemberListName,
          117,
          8,
        ),
      ],
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
          GettersInMemberList.missingList,
          134,
          1,
        ),
      ],
    );
  }

  Future<void> test_findsAnnotation_nomMember() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class A {
  A(this.value);
  final int value;

  List<Object?> get members => [value, 0];
}
''',
      [
        error(
          GettersInMemberList.nonMemberIn,
          214,
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

@GettersInMemberList(memberListName: 'members')
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
          278,
          12,
        ),
      ],
    );
  }

  Future<void> test_findsAnnotation_static() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
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
          251,
          11,
        ),
      ],
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
          GettersInMemberList.missingList,
          134,
          1,
        ),
      ],
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
}
