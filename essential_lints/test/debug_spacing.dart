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
