import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import '../utils/extensions/ast.dart';
import 'rule.dart';

/// {@template mutable_tearoff}
/// Checks for mutable tear-offs.
/// {@endtemplate}
class MutableTearoffRule extends LintRule {
  /// {@macro mutable_tearoff}
  MutableTearoffRule() : super(.mutableTearoff);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _MutableTearoffsVisitor(this, context);
    registry
      ..addPropertyAccess(this, visitor)
      ..addPrefixedIdentifier(this, visitor)
      ..addSimpleIdentifier(this, visitor)
      ..addFunctionReference(this, visitor);
  }
}

class _MutableTearoffsVisitor extends SimpleAstVisitor<void> {
  _MutableTearoffsVisitor(this.rule, this.context);

  final MutableTearoffRule rule;
  final RuleContext context;

  @override
  void visitFunctionReference(FunctionReference node) {
    if (node.parent case PrefixedIdentifier(
      :var prefix,
    ) when prefix.unParenthesized != node) {
      return;
    }
    if (node.parent case PropertyAccess(
      :var target,
    ) when target?.unParenthesized != node) {
      return;
    }
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    rule.reportAtNode(node.constructorName);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    rule.reportAtNode(node.methodName);
  }

  @override
  void visitParenthesizedExpression(ParenthesizedExpression node) {
    node.expression.accept(this);
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    if (node.identifier.element is! MethodElement) {
      return;
    }
    var target = node.prefix;
    if (target is ThisExpression || target is SuperExpression) {
      node.identifier.accept(this);
      return;
    }
    target.accept(this);
  }

  @override
  void visitPropertyAccess(PropertyAccess node) {
    if (node.propertyName.element is! MethodElement) {
      return;
    }
    var target = node.target;
    if (target is ThisExpression || target is SuperExpression) {
      node.propertyName.accept(this);
      return;
    }
    target?.accept(this);
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    if (node.thisOrAncestorOfType<CommentReference>() != null) {
      return;
    }
    if (node.parent is! PrefixedIdentifier && node.parent is! PropertyAccess) {
      var element = node.element;
      if (element is! PropertyAccessorElement ||
          !element.variable.type.isFunction) {
        return;
      }
    }
    if (node.parent case PrefixedIdentifier(
      :var prefix,
    ) when prefix.unParenthesized != node) {
      return;
    }
    if (node.parent case PropertyAccess(
      :var target,
    ) when target?.unParenthesized != node) {
      return;
    }
    if (node.parent is MethodInvocation) {
      return;
    }
    if (node.element is MethodElement && node.parent is ArgumentList) {
      return;
    }
    _reportIfMayBeMutable(node);
  }

  void _reportIfMayBeMutable(SimpleIdentifier node) {
    // See whether this is a local variable or field or getter or what.
    // If it is a final field and the enclosing type is private, then it's ok.
    // If it is a local variable or parameter, then it's ok.
    // If it is a const variable, then it's ok.
    // If it is a getter then report a lint.
    var element = node.element;
    if (element is PropertyAccessorElement && element.variable.isSynthetic) {
      rule.reportAtNode(node);
      return;
    }
    if (element is! PropertyAccessorElement && element is! MethodElement) {
      return;
    }
    if (element is PropertyAccessorElement &&
        !element.variable.isSynthetic &&
        (!element.variable.isFinal || !element.variable.isConst) &&
        !element.isStatic &&
        element.enclosingElement == node.enclosingTypeElement &&
        element.enclosingElement.isPublic &&
        element.isPublic) {
      rule.reportAtNode(node);
    } else if (element is MethodElement &&
        !element.isStatic &&
        element.enclosingElement == node.enclosingTypeElement &&
        element.enclosingElement!.isPublic &&
        element.isPublic) {
      rule.reportAtNode(node);
    }
  }
}

extension on DartType? {
  bool get isFunction {
    var self = this;
    if (self == null) return false;
    return self.isDartCoreFunction || self is FunctionType;
  }
}
