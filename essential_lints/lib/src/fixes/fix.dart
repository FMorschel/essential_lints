import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

import 'essential_lint_fixes.dart';

/// {@template lint_fix}
/// The base class for all essential lint fixes.
/// {@endtemplate}
@SubtypeNaming(suffix: 'Fix')
mixin LintFix on ResolvedCorrectionProducer {
  /// The essential lint fix associated with this correction producer.
  EssentialLintFixes get fix;

  @override
  FixKind get fixKind => fix.fixKind;
}

/// {@template warning_fix}
/// The base class for all essential warning fixes.
/// {@endtemplate}
@SubtypeNaming(suffix: 'Fix')
mixin WarningFix on ResolvedCorrectionProducer {
  /// The essential warning fix associated with this correction producer.
  EssentialLintWarningFixes get fix;

  @override
  FixKind get fixKind => fix.fixKind;
}
