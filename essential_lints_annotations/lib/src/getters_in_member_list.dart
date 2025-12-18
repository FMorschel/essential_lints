// ignore_for_file: annotation members don't need to be public

import 'package:meta/meta_meta.dart';

import 'utils/type_holder.dart';

/// {@template getters_in_member_list}
/// Annotations for the `getters_in_member_list` lint rule.
/// {@endtemplate}
@Target({
  .classType,
  .mixinType,
  .extensionType,
  .extension,
  .enumType,
})
class GettersInMemberList {
  /// {@macro getters_in_member_list}
  const GettersInMemberList({
    required this.memberListName,
    this.getters = true,
    this.fields = true,
    this.types = const <TypeHolder<Object?>>[],
    this.superTypes = const <TypeHolder<Object?>>[],
    this.membersOption = .instance,
  });

  /// The name of the member list to check.
  final Symbol memberListName;

  /// The types of members to check.
  ///
  /// If empty, all types are checked.
  final List<TypeHolder<Object?>> types;

  /// The super types of members to check.
  ///
  /// If empty, all types are checked.
  final List<TypeHolder<Object?>> superTypes;

  /// Whether to check for getters.
  final bool getters;

  /// Whether to check for fields.
  final bool fields;

  /// The members option to check.
  final MembersOption membersOption;
}

/// {@template members_options}
/// Options for members to check.
/// {@endtemplate}
enum MembersOption {
  /// Check only instance members.
  instance,

  /// Check only static members.
  static,

  /// Check both instance and static members.
  all,
}
