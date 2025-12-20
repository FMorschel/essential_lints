import 'package:meta/meta_meta.dart';

/// {@template mutually_exclusive}
/// An annotation to mark mutually exclusive modifiers.
///
/// When [optional] is `true`, this modifier is optional in the group.
/// Other modifiers can exist without this one, but if this one exists,
/// all other non-optional modifiers in the group must also exist.
/// {@endtemplate}
@Target({.classType})
class MutuallyExclusive {
  /// {@macro mutually_exclusive}
  const MutuallyExclusive(this.id, {this.optional = false});

  /// The unique identifier for the mutually exclusive group.
  final Symbol id;

  /// Whether this modifier is optional in the group.
  ///
  /// When `true`, other modifiers in the group can exist without this one.
  /// However, if this modifier exists, all other non-optional modifiers
  /// in the group must also exist.
  final bool optional;
}
