import 'package:meta/meta_meta.dart';

/// {@template subtype_naming}
/// Annotations for the `subtype_naming` lint rule.
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
    this.prefixName,
    this.suffixName,
    this.containingName,
  });

  /// The required prefix for the subtype name.
  final String? prefixName;

  /// The required suffix for the subtype name.
  final String? suffixName;

  /// The required part of the name of the subtype.
  final String? containingName;
}
