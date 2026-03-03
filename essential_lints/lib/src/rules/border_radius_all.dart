// This code is based on an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/prefer_const_border_radius/prefer_const_border_radius_rule.dart

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template border_radius_all_rule}
/// A lint rule that checks for the use of BorderRadius.circular and suggests
/// using BorderRadius.all instead.
/// {@endtemplate}
@staticLoggerEnforcement
class BorderRadiusAllRule extends LintRule<BorderRadiusAllRule> {
  /// {@macro border_radius_all_rule}
  BorderRadiusAllRule() : super(.borderRadiusAll, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'BorderRadiusAllRule',
  );

  @override
  Visitor<BorderRadiusAllRule, void> visitorFor(RuleContext context) =>
      _BorderRadiusAllVisitor(this, context);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    logger.fine('Registering node processors for BorderRadiusAllRule');
    var visitor = visitorFor(context);
    registry.addInstanceCreationExpression(this, visitor);
    logger.fine('Registered node processors for BorderRadiusAllRule');
  }
}

class _BorderRadiusAllVisitor extends BaseVisitor<BorderRadiusAllRule> {
  _BorderRadiusAllVisitor(super.rule, super.context);

  static const _borderRadiusName = 'BorderRadius';
  static const _circularName = 'circular';

  static final Uri _borderRadiusUri = .parse(
    'package:flutter/src/painting/border_radius.dart',
  );

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    logger.info(
      'BorderRadiusAllRule.visitInstanceCreationExpression() started at offset '
      '${node.offset}',
    );

    var element = node.constructorName.element;
    if (element == null) {
      logger.finer('Constructor element is null at offset ${node.offset}');
      return;
    }

    if (element.enclosingElement.name != _borderRadiusName) {
      logger.finer(
        'Enclosing element "${element.enclosingElement.name}" is not '
        '"$_borderRadiusName" — skipping',
      );
      return;
    }

    if (element.name != _circularName) {
      logger.finer(
        'Constructor name "${element.name}" is not "$_circularName" — skipping',
      );
      return;
    }

    if (element.library.uri != _borderRadiusUri) {
      logger.finer(
        'Library uri "${element.library.uri}" does not match $_borderRadiusUri '
        '— skipping',
      );
      return;
    }

    logger.fine(
      'Detected BorderRadius.circular instance — reporting at constructor name',
    );
    // ignore: _internal_plugin/report_shorter_lengths helps with the fix
    rule.reportAtNode(node.constructorName);
    logger.info(
      'BorderRadiusAllRule.visitInstanceCreationExpression() completed '
      '(violation reported)',
    );
  }
}
