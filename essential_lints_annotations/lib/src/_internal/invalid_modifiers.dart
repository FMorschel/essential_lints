import 'package:meta/meta_meta.dart';

import '../../essential_lints_annotations.dart';
import '../sorting_members/sort_declarations.dart';

/// {@template invalid_modifier}
/// A class representing invalid modifiers for a member group.
/// {@endtemplate}
@Target({.classType, .extensionType})
class InvalidModifiers {
  /// {@macro invalid_modifier}
  const InvalidModifiers(this.invalidModifiers);

  /// The set of invalid modifiers.
  final Set<TypeHolder<Modifier>> invalidModifiers;
}
