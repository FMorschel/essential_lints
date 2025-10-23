import 'package:analysis_server_plugin/edit/dart/dart_fix_kind_priority.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';

/// Enum representing essential lint fixes.
enum EssentialLintFixes {
  /// Fix to alphabetize arguments in function, method, or constructor calls.
  alphabetizeArguments(FixKind(
    'dart.fix.alphabetizeArguments',
    DartFixKindPriority.standard,
    'Alphabetize arguments',
  ));

  const EssentialLintFixes(this.fixKind);

  /// The fix kind associated with this lint fix.
  final FixKind fixKind;
}
