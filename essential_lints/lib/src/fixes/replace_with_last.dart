import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template replace_with_last_fix}
/// A fix that replaces `[length - 1]` with `.last`.
/// {@endtemplate}
class ReplaceWithLastFix extends ResolvedCorrectionProducer with LintFix {
  /// {@macro replace_with_last_fix}
  ReplaceWithLastFix({required super.context});

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintFixes get fix => .replaceWithLast;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    var diagnostic = this.diagnostic;
    if (diagnostic == null) return;
    await builder.addDartFileEdit(file, (builder) {
      builder.addSimpleReplacement(
        range.startOffsetEndOffset(
          diagnostic.offset,
          diagnostic.offset + diagnostic.length,
        ),
        '.last',
      );
    });
  }
}
