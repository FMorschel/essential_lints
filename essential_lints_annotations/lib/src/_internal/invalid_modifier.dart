import 'package:meta/meta_meta.dart';

import '../../essential_lints_annotations.dart';
import '../sorting_members/sort_declarations.dart';

/// {@template invalid_modifier}
/// A class representing an invalid modifier.
/// {@endtemplate}
@Target({.classType, .extensionType})
class InvalidModifiers {
  /// {@macro invalid_modifier}
  const InvalidModifiers(this.modifiers);

  /// The invalid modifier.
  final List<TypeHolder<Modifier>> modifiers;
}
