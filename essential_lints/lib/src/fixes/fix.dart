import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';

import 'essential_lint_fixes.dart';

/// {@template fix}
/// The base class for all essential lint fixes.
/// {@endtemplate}
abstract class Fix extends ResolvedCorrectionProducer {
  /// {@macro fix}
  Fix({required super.context});
}

/// {@template fix}
/// The base class for all essential lint fixes.
/// {@endtemplate}
abstract class LintFix extends Fix {
  /// {@macro fix}
  LintFix({required super.context});

  /// The essential lint fix associated with this correction producer.
  EssentialLintFixes get fix;

  @override
  FixKind get fixKind => fix.fixKind;
}

/// {@template fix}
/// The base class for all essential lint fixes.
/// {@endtemplate}
abstract class WarningFix extends Fix {
  /// {@macro fix}
  WarningFix({required super.context});

  /// The essential lint fix associated with this correction producer.
  EssentialLintWarningFixes get fix;

  @override
  FixKind get fixKind => fix.fixKind;
}
