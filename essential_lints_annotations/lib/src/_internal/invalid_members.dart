import 'package:meta/meta_meta.dart';

import '../sorting_members/sort_declarations.dart';
import '../utils/type_holder.dart';

/// {@template invalid_members}
/// A class representing invalid members for a modifier.
/// {@endtemplate}
@Target({.classType, .extensionType})
class InvalidMembers {
  /// {@macro invalid_members}
  const InvalidMembers(this.invalidMembers);

  /// The set of invalid members.
  final Set<TypeHolder<Group>> invalidMembers;
}
