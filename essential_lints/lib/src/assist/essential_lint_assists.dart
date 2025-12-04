import 'package:analyzer_plugin/utilities/assist/assist.dart';

import '../fixes/essential_lint_fixes.dart';

/// Enum representing essential lint fixes.
enum EssentialLintAssists implements AssistKind {
  /// Assist to remove useless else.
  removeUselessElse.fromFix(
    'dart.assist.remove_useless_else',
    .removeUselessElse,
  ),
  ;

  const EssentialLintAssists(this.id, this._message)
    : associatedFix = null,
      priority = 30;

  const EssentialLintAssists.fromFix(
    this.id,
    EssentialLintFixes this.associatedFix,
  ) : _message = null,
      priority = 30;

  @override
  final String id;

  @override
  final int priority;

  /// The associated fix for this assist, if any.
  final EssentialLintFixes? associatedFix;
  final String? _message;

  @override
  String get message => _message ?? associatedFix!.fixKind.message;
}
