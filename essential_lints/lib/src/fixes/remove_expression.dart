import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../rules/analysis_rule.dart';
import '../rules/essential_lint_rules.dart';
import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template remove_expression_fix}
/// A fix that removes an expression from the code.
/// {@endtemplate}
@staticLoggerEnforcement
class RemoveExpressionFix extends CorrectionProducerLogger with WarningFix {
  /// {@macro remove_expression_fix}
  RemoveExpressionFix({required super.context}) : super(_logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'RemoveExpressionFix',
  );

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintWarningFixes get fix => .removeExpression;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    logger.info('RemoveExpressionFix.compute() started');
    var node = this.node;
    logger.finer('Initial node type: ${node.runtimeType}');
    if (diagnostic?.diagnosticCode == EssentialLintCode.emptyContainer) {
      logger.finer(
        'Diagnostic is emptyContainer, trying to find Expression ancestor',
      );
      node = node.thisOrAncestorOfType<Expression>() ?? node;
      logger.fine('Node after Expression search: ${node.runtimeType}');
    }
    if (node.parent case NamedExpression parent) {
      logger.finer('Node parent is NamedExpression, updating node');
      node = parent;
    }
    if (node.parent case NullAwareElement nullAware) {
      logger.finer('Node parent is NullAwareElement, updating node');
      node = nullAware;
    }
    if (node is! Expression && node is! NullAwareElement) {
      logger.finer(
        'Node is neither Expression nor NullAwareElement '
        '(${node.runtimeType}), returning',
      );
      return;
    }
    logger.fine('Node is Expression or NullAwareElement');
    if (node.parent
        case ReturnStatement() ||
            YieldStatement() ||
            VariableDeclaration() ||
            AssignmentExpression()) {
      logger.finer(
        'Node parent is a statement that prevents deletion, returning',
      );
      return;
    }
    logger.fine('Node parent is safe for deletion');
    if (node case Expression(
      parent: ArgumentList(),
      correspondingParameter: FormalParameterElement(isRequired: true),
    )) {
      logger.finer('Node is a required argument, returning');
      return;
    }
    logger.fine('Node is not a required argument');
    SourceRange deletionRange;
    if (node.parent case ExpressionStatement statement) {
      logger.fine('Parent is ExpressionStatement, deleting entire statement');
      deletionRange = range.node(statement);
    } else if (node.parent case ListLiteral(:var elements)) {
      logger.fine(
        'Parent is ListLiteral with ${elements.length} elements, deleting from '
        'list',
      );
      deletionRange = range.nodeInList(elements, node);
    } else {
      logger.fine('Parent is ${node.parent.runtimeType}, deleting node only');
      deletionRange = range.node(node);
    }
    logger.finer(
      'Deletion range: offset=${deletionRange.offset}, '
      'length=${deletionRange.length}',
    );
    await builder.addDartFileEdit(file, (builder) {
      logger.finer('Applying deletion');
      builder.addDeletion(deletionRange);
    });
    logger.info('RemoveExpressionFix.compute() completed successfully');
  }
}
