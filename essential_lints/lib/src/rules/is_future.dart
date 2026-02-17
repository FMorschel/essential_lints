import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template is_future}
/// Checks for usages of `is Future` type checks in `FutureOr` instances that
/// accept `Future` values.
/// {@endtemplate}
@staticLoggerEnforcement
class IsFutureRule extends LintRule {
  /// {@macro is_future}
  IsFutureRule() : super(.isFuture, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'IsFutureRule',
  );

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
    rule.logger.info('visitIsExpression() started');

    var expressionType = node.expression.staticType;
    if (expressionType == null) {
      rule.logger.finer('Expression staticType is null — skipping');
      return;
    }

    rule.logger.finer('Expression type: ${expressionType.getDisplayString()}');
    if (expressionType is InterfaceType && expressionType.isDartAsyncFutureOr) {
      rule.logger.finer(
        'Expression is FutureOr with typeArgs: '
        '${expressionType.typeArguments // Formatting hack.
        .map((t) => t.getDisplayString()).join(', ')}',
      );

      var bound = expressionType.typeArguments.first.finalBound;
      var isAssignable = context.typeSystem.isAssignableTo(
        context.typeProvider.futureDynamicType,
        bound,
      );
      rule.logger.finer(
        'Is Future assignable to bound ${bound.getDisplayString()}: '
        '$isAssignable',
      );
      if (!isAssignable) {
        rule.logger.finer('Not a Future-compatible FutureOr — skipping');
        return;
      }

      var type = node.type.type;
      rule.logger.finer(
        'Checked `is` target type: ${type?.getDisplayString() ?? 'null'}',
      );
      if (type != null && type.isDartAsyncFuture) {
        rule.logger.fine(
          'Reporting `is Future` used on FutureOr that accepts Future',
        );
        rule.reportAtNode(node.type);
      } else {
        rule.logger.finer('`is` target is not Future — no report');
      }
    } else {
      rule.logger.finer('Expression type is not FutureOr — skipping');
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
