import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../rules/analysis_rule.dart';
import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template replace_with_squared_box_fix}
/// A fix that replaces an empty Container with a SizedBox.shrink().
/// {@endtemplate}
@staticLoggerEnforcement
class ReplaceWithSizedBoxFix extends CorrectionProducerLogger with LintFix {
  /// {@macro replace_with_squared_box_fix}
  ReplaceWithSizedBoxFix({required super.context}) : super(_logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'ReplaceWithSizedBoxFix',
  );

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintFixes get fix => .replaceWithSizedBox;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    if (diagnostic == null) return;
    await builder.addDartFileEdit(file, (builder) {
      builder.addSimpleReplacement(range.node(node), 'SizedBox.shrink');
    });
  }
}
