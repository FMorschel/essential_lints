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
  numericConstantStyle(
    FixKind(
      'dart.fix.numericConstantStyle',
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

  /// Fix to replace `BorderRadius.circular` with `BorderRadius.all`.
  replaceWithBorderRadiusAll(
    FixKind(
      'dart.fix.replaceWithBorderRadiusAll',
      DartFixKindPriority.standard,
      'Replace with BorderRadius.all',
    ),
  ),

  /// Fix to use direct imports instead of exports within the same package.
  samePackageDirectImportFix(
    FixKind(
      'dart.fix.samePackageDirectImport',
      DartFixKindPriority.standard,
      'Use direct import',
    ),
  ),

  /// Fix to change the type annotation of a closure parameter
  /// to use the defined type.
  useDefinedType(
    FixKind(
      'dart.fix.useDefinedType',
      DartFixKindPriority.standard,
      'Use defined type',
    ),
  ),

  /// Fix to add current stack when completing a completer with an error.
  addCurrentStack(
    FixKind(
      'dart.fix.addCurrentStack',
      DartFixKindPriority.standard,
      'Add current stack',
    ),
  ),

  /// Fix to remove useless else statements.
  removeUselessElse(
    FixKind(
      'dart.fix.removeUselessElse',
      DartFixKindPriority.standard,
      'Remove useless else',
    ),
  ),

  /// Fix to replace `[0]` with `.first`.
  replaceWithFirst(
    FixKind(
      'dart.fix.replaceWithFirst',
      DartFixKindPriority.standard,
      "Replace with '.first'",
    ),
  ),

  /// Fix to replace `[length - 1]` with `.last`.
  replaceWithLast(
    FixKind(
      'dart.fix.replaceWithLast',
      DartFixKindPriority.standard,
      "Replace with '.last'",
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
  ),

  /// Fix to sort members within a class, mixin, enum, extension or extension
  /// type.
  sortMembers(
    FixKind(
      'dart.fix.sort.members',
      DartFixKindPriority.standard,
      'Sort members',
    ),
  ),
  ;

  const EssentialLintWarningFixes(this.fixKind);

  /// The fix kind associated with this lint fix.
  @override
  final FixKind fixKind;
}
