import 'package:analyzer_plugin/utilities/assist/assist.dart';

/// Enum representing essential lint fixes.
enum EssentialLintAssists implements AssistKind {
  /// Assist to remove useless else.
  removeUselessElse(
    'dart.assist.remove_useless_else',
    'Remove useless else',
  )
  ;

  const EssentialLintAssists(this.id, this.message) : priority = 30;

  @override
  final String id;

  @override
  final String message;

  @override
  final int priority;
}
