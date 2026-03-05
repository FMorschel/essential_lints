import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:essential_lints_annotations/essential_lints_annotations.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../rules/analysis_rule.dart';
import 'essential_lint_fixes.dart';

/// {@template correction_producer_logger}
/// The base class for all essential correction producers with logging.
/// {@endtemplate}
@SubtypeAnnotating(
  annotations: [staticLoggerEnforcement],
  option: .onlyConcrete,
)
abstract class CorrectionProducerLogger extends ResolvedCorrectionProducer {
  /// {@macro correction_producer_logger}
  CorrectionProducerLogger(this.logger, {required super.context});

  /// The logger for this correction producer.
  final Logger logger;
}

/// {@template lint_fix}
/// The base class for all essential lint fixes.
/// {@endtemplate}
@SubtypeNaming(suffix: 'Fix')
@staticLoggerEnforcement
mixin LintFix on CorrectionProducerLogger {
  static final Logger _logger = EssentialLintsPlugin.newLogger('LintFix');

  /// The essential lint fix associated with this correction producer.
  EssentialLintFixes get fix;

  @override
  FixKind get fixKind {
    _logger.log(.INFO, 'Setting fix kind for ${fix.name}');
    return fix.fixKind;
  }

  /// The line info for the current compilation unit.
  LineInfo get lineInfo => unit.lineInfo;
}

/// {@template warning_fix}
/// The base class for all essential warning fixes.
/// {@endtemplate}
@SubtypeNaming(suffix: 'Fix')
@staticLoggerEnforcement
mixin WarningFix on CorrectionProducerLogger {
  static final Logger _logger = EssentialLintsPlugin.newLogger('WarningFix');

  /// The essential warning fix associated with this correction producer.
  EssentialLintWarningFixes get fix;

  @override
  FixKind get fixKind {
    _logger.log(.INFO, 'Setting fix kind for ${fix.name}');
    return fix.fixKind;
  }
}
