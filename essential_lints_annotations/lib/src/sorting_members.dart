import 'package:meta/meta_meta.dart';

import 'sorting_members/sort_declarations.dart';

/// {@template sorting_members}
/// Annotation for sorting members.
/// {@endtemplate}
@Target({
  TargetKind.classType,
  TargetKind.mixinType,
  TargetKind.extensionType,
  TargetKind.extension,
  TargetKind.enumType,
})
class SortingMembers {
  /// {@macro sorting_members}
  const SortingMembers(this.declarations);

  /// The sort declarations.
  final Set<SortDeclaration> declarations;
}
