/// @docImport '../subtype_annotating.dart';
/// @docImport '../subtype_naming.dart';
library;

/// {@template subtype_option}
/// Options for the [SubtypeAnnotating] and [SubtypeNaming] annotation.
/// {@endtemplate}
enum SubtypeOption {
  /// All subtypes should be annotated.
  all,

  /// Only abstract subtypes should be annotated.
  onlyAbstract,

  /// Only concrete subtypes should be annotated.
  onlyConcrete,
}
