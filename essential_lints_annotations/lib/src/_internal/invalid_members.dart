import 'package:meta/meta_meta.dart';

import '../../essential_lints_annotations.dart';
import '../sorting_members/sort_declarations.dart';

/// {@template invalid_members}
/// A class representing invalid members for a modifier.
/// {@endtemplate}
@Target({.classType, .extensionType})
class InvalidMembers {
  /// {@macro invalid_members}
  const InvalidMembers(this.invalidMembers);

  /// The list of invalid members.
  final List<TypeHolder<Group>> invalidMembers;
}
