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
    this.onlyConcrete = false,
  });

  /// The required annotations for the subtype.
  final List<Object> annotations;

  /// Whether the annotation should only be applied to concrete subtypes.
  final bool onlyConcrete;
}
