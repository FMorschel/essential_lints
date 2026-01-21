import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/extensions/element.dart';
import '../utils/extensions/logger.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template empty_container_rule}
/// A rule that detects empty container widgets in Flutter code.
/// {@endtemplate}
@staticLoggerEnforcement
class EmptyContainerRule extends LintRule {
  /// {@macro empty_container_rule}
  EmptyContainerRule() : super(.emptyContainer, _logger);

  static final Logger _logger = EssentialLintsPlugin.logger.newChild(
    'EmptyContainerRule',
  );

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _EmptyContainerVisitor(this, context);
    registry.addInstanceCreationExpression(this, visitor);
  }
}

class _EmptyContainerVisitor extends SimpleAstVisitor<void> {
  _EmptyContainerVisitor(this.rule, this.context);

  final EmptyContainerRule rule;
  final RuleContext context;

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    var name = node.constructorName;
    var element = name.type.element;
    if (element == null || !element.isContainer) {
      return;
    }
    if (node.argumentList.arguments.isEmpty) {
      rule.reportAtNode(name);
    }
  }
}
