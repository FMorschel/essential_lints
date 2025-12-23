import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/type.dart';

import 'rule.dart';

/// {@template is_future}
/// Checks for usages of `is Future` type checks in `FutureOr` instances that
/// accept `Future` values.
/// {@endtemplate}
class IsFutureRule extends LintRule {
  /// {@macro is_future}
  IsFutureRule() : super(.isFuture);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _IsFutureVisitor(this, context);
    registry.addIsExpression(this, visitor);
  }
}

class _IsFutureVisitor extends SimpleAstVisitor<void> {
  _IsFutureVisitor(this.rule, this.context);

  final IsFutureRule rule;
  final RuleContext context;

  @override
  void visitIsExpression(covariant IsExpression node) {
    var expressionType = node.expression.staticType;
    if (expressionType == null) {
      return;
    }
    if (expressionType is InterfaceType && expressionType.isDartAsyncFutureOr) {
      if (!context.typeSystem.isAssignableTo(
        context.typeProvider.futureDynamicType,
        expressionType.typeArguments.first.finalBound,
      )) {
        // Not a `Future` so skip.
        return;
      }
      var type = node.type.type;
      if (type != null && type.isDartAsyncFuture) {
        rule.reportAtNode(node.type);
      }
    }
  }
}

extension on DartType {
  DartType get finalBound {
    var self = this;
    if (self is TypeParameterType) {
      return self.bound.finalBound;
    }
    return self;
  }
}
