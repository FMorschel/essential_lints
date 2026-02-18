import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template is_future}
/// Checks for usages of `is Future` type checks in `FutureOr` instances that
/// accept `Future` values.
/// {@endtemplate}
@staticLoggerEnforcement
class IsFutureRule extends LintRule<IsFutureRule> {
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

class _IsFutureVisitor extends BaseVisitor<IsFutureRule> {
  _IsFutureVisitor(super.rule, super.context);

  @override
  void visitIsExpression(covariant IsExpression node) {
    logger.info('visitIsExpression() started');

    var expressionType = node.expression.staticType;
    if (expressionType == null) {
      logger.finer('Expression staticType is null — skipping');
      return;
    }

    logger.finer('Expression type: ${expressionType.getDisplayString()}');
    if (expressionType is InterfaceType && expressionType.isDartAsyncFutureOr) {
      logger.finer(
        'Expression is FutureOr with typeArgs: '
        '${expressionType.typeArguments // Formatting hack.
        .map((t) => t.getDisplayString()).join(', ')}',
      );

      var bound = expressionType.typeArguments.first.finalBound;
      var isAssignable = typeSystem.isAssignableTo(
        typeProvider.futureDynamicType,
        bound,
      );
      logger.finer(
        'Is Future assignable to bound ${bound.getDisplayString()}: '
        '$isAssignable',
      );
      if (!isAssignable) {
        logger.finer('Not a Future-compatible FutureOr — skipping');
        return;
      }

      var type = node.type.type;
      logger.finer(
        'Checked `is` target type: ${type?.getDisplayString() ?? 'null'}',
      );
      if (type != null && type.isDartAsyncFuture) {
        logger.fine(
          'Reporting `is Future` used on FutureOr that accepts Future',
        );
        rule.reportAtNode(node.type);
      } else {
        logger.finer('`is` target is not Future — no report');
      }
    } else {
      logger.finer('Expression type is not FutureOr — skipping');
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
