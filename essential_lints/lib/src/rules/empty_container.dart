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
    var typeSrc = name.type.toSource();
    rule.logger.info(
      'visitInstanceCreationExpression() started: constructor=$typeSrc',
    );

    var element = name.type.element;
    if (element == null || !element.isContainer) {
      rule.logger.finer(
        'Constructor is not a Container '
        '(element=${element?.runtimeType ?? 'null'}) — skipping',
      );
      return;
    }
    if (node.argumentList.arguments.isNotEmpty) {
      rule.logger.finer(
        'Container has constructor arguments — not empty, skipping',
      );
      return;
    }

    rule.logger.finer(
      'Checking whether instance creation is standalone or assigned to a '
      'supertype',
    );
    if (!_isStandalone(node) && !_isAssignedToSupertype(node)) {
      rule.logger.finer(
        'Not standalone and not assigned to a supertype — skipping',
      );
      return;
    }

    rule.logger.fine('Reporting empty Container instance creation: $typeSrc');
    rule.reportAtNode(name);
  }

  bool _isStandalone(InstanceCreationExpression node) {
    var isStandalone = node.parent is ExpressionStatement;
    rule.logger.finer('_isStandalone() -> $isStandalone');
    return isStandalone;
  }

  bool _isAssignedToSupertype(InstanceCreationExpression node) {
    rule.logger.finer('_isAssignedToSupertype() started');

    var expectedType =
        _getExpectedType(node) ?? context.typeProvider.dynamicType;
    var actualType = node.staticType;
    rule.logger.finer(
      'ExpectedType: ${expectedType.getDisplayString()}, ActualType: '
      '${actualType?.getDisplayString() ?? 'null'}',
    );

    if (actualType is! InterfaceType) {
      rule.logger.finer('Actual type is not InterfaceType -> false');
      return false;
    }

    if (!context.typeSystem.isAssignableTo(actualType, expectedType)) {
      rule.logger.finer(
        'Actual type is not assignable to expected type -> false',
      );
      return false;
    }

    if (expectedType is InterfaceType &&
        expectedType.element == actualType.element) {
      rule.logger.finer('Expected type is exactly the Container type -> false');
      return false;
    }

    var isSubtype = context.typeSystem.isSubtypeOf(actualType, expectedType);
    rule.logger.finer('Is actual type subtype of expected type: $isSubtype');
    return isSubtype;
  }

  DartType? _getExpectedType(InstanceCreationExpression node) {
    var parent = node.parent;
    rule.logger.finer('_getExpectedType() parent: ${parent.runtimeType}');

    // Handle NamedExpression wrapper
    if (parent is NamedExpression) {
      parent = parent.parent;
      rule.logger.finer(
        '_getExpectedType() unwrapped NamedExpression, new parent: '
        '${parent.runtimeType}',
      );
    }

    if (parent is ArgumentList) {
      var res = node.correspondingParameter?.type;
      rule.logger.finer(
        'Expected type from ArgumentList: ${res?.getDisplayString() ?? 'null'}',
      );
      return res;
    }

    if (parent is VariableDeclaration) {
      var grand = parent.parent;
      if (grand is VariableDeclarationList) {
        var res = grand.type?.type;
        rule.logger.finer(
          'Expected type from VariableDeclarationList: '
          '${res?.getDisplayString() ?? 'null'}',
        );
        return res;
      }
    }

    if (parent is AssignmentExpression) {
      var res = parent.staticType;
      rule.logger.finer(
        'Expected type from AssignmentExpression: '
        '${res?.getDisplayString() ?? 'null'}',
      );
      return res;
    }

    if (parent is ReturnStatement) {
      var res = node.enclosingExecutableElement?.returnType;
      rule.logger.finer(
        'Expected type from ReturnStatement: '
        '${res?.getDisplayString() ?? 'null'}',
      );
      return res;
    }

    if (parent is YieldStatement) {
      var res = node.enclosingExecutableElement?.returnType.yieldType;
      rule.logger.finer(
        'Expected type from YieldStatement: '
        '${res?.getDisplayString() ?? 'null'}',
      );
      return res;
    }

    rule.logger.finer('No expected type found for node');
    return null;
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
