import 'package:meta/meta_meta.dart';

import 'utils/package_option.dart';
import 'utils/subtype_annotation.dart';
import 'utils/subtype_option.dart';

/// {@template subtype_deannotating}
/// Annotation that stops propagation of annotation rules to subtypes.
/// {@endtemplate}
@Target({
  TargetKind.classType,
  TargetKind.extensionType,
  TargetKind.mixinType,
  TargetKind.enumType,
})
class SubtypeDeannotating implements SubtypeAnnotation {
  /// {@macro subtype_deannotating}
  const SubtypeDeannotating({
    required this.annotations,
    this.option = SubtypeOption.all,
    this.packageOption = PackageOption.inherit,
  });

  /// The required annotations for the subtype.
  final List<Object> annotations;

  /// {@macro subtype_option}
  @override
  final SubtypeOption option;

  /// {@macro package_option}
  @override
  final PackageOption packageOption;
}
