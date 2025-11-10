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
  )
  ;

  const EssentialLintWarningFixes(this.fixKind);

  /// The fix kind associated with this lint fix.
  @override
  final FixKind fixKind;
}
