import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template new_instance_cascade}
/// A lint rule that warns against using cascades on members that return new
/// instances.
/// {@endtemplate}
@staticLoggerEnforcement
class NewInstanceCascadeRule extends LintRule {
  /// {@macro new_instance_cascade}
  NewInstanceCascadeRule() : super(.newInstanceCascade, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'NewInstanceCascadeRule',
  );

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _NewInstanceCascadeVisitor(
      this,
      context,
    );
    registry.addCascadeExpression(this, visitor);
  }
}

class _NewInstanceCascadeVisitor extends SimpleAstVisitor<void> {
  _NewInstanceCascadeVisitor(this.rule, this.context);

  final NewInstanceCascadeRule rule;
  final RuleContext context;

  @override
  void visitCascadeExpression(CascadeExpression node) {
    rule.logger.info('visitCascadeExpression() started');
    var targetType = node.target.staticType;
    if (targetType == null) {
      rule.logger.finer('Target staticType is null — skipping cascade check');
      return;
    }
    rule.logger.finer(
      'Target type: ${targetType.getDisplayString()}, sections: '
      '${node.cascadeSections.length}',
    );

    for (var section in node.cascadeSections) {
      if (section is MethodInvocation) {
        var element = section.methodName.element;
        rule.logger.finer(
          'Processing MethodInvocation: ${section.methodName.name}, element: '
          '${element?.runtimeType}',
        );
        if (element is ExecutableElement) {
          var isSubtype = context.typeSystem.isSubtypeOf(
            element.returnType,
            targetType,
          );
          rule.logger.finer(
            'Method returnType: ${element.returnType.getDisplayString()} — '
            'isSubtypeOf target: $isSubtype',
          );
          if (isSubtype) {
            rule.logger.fine(
              'Reporting method invocation returning new instance: '
              '${section.methodName.name}',
            );
            rule.reportAtNode(section.methodName);
          }
        }
      } else if (section is PropertyAccess) {
        var element = section.propertyName.element;
        rule.logger.finer(
          'Processing PropertyAccess: ${section.propertyName.name}, element: '
          '${element?.runtimeType}',
        );
        if (element is ExecutableElement) {
          var isSubtype = context.typeSystem.isSubtypeOf(
            element.returnType,
            targetType,
          );
          rule.logger.finer(
            'Property getter returnType: '
            '${element.returnType.getDisplayString()} — isSubtypeOf target: '
            '$isSubtype',
          );
          if (isSubtype) {
            rule.logger.fine(
              'Reporting property getter returning new instance: '
              '${section.propertyName.name}',
            );
            rule.reportAtNode(section.propertyName);
          }
        } else if (element is PropertyInducingElement) {
          var isSubtype = context.typeSystem.isSubtypeOf(
            element.type,
            targetType,
          );
          rule.logger.finer(
            'Property type: ${element.type.getDisplayString()} — isSubtypeOf '
            'target: $isSubtype',
          );
          if (isSubtype) {
            rule.logger.fine(
              'Reporting property inducing element returning new instance: '
              '${section.propertyName.name}',
            );
            rule.reportAtNode(section.propertyName);
          }
        } else {
          rule.logger.finer(
            'PropertyAccess element is not ExecutableElement or '
            'PropertyInducingElement — skipping',
          );
        }
      } else {
        rule.logger.finer(
          'Cascade section is not MethodInvocation or PropertyAccess — '
          'skipping: ${section.runtimeType}',
        );
      }
    }
  }
}
