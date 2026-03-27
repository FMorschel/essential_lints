import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template explicit_casts}
/// Checks for explicit casts in the code.
/// {@endtemplate}
@staticLoggerEnforcement
class ExplicitCastsRule extends LintRule<ExplicitCastsRule> {
  /// {@macro explicit_casts}
  ExplicitCastsRule() : super(.explicitCasts, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'ExplicitCastsRule',
  );

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = visitorFor(context);
    registry
      ..addCastPattern(this, visitor)
      ..addAsExpression(this, visitor);
  }

  @override
  Visitor<ExplicitCastsRule, void> visitorFor(RuleContext context) =>
      _ExplicitCastsVisitor(this, context);
}

class _ExplicitCastsVisitor extends BaseVisitor<ExplicitCastsRule> {
  _ExplicitCastsVisitor(super.rule, super.context);

  @override
  void visitCastPattern(CastPattern node) {
    _reportIfNotTypeParameter(node.type.type?.element, node.asToken);
  }

  @override
  void visitAsExpression(AsExpression node) {
    _reportIfNotTypeParameter(node.type.type?.element, node.asOperator);
  }

  void _reportIfNotTypeParameter(Element? element, Token token) {
    if (element is TypeParameterElement) {
      return;
    }
    rule.reportAtToken(token);
  }
}
