import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../rules/analysis_rule.dart';
import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template replace_with_last_fix}
/// A fix that replaces `[length - 1]` with `.last`.
/// {@endtemplate}
@staticLoggerEnforcement
class ReplaceWithLastFix extends CorrectionProducerLogger with LintFix {
  /// {@macro replace_with_last_fix}
  ReplaceWithLastFix({required super.context}) : super(_logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'ReplaceWithLastFix',
  );

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintFixes get fix => .replaceWithLast;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    logger.info('ReplaceWithLastFix.compute() started');
    var diagnostic = this.diagnostic;
    if (diagnostic == null) {
      logger.finer('Diagnostic is null, returning');
      return;
    }
    logger.fine(
      'Diagnostic found at offset ${diagnostic.offset}, length'
      ' ${diagnostic.length}',
    );
    await builder.addDartFileEdit(file, (builder) {
      logger.finer('Applying replacement of [length - 1] with .last');
      builder.addSimpleReplacement(
        range.startOffsetEndOffset(
          diagnostic.offset,
          diagnostic.offset + diagnostic.length,
        ),
        '.last',
      );
    });
    logger.info('ReplaceWithLastFix.compute() completed successfully');
  }
}
