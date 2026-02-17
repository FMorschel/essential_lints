import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../rules/analysis_rule.dart';
import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template replace_with_first_fix}
/// A fix that replaces `[0]` with `.first`.
/// {@endtemplate}
@staticLoggerEnforcement
class ReplaceWithFirstFix extends CorrectionProducerLogger with LintFix {
  /// {@macro replace_with_first_fix}
  ReplaceWithFirstFix({required super.context}) : super(_logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'ReplaceWithFirstFix',
  );

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintFixes get fix => .replaceWithFirst;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    logger.info('ReplaceWithFirstFix.compute() started');
    var diagnostic = this.diagnostic;
    if (diagnostic == null) {
      logger.finer('Diagnostic is null, returning');
      return;
    }
    logger.fine(
      'Diagnostic found at offset ${diagnostic.offset}, length '
      '${diagnostic.length}',
    );
    await builder.addDartFileEdit(file, (builder) {
      logger.finer('Applying replacement of [0] with .first');
      builder.addSimpleReplacement(
        range.startOffsetEndOffset(
          diagnostic.offset,
          diagnostic.offset + diagnostic.length,
        ),
        '.first',
      );
    });
    logger.info('ReplaceWithFirstFix.compute() completed successfully');
  }
}
