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

/// {@template border_radius_all_fix}
/// A fix that replaces BorderRadius.circular with BorderRadius.all.
/// {@endtemplate}
@staticLoggerEnforcement
class ReplaceWithBorderRadiusAllFix extends CorrectionProducerLogger
    with LintFix {
  /// {@macro border_radius_all_fix}
  ReplaceWithBorderRadiusAllFix({required super.context}) : super(_logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'ReplaceWithBorderRadiusAllFix',
  );

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintFixes get fix => .replaceWithBorderRadiusAll;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    logger.info('ReplaceWithBorderRadiusAllFix.compute() started');
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
    logger.fine('Parent is InstanceCreationExpression');
    if (instanceCreation.argumentList.arguments.length != 1) {
      logger.finer(
        'Instance creation has '
        '${instanceCreation.argumentList.arguments.length} arguments '
        '(expected 1), returning',
      );
      return;
    }
    logger.fine('Instance creation has exactly 1 argument');
    var canBeConst = instanceCreation.argumentList.arguments.every(
      (p) => p.canBeConstant,
    );
    logger.fine('Arguments checked for const: canBeConst=$canBeConst');
    await builder.addDartFileEdit(file, (builder) {
      logger.finer(
        'Applying replacements: replacing ConstructorName and '
        'adding closing paren',
      );
      builder
        ..addSimpleReplacement(
          range.node(node),
          '${canBeConst ? 'const ' : ''}BorderRadius.all(Radius.circular',
        )
        ..addSimpleInsertion(
          instanceCreation.argumentList.rightParenthesis.offset,
          ')',
        );
    });
    logger.info(
      'ReplaceWithBorderRadiusAllFix.compute() completed successfully',
    );
  }
}
