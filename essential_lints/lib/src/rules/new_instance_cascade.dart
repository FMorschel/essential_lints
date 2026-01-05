import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';

import 'rule.dart';

/// {@template new_instance_cascade}
/// A lint rule that warns against using cascades on members that return new
/// instances.
/// {@endtemplate}
class NewInstanceCascadeRule extends LintRule {
  /// {@macro new_instance_cascade}
  NewInstanceCascadeRule() : super(.newInstanceCascade);

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
    var targetType = node.target.staticType;
    if (targetType == null) return;
    for (var section in node.cascadeSections) {
      if (section is MethodInvocation) {
        var element = section.methodName.element;
        if (element is ExecutableElement) {
          if (context.typeSystem.isSubtypeOf(element.returnType, targetType)) {
            rule.reportAtNode(section.methodName);
          }
        }
      } else if (section is PropertyAccess) {
        var element = section.propertyName.element;
        if (element is ExecutableElement) {
          if (context.typeSystem.isSubtypeOf(element.returnType, targetType)) {
            rule.reportAtNode(section.propertyName);
          }
        } else if (element is PropertyInducingElement) {
          if (context.typeSystem.isSubtypeOf(element.type, targetType)) {
            rule.reportAtNode(section.propertyName);
          }
        }
      }
    }
  }
}
