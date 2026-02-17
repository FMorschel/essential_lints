import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../rules/analysis_rule.dart';
import '../utils/extensions/ast.dart';
import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template replace_with_from_border_side_fix}
/// A fix that replaces `Border.all` with `Border.fromBorderSide`.
/// {@endtemplate}
@staticLoggerEnforcement
class ReplaceWithFromBorderSideFix extends CorrectionProducerLogger
    with LintFix {
  /// {@macro replace_with_from_border_side_fix}
  ReplaceWithFromBorderSideFix({required super.context}) : super(_logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'ReplaceWithFromBorderSideFix',
  );

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintFixes get fix => .replaceWithFromBorderSide;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    logger.info('ReplaceWithFromBorderSideFix.compute() started');
    if (diagnostic == null) {
      logger.finer('Diagnostic is null, returning');
      return;
    }
    logger.fine('Diagnostic found');
    var node = this.node;
    logger.finer('Node type: ${node.runtimeType}');
    if (node is! ConstructorName) {
      logger.finer('Node is not ConstructorName, returning');
      return;
    }
    logger.fine('Node is ConstructorName');
    var instanceCreation = node.parent;
    logger.finer('Parent type: ${instanceCreation.runtimeType}');
    if (instanceCreation is! InstanceCreationExpression) {
      logger.finer('Parent is not InstanceCreationExpression, returning');
      return;
    }

    var canBeConst = instanceCreation.argumentList.arguments.every(
      (p) => p.canBeConstant,
    );
    logger.fine('Parent is InstanceCreationExpression');
    await builder.addDartFileEdit(file, (builder) {
      logger.finer('Replacing Border.all with Border.fromBorderSide');
      builder
        ..addSimpleReplacement(
          range.node(node),
          '${canBeConst ? 'const ' : ''}Border.fromBorderSide(BorderSide',
        )
        ..addSimpleInsertion(
          instanceCreation.argumentList.rightParenthesis.offset,
          ')',
        );
    });
    logger.info(
      'ReplaceWithFromBorderSideFix.compute() completed successfully',
    );
  }
}
