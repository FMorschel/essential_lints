import 'package:meta/meta_meta.dart';

/// {@template subtype_naming}
/// Annotations for the `subtype_naming` rule.
/// {@endtemplate}
@Target({
  TargetKind.classType,
  TargetKind.extensionType,
  TargetKind.mixinType,
  TargetKind.enumType,
})
class SubtypeNaming {
  /// {@macro subtype_naming}
  const SubtypeNaming({
    this.prefix,
    this.suffix,
    this.containing,
    this.onlyConcrete = false,
  });

  /// The required prefix for the subtype name.
  final String? prefix;

  /// The required suffix for the subtype name.
  final String? suffix;

  /// The required part of the name of the subtype.
  final String? containing;

  /// Whether the annotation should only be applied to concrete subtypes.
  final bool onlyConcrete;
}
