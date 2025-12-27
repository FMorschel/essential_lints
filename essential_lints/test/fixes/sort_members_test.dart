import 'package:_internal_testing/dependencies.dart';
import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:essential_lints/src/fixes/essential_lint_fixes.dart';
import 'package:essential_lints/src/warnings/sorting_members.dart';
import 'package:logging/logging.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/fix_test_processor.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  defineReflectiveSuite(() {
    defineReflectiveTests(SortMembersTest);
  });
}

@reflectiveTest
class SortMembersTest extends WarningFixTestProcessor
    with AnnotationsDependencyMixin {
  @override
  EssentialLintWarningFixes get fix => .sortMembers;

  @override
  AnalysisRule get rule => SortingMembersRule();

  @override
  Future<void> setUp() async {
    await addAnnotationsDependency();
    super.setUp();
  }

  Future<void> test_sortFieldsAndMethods() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.fields, .methods})
class MyClass {
  void method1() {}

  int field1 = 0;

  void method2() {}

  int field2 = 0;
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.fields, .methods})
class MyClass {
  int field1 = 0;
  int field2 = 0;
  void method1() {}
  void method2() {}
}
''');
  }

  Future<void> test_sortWithConstructors() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.constructors, .fields, .methods})
class MyClass {
  void method1() {}

  int field1 = 0;

  MyClass();

  int field2 = 0;
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.constructors, .fields, .methods})
class MyClass {
  MyClass();
  int field1 = 0;
  int field2 = 0;
  void method1() {}
}
''');
  }

  Future<void> test_sortWithAlphabetization() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.methods}, alphabetizeSortedMembers: true)
class MyClass {
  void zebra() {}

  void apple() {}

  void banana() {}
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.methods}, alphabetizeSortedMembers: true)
class MyClass {
  void apple() {}

  void banana() {}
  void zebra() {}
}
''');
  }

  Future<void> test_sortWithSpacingRules() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields, .methods},
  linesAroundSortedMembers: 1,
)
class MyClass {
  void method1() {}
  int field1 = 0;
  void method2() {}
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields, .methods},
  linesAroundSortedMembers: 1,
)
class MyClass {
  int field1 = 0;

  void method1() {}
  void method2() {}
}
''');
  }

  Future<void> test_sort_keep() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.methods, .fields})
class MyClass {
  void method1() {}

  int field1 = 0;

  void method2() {}
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.methods, .fields})
class MyClass {
  void method1() {}
  void method2() {}

  int field1 = 0;
}
''');
  }

  Future<void> test_sort_keep2() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.fields, .methods})
class MyClass {
  void method1() {}

  int field1 = 0;
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.fields, .methods})
class MyClass {
  int field1 = 0;
  void method1() {}
}
''');
  }

  Future<void> test_sort_keep_alphabetization() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.methods, .fields},
  alphabetizeSortedMembers: true,
)
class MyClass {
  void first() {}

  void third() {}

  int field1 = 0;

  void second() {}
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.methods, .fields},
  alphabetizeSortedMembers: true,
)
class MyClass {
  void first() {}
  void second() {}

  void third() {}

  int field1 = 0;
}
''');
  }

  Future<void> test_sortGettersAndSetters() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.getters, .setters})
class MyClass {
  set value(int v) {}

  int get value => 0;

  set name(String n) {}

  String get name => '';
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.getters, .setters})
class MyClass {
  int get value => 0;
  String get name => '';
  set value(int v) {}
  set name(String n) {}
}
''');
  }

  Future<void> test_sortStaticAndInstance() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.static(.fields), .instance(.fields)})
class MyClass {
  int instanceField = 0;

  static int staticField = 0;

  int anotherInstance = 1;
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.static(.fields), .instance(.fields)})
class MyClass {
  static int staticField = 0;
  int instanceField = 0;
  int anotherInstance = 1;
}
''');
  }

  Future<void> test_sortPublicAndPrivate() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.public(.fields), .private(.fields)})
class MyClass {
  int _privateField = 0;

  int publicField = 0;

  int _anotherPrivate = 1;
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.public(.fields), .private(.fields)})
class MyClass {
  int publicField = 0;
  int _privateField = 0;
  int _anotherPrivate = 1;
}
''', filter: (diagnostic) => diagnostic.diagnosticCode == rule.diagnosticCode);
  }

  Future<void> test_sortFinalConstVar() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.const_(.fields), .final_(.fields), .var_(.fields)})
class MyClass {
  var varField = 0;

  static const constField = 1;

  final finalField = 2;
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.const_(.fields), .final_(.fields), .var_(.fields)})
class MyClass {
  static const constField = 1;

  final finalField = 2;
  var varField = 0;
}
''');
  }

  Future<void> test_sortLateFields() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.late(.fields), .fields})
class MyClass {
  int normalField = 0;

  late int lateField;

  int anotherNormal = 1;
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.late(.fields), .fields})
class MyClass {
  late int lateField;
  int normalField = 0;
  int anotherNormal = 1;
}
''');
  }

  Future<void> test_sortAbstractMethods() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.abstract(.methods), .methods})
abstract class MyClass {
  void concreteMethod() {}

  void abstractMethod();

  void anotherConcrete() {}
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.abstract(.methods), .methods})
abstract class MyClass {
  void abstractMethod();
  void concreteMethod() {}
  void anotherConcrete() {}
}
''');
  }

  Future<void> test_sortExternalMethods() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.external(.methods), .methods})
class MyClass {
  void normalMethod() {}

  external void externalMethod();

  void anotherNormal() {}
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.external(.methods), .methods})
class MyClass {
  external void externalMethod();
  void normalMethod() {}
  void anotherNormal() {}
}
''');
  }

  Future<void> test_sortFactoryConstructors() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.factory_(.constructors), .constructors})
class MyClass {
  MyClass();

  factory MyClass.create() => MyClass();

  MyClass.named();
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.factory_(.constructors), .constructors})
class MyClass {
  factory MyClass.create() => MyClass();
  MyClass();
  MyClass.named();
}
''');
  }

  Future<void> test_sortNamedAndUnnamedConstructors() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.unnamed(.constructors), .named(.constructors)})
class MyClass {
  MyClass.named();

  MyClass();

  MyClass.another();
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.unnamed(.constructors), .named(.constructors)})
class MyClass {
  MyClass();
  MyClass.named();
  MyClass.another();
}
''');
  }

  Future<void> test_sortSpecificMembersByName() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.field(#id), .field(#name), .fields})
class MyClass {
  int age = 0;

  String name = '';

  int id = 0;

  bool active = true;
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.field(#id), .field(#name), .fields})
class MyClass {
  int id = 0;
  String name = '';
  int age = 0;
  bool active = true;
}
''');
  }

  Future<void> test_sortSpecificConstructorByName() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.constructor(), .constructor(#fromJson), .constructors})
class MyClass {
  MyClass.other();

  MyClass.fromJson(Map<String, dynamic> json);

  MyClass();
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.constructor(), .constructor(#fromJson), .constructors})
class MyClass {
  MyClass();
  MyClass.fromJson(Map<String, dynamic> json);
  MyClass.other();
}
''');
  }

  Future<void> test_sortWithLinesBetweenSameSort() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields, .methods},
  linesBetweenSameSortMembers: 1,
)
class MyClass {
  void method1() {}
  int field1 = 0;
  void method2() {}
  int field2 = 0;
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields, .methods},
  linesBetweenSameSortMembers: 1,
)
class MyClass {
  int field1 = 0;

  int field2 = 0;
  void method1() {}

  void method2() {}
}
''');
  }

  Future<void> test_sortWithLinesAroundUnsorted() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields},
  linesAroundUnsortedMembers: 2,
)
class MyClass {
  int field1 = 0;
  void unsortedMethod() {}
  int field2 = 0;
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields},
  linesAroundUnsortedMembers: 2,
)
class MyClass {
  int field1 = 0;


  void unsortedMethod() {}


  int field2 = 0;
}
''');
  }

  Future<void> test_sortWithAlphabetizeUnsorted() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields},
  alphabetizeUnsortedMembers: true,
)
class MyClass {
  int field1 = 0;

  void zebra() {}

  int field2 = 0;

  void apple() {}
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields},
  alphabetizeUnsortedMembers: true,
)
class MyClass {
  int field1 = 0;
  int field2 = 0;

  void apple() {}
  void zebra() {}
}
''');
  }

  Future<void> test_sortCombinedModifiers() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .static(.const_(.public(.fields))),
  .static(.final_(.public(.fields))),
  .static(.public(.fields)),
  .private(.fields),
})
class MyClass {
  int _private = 0;

  static int publicStatic = 1;

  static final int publicStaticFinal = 2;

  static const int publicStaticConst = 3;
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({
  .static(.const_(.public(.fields))),
  .static(.final_(.public(.fields))),
  .static(.public(.fields)),
  .private(.fields),
})
class MyClass {
  static const int publicStaticConst = 3;
  static final int publicStaticFinal = 2;
  static int publicStatic = 1;
  int _private = 0;
}
''', filter: (diagnostic) => diagnostic.diagnosticCode == rule.diagnosticCode);
  }

  Future<void> test_sortGettersSettersCombined() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.gettersSetters, .fields})
class MyClass {
  int field = 0;

  set value(int v) {}

  int get value => 0;
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.gettersSetters, .fields})
class MyClass {
  set value(int v) {}

  int get value => 0;
  int field = 0;
}
''');
  }

  Future<void> test_sortFieldsGettersSetters() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.fieldsGettersSetters, .methods})
class MyClass {
  void method() {}

  int field = 0;

  set value(int v) {}

  int get value => 0;
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.fieldsGettersSetters, .methods})
class MyClass {
  int field = 0;

  set value(int v) {}

  int get value => 0;
  void method() {}
}
''');
  }

  Future<void> test_sortOverriddenMembers() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.overridden(.methods), .methods})
class MyClass {
  void customMethod() {}

  @override
  String toString() => '';

  void anotherCustom() {}
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers({.overridden(.methods), .methods})
class MyClass {
  @override
  String toString() => '';
  void customMethod() {}
  void anotherCustom() {}
}
''');
  }

  Future<void> test_sortAllSpacingOptions() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields, .methods},
  linesBetweenSameSortMembers: 1,
  linesAroundSortedMembers: 2,
  linesAroundUnsortedMembers: 1,
)
class MyClass {
  void method1() {}
  int field1 = 0;
  void method2() {}
  int field2 = 0;
  String get unsorted => '';
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.fields, .methods},
  linesBetweenSameSortMembers: 1,
  linesAroundSortedMembers: 2,
  linesAroundUnsortedMembers: 1,
)
class MyClass {
  int field1 = 0;

  int field2 = 0;

  String get unsorted => '';

  void method1() {}

  void method2() {}
}
''');
  }

  Future<void> test_sortAllSpacingOptionsWithAlphabetization() async {
    await resolveTestCode('''
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
  void zebra() {}
  String get unsorted2 => '';
  String get unsorted => '';
  int fieldB = 0;
  void apple() {}
  int fieldA = 0;
}
''');
    await assertHasFix('''
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

  Future<void> test_unsortedBetweenSorted() async {
    await resolveTestCode('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.methods},
  linesAroundSortedMembers: 1,
  linesAroundUnsortedMembers: 2,
)
class MyClass {
  void method1() {}
  int field1 = 0;
  void method2() {}
}
''');
    await assertHasFix('''
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SortingMembers(
  {.methods},
  linesAroundSortedMembers: 1,
  linesAroundUnsortedMembers: 2,
)
class MyClass {
  void method1() {}


  int field1 = 0;


  void method2() {}
}
''');
  }
}
