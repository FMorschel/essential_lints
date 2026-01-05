import 'package:meta/meta_meta.dart';

import 'utils/subtype_option.dart';

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
    this.option = SubtypeOption.all,
  });

  /// The required annotations for the subtype.
  final List<Object> annotations;

  /// {@macro subtype_option}
  final SubtypeOption option;
}
