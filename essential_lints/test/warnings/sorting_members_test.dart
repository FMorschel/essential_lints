import 'package:_internal_testing/dependencies.dart';
import 'package:analyzer/src/error/codes.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:essential_lints/src/warnings/sorting_members.dart';
import 'package:essential_lints/src/warnings/warning.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/warning_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(SortingMembersTest);
  });
}

@reflectiveTest
class SortingMembersTest extends WarningTestProcessor
    with AnnotationsDependencyMixin {
  @override
  WarningRule get rule => SortingMembersRule();

  @override
  Future<void> setUp() async {
    await addAnnotationsDependency();
    super.setUp();
  }

  Future<void> test_enum() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.fields, .constructors})
enum A {
  value1,
  value2;

  const A();

  final int field = 0;
}
''',
      [lint(178, 5)],
    );
  }

  Future<void> test_extension() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.getters, .methods})
extension A on int {
  void method() {}
  int get getter => 0;
}
''',
      [lint(168, 6)],
    );
  }

  Future<void> test_extensionType() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.getters, .constructors})
extension type A(int value) {
  A.named(this.value);

  int get getter => 0;
}
''',
      [lint(187, 6)],
    );
  }

  Future<void> test_mixin() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.fields, .methods})
mixin A {
  void method() {}
  int field = 0;
}
''',
      [lint(152, 5)],
    );
  }

  Future<void> test_unnamedConstructorFirst() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .unnamed(.constructors),
  .constructors,
})
class A {
  A.named();
  A();
}
''',
      [error(rule.diagnosticCode, 170, 1)],
    );
  }

  Future<void> test_unnamedConstructorFirst2() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .constructor(),
  .constructors,
})
class A {
  A.named();
  A();
}
''',
      [error(rule.diagnosticCode, 161, 1)],
    );
  }

  Future<void> test_unnamedConstructorLast() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .constructors,
  .unnamed(.constructors),
})
class A {
  A();
  A.named();
}
''',
      [error(rule.diagnosticCode, 166, 5)],
    );
  }

  Future<void> test_unnamedConstructorLast_getters() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .constructors,
  .getters,
  .unnamed(.constructors),
})
abstract class A {
  A.named();
  A();
  static int get value => 0;
}
''',
      [error(rule.diagnosticCode, 213, 5)],
    );
  }

  Future<void> test_fieldsGettersSetters() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .fieldsGettersSetters,
  .methods,
})
class A {
  void method() {}
  int get value => 0;
  set value(int v) {}
  int field = 0;
}
''',
      [lint(177, 5)],
    );
  }

  Future<void> test_gettersSetters() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .gettersSetters,
  .methods,
})
class A {
  void method() {}
  set value(int v) {}
  int get value => 0;
}
''',
      [lint(167, 5)],
    );
  }

  Future<void> test_unsortedLines() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({}, linesAroundUnsortedMembers: 1)
class A {
  void method() {}
  set value(int v) {}
  int get value => 0;
}
''',
      [lint(166, 5)],
    );
  }

  Future<void> test_unsortedAlphabetize() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({}, alphabetizeUnsortedMembers: true)
class A {
  int value = 0;
  void method() {}
}
''',
      [lint(168, 6)],
    );
  }

  Future<void> test_sortedAlphabetize() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.fields}, alphabetizeSortedMembers: true)
class A {
  int zebra = 0;
  int apple = 0;
}
''',
      [lint(172, 5)],
    );
  }

  Future<void> test_comprehensive() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields, .methods},
  linesBetweenSameSortMembers: 1,
  linesAroundSortedMembers: 2,
  linesAroundUnsortedMembers: 1,
  alphabetizeSortedMembers: true,
  alphabetizeUnsortedMembers: true,
)
class MyClass {
  int fieldA = 0;

  int fieldB = 0;


  void apple() {}

  void zebra() {}

  String get unsorted => '';

  String get unsorted2 => '';
}
''');
  }

  Future<void> test_spacingForUnsortedMidstSorted() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields},
  linesBetweenSameSortMembers: 1,
  linesAroundUnsortedMembers: 2,
)
class A {
  int field1 = 0;


  void method() {}


  int field2 = 0;
  int field3 = 0;
}
''',
      [lint(254, 6)],
    );
  }

  Future<void> test_zeroSpacingBetweenSame() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields},
  linesBetweenSameSortMembers: 0,
)
class A {
  int field1 = 0;

  int field2 = 0;
}
''',
      [lint(181, 6)],
    );
  }

  Future<void> test_zeroSpacingAroundSorted() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields, .methods},
  linesAroundSortedMembers: 0,
)
class A {
  int field1 = 0;

  void method() {}
}
''',
      [lint(189, 6)],
    );
  }

  Future<void> test_zeroSpacingAroundUnsorted() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields},
  linesAroundUnsortedMembers: 0,
)
class A {
  int field1 = 0;

  void method() {}
}
''',
      [lint(181, 6)],
    );
  }

  Future<void> test_specificallyNamed_field() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .field(#value),
  .unnamed(.constructors),
})
abstract class A {
  static int value2 = 0;
  A();
  static int value3 = 0;
  static int value = 0;
  static int value4 = 0;
}
''',
      [error(rule.diagnosticCode, 235, 5)],
    );
  }

  Future<void> test_threeSortRules() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .const_(.unnamed(.constructors)),
  .private(.constructors),
  .constructors,
})
class A {
  const A();
  A._();
  A.named();
}
''');
  }

  Future<void> test_nonMatchingMembers() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .constructors,
  .fields,
})
class A {
  void method() {}
  A();
  int field = 0;
}
''');
  }

  Future<void> test_emptyMatch() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({})
class A {
  A();
  int field = 0;
  void method() {}
}
''');
  }

  Future<void> test_uselessSingle() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .constructors,
})
class A {
  A.named();
  A();
  A.other();
}
''');
  }

  Future<void> test_fields() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .static(.const_(.fields)),
  .static(.fields),
  .fields,
})
class A {
  static const int CONSTANT = 1;
  static int staticVar = 0;
  int instanceVar = 0;
}
''');
  }

  Future<void> test_twoUnnecessaryMatches() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .named(.private(.constructors)),
  .named(.constructors),
  .constructors,
})
class A {
  A._private();
  A();
}
''');
  }

  Future<void> test_noMoreSpecific() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .fields,
  .constructors,
  .methods,
})
class A {
  A();
  int field = 0;
  void method() {}
}
''',
      [lint(164, 5)],
    );
  }

  Future<void> test_unsortedMiddleSorted() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .fields,
  .methods,
})
class A {
  int field = 0;
  A();
  void method() {}
  A.other();
  void method2() {}
}
''');
  }

  // ========================================================================
  // Alphabetizing configuration tests
  // ========================================================================

  Future<void> test_alphabetize_members() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields},
  alphabetizeSortedMembers: true,
)
class A {
  int zebra = 0;
  int apple = 0;
  int monkey = 0;
}
''',
      [lint(179, 5)],
    );
  }

  Future<void> test_alphabetize_unsorted_midstSorted() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields},
  alphabetizeUnsortedMembers: true,
)
abstract class A {
  int get last;
  int middle = 0;
  int get getter;
}
''',
      [lint(211, 6)],
    );
  }

  Future<void> test_alphabetize_members_fields() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields},
  alphabetizeSortedMembers: true,
)
class A {
  int zebra = 0, apple = 0, monkey = 0;
}
''',
      [lint(173, 5)],
    );
  }

  Future<void> test_alphabetize_unsorted() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields},
  alphabetizeUnsortedMembers: true,
)
class A {
  void zebra() {}
  void apple() {}
  void monkey() {}
}
''',
      [lint(183, 5)],
    );
  }

  Future<void> test_alphabetize_unnamedConstructorAsNew() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.constructors},
  alphabetizeSortedMembers: true,
)
class A {
  A();
  A.other();
  A.zebra();
}
''');
  }

  Future<void> test_alphabetize_unnamedConstructorAsNew_outOfOrder() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.constructors},
  alphabetizeSortedMembers: true,
)
class A {
  A.apple();
  A();
}
''',
      [lint(177, 1)],
    );
  }

  Future<void> test_alphabetize_allOptions_pass() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields, .constructors},
  alphabetizeSortedMembers: true,
  alphabetizeUnsortedMembers: true,
)
class A {
  int apple = 0;
  int banana = 0;
  int zebra = 0;

  A();
  A.create();
  A.named();

  void aMethod() {}
  void bMethod() {}
  void zMethod() {}
}
''');
  }

  // ========================================================================
  // Spacing configuration tests
  // ========================================================================

  Future<void> test_spacing_linesBetweenSame() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields},
  linesBetweenSameSortMembers: 2,
)
class A {
  int field1 = 0;
  int field2 = 0;
}
''',
      [lint(180, 6)],
    );
  }

  Future<void> test_spacing_linesAroundSorted() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields, .constructors},
  linesAroundSortedMembers: 3,
)
class A {
  int field = 0;
  A();
}
''',
      [lint(187, 1)],
    );
  }

  Future<void> test_spacing_linesAroundUnsorted() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields},
  linesAroundUnsortedMembers: 2,
)
class A {
  int field = 0;
  void method() {}
}
''',
      [lint(179, 6)],
    );
  }

  Future<void> test_spacing_allOptions_pass() async {
    await assertNoDiagnostics('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields, .constructors},
  linesBetweenSameSortMembers: 1,
  linesAroundSortedMembers: 2,
  linesAroundUnsortedMembers: 3,
)
class A {
  int field1 = 0;

  int field2 = 0;


  A();

  A.named();



  void method() {}
}
''');
  }

  // ========================================================================
  // Modifier-specific tests
  // ========================================================================

  Future<void> test_modifier_abstract() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .abstract(.methods),
  .methods,
})
abstract class A {
  void concreteMethod() {}
  void abstractMethod();
}
''',
      [error(rule.diagnosticCode, 189, 14)],
    );
  }

  Future<void> test_modifier_static() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .static(.fields),
  .fields,
})
class A {
  int instanceField = 0;
  static int staticField = 0;
}
''',
      [error(rule.diagnosticCode, 180, 11)],
    );
  }

  Future<void> test_modifier_const() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .const_(.fields),
  .fields,
})
class A {
  int regularField = 0;
  static const int constant = 1;
}
''',
      [error(rule.diagnosticCode, 185, 8)],
    );
  }

  Future<void> test_modifier_const_constructor() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .const_(.constructors),
  .constructors,
})
class A {
  A();
  const A.constant();
}
''',
      [error(rule.diagnosticCode, 171, 8)],
    );
  }

  Future<void> test_modifier_final() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .final_(.fields),
  .fields,
})
class A {
  int mutableField = 0;
  final int finalField = 1;
}
''',
      [error(rule.diagnosticCode, 178, 10)],
    );
  }

  Future<void> test_modifier_late() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .late(.fields),
  .fields,
})
class A {
  int regularField = 0;
  late int lateField;
}
''',
      [error(rule.diagnosticCode, 175, 9)],
    );
  }

  Future<void> test_modifier_var() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .var_(.fields),
  .fields,
})
class A {
  int typedField = 0;
  var varField = 0;
}
''',
      [error(rule.diagnosticCode, 168, 8)],
    );
  }

  Future<void> test_modifier_initialized() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .initialized(.fields),
  .fields,
})
class A {
  int? uninitializedField;
  int initializedField = 0;
}
''',
      [error(rule.diagnosticCode, 180, 16)],
    );
  }

  Future<void> test_modifier_nullable() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .nullable(.fields),
  .fields,
})
class A {
  int nonNullableField = 0;
  int? nullableField;
}
''',
      [error(rule.diagnosticCode, 179, 13)],
    );
  }

  Future<void> test_modifier_nullable_methods() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .nullable(.methods),
  .methods,
})
class A {
  int nonNullableMethod() => 0;
  int? nullableMethod() => null;
}
''',
      [error(rule.diagnosticCode, 185, 14)],
    );
  }

  Future<void> test_modifier_private() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .private(.fields),
  .fields,
})
class A {
  int publicField = 0;
  int _privateField = 0;
}
''',
      [error(rule.diagnosticCode, 172, 13)],
    );
  }

  Future<void> test_modifier_private_methods() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .private(.methods),
  .methods,
})
class A {
  int publicMethod() => 0;
  int _privateMethod() => 0;
}
''',
      [error(rule.diagnosticCode, 178, 14)],
    );
  }

  Future<void> test_modifier_private_constructors() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .private(.constructors),
  .constructors,
})
class A {
  A();
  A._private();
}
''',
      [error(rule.diagnosticCode, 166, 8)],
    );
  }

  Future<void> test_modifier_public() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .public(.fields),
  .fields,
})
class A {
  int _privateField = 0;
  int publicField = 0;
}
''',
      [error(rule.diagnosticCode, 173, 11)],
    );
  }

  Future<void> test_modifier_public_methods() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .public(.methods),
  .methods,
})
class A {
  int _privateMethod() => 0;
  int publicMethod() => 0;
}
''',
      [error(rule.diagnosticCode, 179, 12)],
    );
  }

  Future<void> test_modifier_public_constructors() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .public(.constructors),
  .constructors,
})
class A {
  A._private();
  A();
}
''',
      [error(rule.diagnosticCode, 172, 1)],
    );
  }

  Future<void> test_modifier_external() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .external(.methods),
  .methods,
})
class A {
  void regularMethod() {}
  external void externalMethod();
}
''',
      [error(rule.diagnosticCode, 188, 14)],
    );
  }

  Future<void> test_modifier_external_field() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .external(.fields),
  .fields,
})
class A {
  int regularField = 0;
  external int externalField;
}
''',
      [error(rule.diagnosticCode, 183, 13)],
    );
  }

  Future<void> test_modifier_external_constructor() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .external(.constructors),
  .constructors,
})
class A {
  A();
  external A.external();
}
''',
      [error(rule.diagnosticCode, 176, 8)],
    );
  }

  Future<void> test_modifier_factory() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .factory_(.constructors),
  .constructors,
})
class A {
  A();
  factory A.create() => A();
}
''',
      [error(rule.diagnosticCode, 175, 6)],
    );
  }

  Future<void> test_modifier_named() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .named(.constructors),
  .constructors,
})
class A {
  A();
  A.named();
}
''',
      [error(rule.diagnosticCode, 164, 5)],
    );
  }

  Future<void> test_modifier_unnamed() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .unnamed(.constructors),
  .constructors,
})
class A {
  A.named();
  A();
}
''',
      [error(rule.diagnosticCode, 170, 1)],
    );
  }

  Future<void> test_modifier_redirecting() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .redirecting(.constructors),
  .constructors,
})
class A {
  A();
  factory A.redirect() = A;
}
''',
      [error(rule.diagnosticCode, 178, 8)],
    );
  }

  Future<void> test_modifier_operator() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .operator(.methods),
  .methods,
})
class A {
  void regularMethod() {}
  bool operator ==(Object other) => identical(this, other);
}
''',
      [error(rule.diagnosticCode, 188, 2)],
    );
  }

  Future<void> test_modifier_overridden() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

abstract class Base {
  void method();
}

@SortingMembers({
  .overridden(.methods),
  .methods,
})
class A extends Base {
  void regularMethod() {}
  @override
  void method() {}
}
''',
      [error(rule.diagnosticCode, 248, 6)],
    );
  }

  Future<void> test_modifier_overridden_fields() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

abstract class Base {
  int field;
}

@SortingMembers({
  .overridden(.fields),
  .fields,
})
class A extends Base {
  int regularField = 0;
  @override
  int field = 1;
}
''',
      [
        error(
          CompileTimeErrorCode.notInitializedNonNullableInstanceField,
          108,
          5,
        ),
        error(rule.diagnosticCode, 239, 5),
      ],
    );
  }

  Future<void> test_modifier_new() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

abstract class Base {
  void method();
}

@SortingMembers({
  .new_(.methods),
  .methods,
})
class A extends Base {
  @override
  void method() {}
  void newMethod() {}
}
''',
      [error(rule.diagnosticCode, 235, 9)],
    );
  }

  Future<void> test_modifier_new_fields() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

abstract class Base {
  int field;
}

@SortingMembers({
  .new_(.fields),
  .fields,
})
class A extends Base {
  @override
  int field = 1;
  int newField = 0;
}
''',
      [
        error(
          CompileTimeErrorCode.notInitializedNonNullableInstanceField,
          108,
          5,
        ),
        error(rule.diagnosticCode, 226, 8),
      ],
    );
  }

  Future<void> test_modifier_instance() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .instance(.fields),
  .fields,
})
class A {
  static int staticField = 0;
  int instanceField = 0;
}
''',
      [lint(180, 13)],
    );
  }

  Future<void> test_modifier_instance_method() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .instance(.methods),
  .methods,
})
class A {
  static void staticMethod() {}
  void instanceMethod() {}
}
''',
      [lint(185, 14)],
    );
  }

  Future<void> test_modifier_dynamic() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .dynamic(.fields),
  .fields,
})
class A {
  int typedField = 0;
  var dynamicField = 0;
}
''',
      [lint(171, 12)],
    );
  }

  Future<void> test_modifier_dynamic_method() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .dynamic(.methods),
  .methods,
})
class A {
  void typedMethod() {}
  dynamicMethod() {}
}
''',
      [lint(171, 13)],
    );
  }

  Future<void> test_modifier_typed() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .typed(.fields),
  .fields,
})
class A {
  var dynamicField = 0;
  int typedField = 0;
}
''',
      [lint(171, 10)],
    );
  }

  Future<void> test_modifier_typed_method() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .typed(.methods),
  .methods,
})
class A {
  dynamicMethod() {}
  void typedMethod() {}
}
''',
      [lint(171, 11)],
    );
  }
}
