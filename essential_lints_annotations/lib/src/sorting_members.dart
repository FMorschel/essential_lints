import 'sorting_members/sort_declarations.dart';

/// {@template sorting_members}
/// Annotation for sorting members.
/// {@endtemplate}
class SortingMembers {
  /// {@macro sorting_members}
  const SortingMembers(this.declarations);

  /// The sort declarations.
  final Set<SortDeclaration> declarations;
}
