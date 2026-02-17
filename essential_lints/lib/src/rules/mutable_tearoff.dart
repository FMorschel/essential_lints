import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/extensions/ast.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template mutable_tearoff}
/// Checks for mutable tear-offs.
/// {@endtemplate}
@staticLoggerEnforcement
class MutableTearoffRule extends LintRule {
  /// {@macro mutable_tearoff}
  MutableTearoffRule() : super(.mutableTearoff, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'MutableTearoffRule',
  );

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
    rule.logger.info('visitFunctionReference() started');
    if (node.parent case PrefixedIdentifier(
      :var prefix,
    ) when prefix.unParenthesized != node) {
      rule.logger.finer(
        'FunctionReference is part of a PrefixedIdentifier but not direct — '
        'skipping',
      );
      return;
    }
    if (node.parent case PropertyAccess(
      :var target,
    ) when target?.unParenthesized != node) {
      rule.logger.finer(
        'FunctionReference is part of a PropertyAccess but not direct — '
        'skipping',
      );
      return;
    }
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    rule.logger.info(
      'visitInstanceCreationExpression() started for: '
      '${node.constructorName.toSource()}',
    );
    rule.logger.fine(
      'Reporting instance creation constructor as mutable tear-off',
    );
    rule.reportAtNode(node.constructorName);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    rule.logger.info(
      'visitMethodInvocation() started: ${node.methodName.name}',
    );
    rule.logger.fine('Reporting method invocation as mutable tear-off');
    rule.reportAtNode(node.methodName);
  }

  @override
  void visitParenthesizedExpression(ParenthesizedExpression node) {
    rule.logger.finer(
      'visitParenthesizedExpression() delegating to inner expression',
    );
    node.expression.accept(this);
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    rule.logger.info('visitPrefixedIdentifier() started: ${node.toSource()}');
    if (node.identifier.element is! MethodElement) {
      rule.logger.finer(
        'PrefixedIdentifier identifier is not a MethodElement — skipping',
      );
      return;
    }
    var target = node.prefix;
    if (target is ThisExpression || target is SuperExpression) {
      rule.logger.finer('Prefix is This or Super — delegating to identifier');
      node.identifier.accept(this);
      return;
    }
    rule.logger.finer('Delegating to prefix for further analysis');
    target.accept(this);
  }

  @override
  void visitPropertyAccess(PropertyAccess node) {
    rule.logger.info('visitPropertyAccess() started: ${node.toSource()}');
    if (node.propertyName.element is! MethodElement) {
      rule.logger.finer(
        'PropertyAccess propertyName is not a MethodElement — skipping',
      );
      return;
    }
    var target = node.target;
    if (target is ThisExpression || target is SuperExpression) {
      rule.logger.finer('Target is This or Super — delegating to propertyName');
      node.propertyName.accept(this);
      return;
    }
    rule.logger.finer('Delegating to target for further analysis');
    target?.accept(this);
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    rule.logger.info('visitSimpleIdentifier() started: ${node.name}');
    if (node.thisOrAncestorOfType<CommentReference>() != null) {
      rule.logger.finer('Identifier is within a CommentReference — skipping');
      return;
    }
    var parent = node.parent;
    if (parent case ParenthesizedExpression(:var lastParenthesizedParent)) {
      parent = lastParenthesizedParent.parent;
    }
    if (parent is! PrefixedIdentifier && parent is! PropertyAccess) {
      var element = node.element;
      if (element is! PropertyAccessorElement ||
          !element.variable.type.isFunction) {
        rule.logger.finer(
          'Not a property accessor returning a function — skipping',
        );
        return;
      }
    }
    if (parent case PrefixedIdentifier(
      :var prefix,
      expressionType: var lastMemberType,
    ) when prefix.unParenthesized != node || !lastMemberType.isFunction) {
      rule.logger.finer(
        'PrefixedIdentifier parent does not match expected shape or is not '
        'function typed — skipping',
      );
      return;
    }
    if (parent case PropertyAccess(
      :var target,
      expressionType: var lastMemberType,
    ) when target?.unParenthesized != node || !lastMemberType.isFunction) {
      rule.logger.finer(
        'PropertyAccess parent does not match expected shape or is not '
        'function typed — skipping',
      );
      return;
    }
    if (parent is MethodInvocation) {
      rule.logger.finer(
        'Identifier is used as a method invocation target — skipping',
      );
      return;
    }
    if (node.element is MethodElement && parent is ArgumentList) {
      rule.logger.finer(
        'Identifier is a method element used in arguments — skipping',
      );
      return;
    }
    rule.logger.finer('Identifier passes guards, checking mutability');
    _reportIfMayBeMutable(node);
  }

  void _reportIfMayBeMutable(SimpleIdentifier node) {
    rule.logger.finer(
      '_reportIfMayBeMutable() started for identifier: ${node.name}',
    );
    var element = node.element;
    if (element is PropertyAccessorElement &&
        !element.variable.isOriginDeclaration) {
      rule.logger.fine(
        'PropertyAccessorElement is not origin declaration — reporting',
      );
      rule.reportAtNode(node);
      return;
    }
    if (element is! PropertyAccessorElement && element is! MethodElement) {
      rule.logger.finer(
        'Element is neither PropertyAccessorElement nor MethodElement — '
        'skipping',
      );
      return;
    }
    if (element is PropertyAccessorElement &&
        element.variable.isOriginDeclaration &&
        (!element.variable.isFinal || !element.variable.isConst) &&
        !element.isStatic &&
        element.enclosingElement == node.enclosingTypeElement &&
        element.enclosingElement.isPublic &&
        !element.enclosingElement.isImmutable &&
        !element.enclosingElement.isFinal &&
        element.isPublic) {
      rule.logger.fine(
        'Mutable property accessor on public enclosing element — reporting',
      );
      rule.reportAtNode(node);
    } else if (element is MethodElement &&
        !element.isStatic &&
        element.enclosingElement == node.enclosingTypeElement &&
        element.enclosingElement!.isPublic &&
        element.isPublic) {
      rule.logger.fine(
        'Non-static public method on public enclosing element — reporting',
      );
      rule.reportAtNode(node);
    } else {
      rule.logger.finer('Conditions for reporting not met');
    }
  }
}

extension on Element {
  bool get isFinal {
    var self = this;
    if (self is ClassElement) {
      return self.isFinal;
    }
    return false;
  }

  bool get isImmutable {
    var self = this;
    return self.metadata.annotations.any(_isImmutable) ||
        self is InterfaceElement &&
            self.allSupertypes.any((type) => type.element.isImmutable);
  }

  bool _isImmutable(ElementAnnotation annotation) {
    var object = annotation.computeConstantValue();
    if (object?.type case var type?) {
      var isImmutable =
          type.element?.name == 'Immutable' &&
          type.element?.library?.uri == Uri.parse('package:meta/meta.dart');
      MutableTearoffRule._logger.finer(
        'Annotation computed as Immutable: $isImmutable',
      );
      return isImmutable;
    }
    MutableTearoffRule._logger.finer(
      'Annotation computeConstantValue() returned null type',
    );
    return false;
  }
}

extension on DartType? {
  bool get isFunction {
    var self = this;
    if (self == null) return false;
    return self.isDartCoreFunction || self is FunctionType;
  }
}

extension on Expression {
  DartType? get expressionType {
    var self = this;
    if (self is! PropertyAccess &&
        self is! PrefixedIdentifier &&
        self is! FunctionReference &&
        self is! ParenthesizedExpression) {
      return null; // We don't care.
    }
    if (parent case Expression(:var expressionType)) {
      return expressionType;
    }
    return staticType;
  }
}

extension on ParenthesizedExpression {
  ParenthesizedExpression get lastParenthesizedParent {
    var parent = this.parent;
    if (parent is ParenthesizedExpression) {
      return parent.lastParenthesizedParent;
    }
    return this;
  }
}
