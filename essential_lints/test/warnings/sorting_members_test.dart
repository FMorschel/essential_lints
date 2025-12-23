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
