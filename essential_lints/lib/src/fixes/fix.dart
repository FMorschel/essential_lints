import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';

import 'essential_lint_fixes.dart';

/// {@template lint_fix}
/// The base class for all essential lint fixes.
/// {@endtemplate}
mixin LintFix on ResolvedCorrectionProducer {
  /// The essential lint fix associated with this correction producer.
  EssentialLintFixes get fix;

  @override
  FixKind get fixKind => fix.fixKind;
}

/// {@template warning_fix}
/// The base class for all essential lint fixes.
/// {@endtemplate}
mixin WarningFix on ResolvedCorrectionProducer {
  /// The essential lint fix associated with this correction producer.
  EssentialLintWarningFixes get fix;

  @override
  FixKind get fixKind => fix.fixKind;
}
