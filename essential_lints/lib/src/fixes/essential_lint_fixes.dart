import 'package:analysis_server_plugin/edit/dart/dart_fix_kind_priority.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';

/// {@template enum_fix}
/// A mixin for enums that provide a fix kind.
/// {@endtemplate}
abstract class EnumFix {
  /// The fix kind associated with this lint fix.
  FixKind get fixKind;
}

/// Enum representing essential lint fixes.
enum EssentialLintFixes implements EnumFix {
  /// Fix to alphabetize arguments in function, method, or constructor calls.
  alphabetizeArguments(
    FixKind(
      'dart.fix.alphabetizeArguments',
      DartFixKindPriority.standard,
      'Alphabetize arguments',
    ),
  ),

  /// Fix to prefer formatting of double literals in a consistent style.
  doubleLiteralFormat(
    FixKind(
      'dart.fix.doubleLiteralFormat',
      DartFixKindPriority.standard,
      'Format double literal',
    ),
  ),

  /// Fix to use the padding property of a Container instead of wrapping with
  /// a Padding widget.
  usePaddingProperty(
    FixKind(
      'dart.fix.usePaddingProperty',
      DartFixKindPriority.standard,
      'Use padding property',
    ),
  ),

  /// Fix to replace an empty Container with a SizedBox.shrink().
  replaceWithSizedBox(
    FixKind(
      'dart.fix.replaceWithSizedBox',
      DartFixKindPriority.standard,
      "Replace with 'SizedBox.shrink()'",
    ),
  ),

  /// Fix to sort enum constants alphabetically.
  sortEnumConstants(
    FixKind(
      'dart.fix.sortEnumConstants',
      DartFixKindPriority.standard,
      'Sort enum constants',
    ),
  ),

  /// Fix to replace `Border.all` with `Border.fromBorderSide`.
  replaceWithFromBorderSide(
    FixKind(
      'dart.fix.replaceWithFromBorderSide',
      DartFixKindPriority.standard,
      'Replace with Border.fromBorderSide',
    ),
  ),
  ;

  const EssentialLintFixes(this.fixKind);

  /// The fix kind associated with this lint fix.
  @override
  final FixKind fixKind;
}

/// Enum representing essential lint warning fixes.
enum EssentialLintWarningFixes implements EnumFix {
  /// Fix to add missing members to a class or interface.
  addMissingMembers(
    FixKind(
      'dart.fix.add.missingMembers',
      DartFixKindPriority.standard,
      'Add missing members',
    ),
  ),

  /// Fix to remove an expression from the code.
  removeExpression(
    FixKind(
      'dart.fix.remove.expression',
      DartFixKindPriority.standard,
      'Remove expression',
    ),
  ),

  /// Fix to create a getter for a missing getter reference.
  createGetter(
    FixKind(
      'dart.fix.create.getter',
      DartFixKindPriority.standard,
      'Create getter',
    ),
  )
  ;

  const EssentialLintWarningFixes(this.fixKind);

  /// The fix kind associated with this lint fix.
  @override
  final FixKind fixKind;
}
