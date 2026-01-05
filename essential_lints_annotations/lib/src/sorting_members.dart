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
  const SortingMembers(
    this.declarations, {
    this.linesBetweenSameSortMembers,
    this.linesAroundSortedMembers,
    this.linesAroundUnsortedMembers,
    this.alphabetizeSortedMembers = false,
    this.alphabetizeUnsortedMembers = false,
  });

  /// The sort declarations.
  final Set<SortDeclaration> declarations;

  /// The number of lines to insert between members of the same sort type.
  final int? linesBetweenSameSortMembers;

  /// The number of lines to insert around sorted members.
  final int? linesAroundSortedMembers;

  /// The number of lines to insert around unsorted members.
  final int? linesAroundUnsortedMembers;

  /// Whether to alphabetize sorted members.
  ///
  /// The only exceptions are members matched by name.
  final bool alphabetizeSortedMembers;

  /// Whether to alphabetize members not matched by any sort declaration.
  final bool alphabetizeUnsortedMembers;
}
