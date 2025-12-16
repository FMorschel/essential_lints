import 'package:meta/meta_meta.dart';

/// {@template subtype_annotating}
/// Annotations for the `subtype_annotating` rule.
/// {@endtemplate}
@Target({
  TargetKind.classType,
  TargetKind.extensionType,
  TargetKind.mixinType,
  TargetKind.enumType,
})
class SubtypeAnnotating {
  /// {@macro subtype_naming}
  const SubtypeAnnotating({
    required this.annotations,
    this.option = .all,
  });

  /// The required annotations for the subtype.
  final List<Object> annotations;

  /// {@macro subtype_annotating_option}
  final SubtypeAnnotatingOption option;
}

/// {@template subtype_annotating_option}
/// Options for the [SubtypeAnnotating] annotation.
/// {@endtemplate}
enum SubtypeAnnotatingOption {
  /// All subtypes should be annotated.
  all,

  /// Only abstract subtypes should be annotated.
  onlyAbstract,

  /// Only concrete subtypes should be annotated.
  onlyConcrete,
}
