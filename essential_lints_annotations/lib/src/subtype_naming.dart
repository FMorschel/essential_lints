import 'package:meta/meta_meta.dart';

import 'utils/package_option.dart';
import 'utils/subtype_option.dart';

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
    this.option = SubtypeOption.all,
    this.packageOption = PackageOption.inherit,
  });

  /// The required prefix for the subtype name.
  final String? prefix;

  /// The required suffix for the subtype name.
  final String? suffix;

  /// The required part of the name of the subtype.
  final String? containing;

  /// {@macro subtype_option}
  final SubtypeOption option;

  /// {@macro package_option}
  final PackageOption packageOption;
}
