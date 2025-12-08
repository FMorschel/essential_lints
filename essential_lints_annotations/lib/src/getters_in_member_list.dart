// ignore_for_file: annotation members don't need to be public

import 'package:meta/meta_meta.dart';

/// A type alias for [TypeHolder].
///
/// This is to simplify the syntax when creating instances of [TypeHolder].
// ignore: camel_case_types
typedef th<T> = TypeHolder<T>;

/// {@template getters_in_member_list}
/// Annotations for the `getters-in-member-list` lint rule.
/// {@endtemplate}
@Target({TargetKind.classType})
class GettersInMemberList {
  /// {@macro getters_in_member_list}
  const GettersInMemberList({
    required this.memberListName,
    this.getters = true,
    this.fields = true,
    this.types = const <TypeHolder<Object?>>[],
    this.superTypes = const <TypeHolder<Object?>>[],
  });

  /// The name of the member list to check.
  final String memberListName;

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
}

/// {@template type_holder}
/// A type holder to be used in [GettersInMemberList.types].
///
/// We suggest using the type alias [th] to create instances of this class. This
/// way you have less characters to write.
/// {@endtemplate}
class TypeHolder<T> {
  /// {@macro type_holder}
  const TypeHolder();
}
