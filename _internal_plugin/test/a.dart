import 'package:essential_lints_annotations/essential_lints_annotations.dart';
import 'package:essential_lints_annotations/src/_internal/invalid_members.dart';
import 'package:essential_lints_annotations/src/sorting_members/sort_declarations.dart';

void foo(SortDeclaration _) {
  foo(A.another(.new(.c)));
}

@InvalidMembers([th<Methods>()])
extension type A._(Public p) implements Public {
  factory A(B _) => throw UnimplementedError();

  factory A.another(A _) => throw UnimplementedError();
}

extension type const B._(Methods m) implements Methods {
  static const c = B._(SortDeclaration.methods as Methods);
}
