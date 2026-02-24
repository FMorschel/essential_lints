import 'package_option.dart';
import 'subtype_option.dart';

/// {@template subtype_annotation}
/// Base class for annotations that apply to subtypes.
/// {@endtemplate}
abstract class SubtypeAnnotation {
  /// {@macro subtype_option}
  SubtypeOption get option;

  /// {@macro package_option}
  PackageOption get packageOption;
}
