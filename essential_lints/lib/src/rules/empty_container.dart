import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/extensions/ast.dart';
import '../utils/extensions/element.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template empty_container_rule}
/// A rule that detects empty container widgets in Flutter code.
/// {@endtemplate}
@staticLoggerEnforcement
class EmptyContainerRule extends LintRule {
  /// {@macro empty_container_rule}
  EmptyContainerRule() : super(.emptyContainer, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
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
    if (node.argumentList.arguments.isNotEmpty) {
      return;
    }
    // Check if this is a standalone instance creation
    // Check if the expected type is a supertype of Container and not
    // Container itself
    if (!_isStandalone(node) && !_isAssignedToSupertype(node)) {
      return;
    }

    rule.reportAtNode(name);
  }

  bool _isStandalone(InstanceCreationExpression node) {
    return node.parent is ExpressionStatement;
  }

  bool _isAssignedToSupertype(InstanceCreationExpression node) {
    var expectedType =
        _getExpectedType(node) ?? context.typeProvider.dynamicType;

    var actualType = node.staticType;
    if (actualType is! InterfaceType) {
      return false;
    }

    if (!context.typeSystem.isAssignableTo(actualType, expectedType)) {
      return false;
    }

    // Check if expectedType is not exactly Container itself
    if (expectedType is InterfaceType &&
        expectedType.element == actualType.element) {
      return false;
    }

    // Check if expectedType is a supertype of Container (i.e., Container is
    // subtype of expected)
    return context.typeSystem.isSubtypeOf(actualType, expectedType);
  }

  DartType? _getExpectedType(InstanceCreationExpression node) {
    var parent = node.parent;

    // Handle NamedExpression wrapper
    if (parent is NamedExpression) {
      parent = parent.parent;
    }

    return switch (parent) {
      ArgumentList() => node.correspondingParameter?.type,
      VariableDeclaration(:VariableDeclarationList parent) => parent.type?.type,
      AssignmentExpression() => parent.staticType,
      ReturnStatement() => node.enclosingExecutableElement?.returnType,
      YieldStatement() => node.enclosingExecutableElement?.returnType.yieldType,
      _ => null,
    };
  }
}

extension on DartType {
  DartType? get yieldType {
    var self = this;
    if (self is InterfaceType && self.isDartAsyncStream) {
      return self.typeArguments.firstOrNull;
    }
    return null;
  }
}
