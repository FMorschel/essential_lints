import 'package:meta/meta_meta.dart';

import 'utils/package_option.dart';
import 'utils/subtype_annotation.dart';
import 'utils/subtype_option.dart';

/// {@template subtype_unnaming}
/// Annotation that stops propagation of naming rules to subtypes.
/// {@endtemplate}
@Target({
  TargetKind.classType,
  TargetKind.extensionType,
  TargetKind.mixinType,
  TargetKind.enumType,
})
class SubtypeUnnaming implements SubtypeAnnotation {
  /// {@macro subtype_unnaming}
  const SubtypeUnnaming({
    this.prefix,
    this.containing,
    this.suffix,
    this.option = SubtypeOption.all,
    this.packageOption = PackageOption.inherit,
  });

  /// The required prefix for the subtype name.
  final String? prefix;

  /// The required part of the name of the subtype.
  final String? containing;

  /// The required suffix for the subtype name.
  final String? suffix;

  /// {@macro subtype_option}
  @override
  final SubtypeOption option;

  /// {@macro package_option}
  @override
  final PackageOption packageOption;
}
