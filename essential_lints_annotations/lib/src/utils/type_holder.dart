/// @docImport '../getters_in_member_list.dart';
library;

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

/// A type alias for [TypeHolder].
///
/// This is to simplify the syntax when creating instances of [TypeHolder].
// ignore: camel_case_types
typedef th<T> = TypeHolder<T>;
