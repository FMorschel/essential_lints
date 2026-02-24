import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:essential_lints_annotations/essential_lints_annotations.dart';
import 'package:logging/logging.dart';

import '../fixes/fix.dart';
import '../plugin.dart';
import '../rules/analysis_rule.dart';
import 'essential_lint_assists.dart';

/// {@template assist}
/// The base mixin for all essential assists.
/// {@endtemplate}
@SubtypeNaming(containing: 'Assist')
@staticLoggerEnforcement
mixin Assist on CorrectionProducerLogger {
  static final Logger _logger = EssentialLintsPlugin.newLogger('Assist');

  @override
  CorrectionApplicability get applicability => .singleLocation;

  /// The essential assist associated with this correction producer.
  EssentialLintAssists get assist;

  @override
  AssistKind get assistKind {
    _logger.log(.INFO, 'Setting assist kind for ${assist.name}');
    return assist;
  }
}
