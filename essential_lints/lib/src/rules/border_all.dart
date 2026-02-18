// This code is based on an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/avoid_border_all/avoid_border_all_rule.dart.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template border_all_rule}
/// A lint rule that checks for the use of `Border.all` in Flutter widgets.
/// {@endtemplate}
@staticLoggerEnforcement
class BorderAllRule extends LintRule<BorderAllRule> {
  /// {@macro border_all_rule}
  BorderAllRule() : super(.borderAll, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'BorderAllRule',
  );

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    logger.fine('Registering node processors for BorderAllRule');
    var visitor = _BorderAllVisitor(this, context);
    registry.addInstanceCreationExpression(this, visitor);
    logger.fine('Registered node processors for BorderAllRule');
  }
}

class _BorderAllVisitor extends BaseVisitor<BorderAllRule> {
  _BorderAllVisitor(super.rule, super.context);

  static const _borderName = 'Border';
  static const _allName = 'all';

  static final Uri _boxBorderUri = .parse(
    'package:flutter/src/painting/box_border.dart',
  );

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    logger.info(
      'BorderAllRule.visitInstanceCreationExpression() started at offset '
      '${node.offset}',
    );

    var element = node.constructorName.element;
    if (element == null) {
      logger.finer(
        'Constructor element is null for instance creation at offset '
        '${node.offset}',
      );
      return;
    }

    if (element.enclosingElement.name != _borderName) {
      logger.finer(
        'Enclosing element "${element.enclosingElement.name}" is not '
        '"$_borderName" — skipping',
      );
      return;
    }

    if (element.name != _allName) {
      logger.finer(
        'Constructor name "${element.name}" is not "$_allName" — skipping',
      );
      return;
    }

    if (element.library.uri != _boxBorderUri) {
      logger.finer(
        'Library uri "${element.library.uri}" does not match $_boxBorderUri — '
        'skipping',
      );
      return;
    }

    logger.fine(
      'Detected Border.all instance — reporting at constructor name',
    );
    rule.reportAtNode(node.constructorName);
    logger.info(
      'BorderAllRule.visitInstanceCreationExpression() completed (violation '
      'reported)',
    );
  }
}
