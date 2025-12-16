import 'package:meta/meta_meta.dart';

import '../sorting_members/sort_declarations.dart';

/// {@template consider}
/// Notes that the annotated sort declaration should be considered the given
/// type [T].
/// {@endtemplate}
@Target({.constructor, .field})
class Consider<T extends SortDeclaration> {
  /// {@macro consider}
  const Consider();
}
