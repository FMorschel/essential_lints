import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template replace_with_first_fix}
/// A fix that replaces `[0]` with `.first`.
/// {@endtemplate}
class ReplaceWithFirstFix extends ResolvedCorrectionProducer with LintFix {
  /// {@macro replace_with_first_fix}
  ReplaceWithFirstFix({required super.context});

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintFixes get fix => .replaceWithFirst;

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
        '.first',
      );
    });
  }
}
