import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import '../utils/extensions/ast.dart';
import '../utils/extensions/element.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template empty_container_rule}
/// A rule that detects empty container widgets in Flutter code.
/// {@endtemplate}
@staticLoggerEnforcement
class EmptyContainerRule extends LintRule<EmptyContainerRule> {
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

class _EmptyContainerVisitor extends BaseVisitor<EmptyContainerRule> {
  _EmptyContainerVisitor(super.rule, super.context);

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    var name = node.constructorName;
    var typeSrc = name.type.toSource();
    logger.info(
      'visitInstanceCreationExpression() started: constructor=$typeSrc',
    );

    var element = name.type.element;
    if (element == null || !element.isContainer) {
      logger.finer(
        'Constructor is not a Container '
        '(element=${element?.runtimeType ?? 'null'}) — skipping',
      );
      return;
    }
    if (node.argumentList.arguments.isNotEmpty) {
      logger.finer(
        'Container has constructor arguments — not empty, skipping',
      );
      return;
    }

    logger.finer(
      'Checking whether instance creation is standalone or assigned to a '
      'supertype',
    );
    if (!_isStandalone(node) && !_isAssignedToSupertype(node)) {
      logger.finer(
        'Not standalone and not assigned to a supertype — skipping',
      );
      return;
    }

    logger.fine('Reporting empty Container instance creation: $typeSrc');
    rule.reportAtNode(name);
  }

  bool _isStandalone(InstanceCreationExpression node) {
    var isStandalone = node.parent is ExpressionStatement;
    logger.finer('_isStandalone() -> $isStandalone');
    return isStandalone;
  }

  bool _isAssignedToSupertype(InstanceCreationExpression node) {
    logger.finer('_isAssignedToSupertype() started');

    var expectedType = _getExpectedType(node) ?? typeProvider.dynamicType;
    var actualType = node.staticType;
    logger.finer(
      'ExpectedType: ${expectedType.getDisplayString()}, ActualType: '
      '${actualType?.getDisplayString() ?? 'null'}',
    );

    if (actualType is! InterfaceType) {
      logger.finer('Actual type is not InterfaceType -> false');
      return false;
    }

    if (!typeSystem.isAssignableTo(actualType, expectedType)) {
      logger.finer(
        'Actual type is not assignable to expected type -> false',
      );
      return false;
    }

    if (expectedType is InterfaceType &&
        expectedType.element == actualType.element) {
      logger.finer('Expected type is exactly the Container type -> false');
      return false;
    }

    var isSubtype = typeSystem.isSubtypeOf(actualType, expectedType);
    logger.finer('Is actual type subtype of expected type: $isSubtype');
    return isSubtype;
  }

  DartType? _getExpectedType(InstanceCreationExpression node) {
    var parent = node.parent;
    logger.finer('_getExpectedType() parent: ${parent.runtimeType}');

    // Handle NamedExpression wrapper
    if (parent is NamedExpression) {
      parent = parent.parent;
      logger.finer(
        '_getExpectedType() unwrapped NamedExpression, new parent: '
        '${parent.runtimeType}',
      );
    }

    if (parent is ArgumentList) {
      var res = node.correspondingParameter?.type;
      logger.finer(
        'Expected type from ArgumentList: ${res?.getDisplayString() ?? 'null'}',
      );
      return res;
    }

    if (parent is VariableDeclaration) {
      var grand = parent.parent;
      if (grand is VariableDeclarationList) {
        var res = grand.type?.type;
        logger.finer(
          'Expected type from VariableDeclarationList: '
          '${res?.getDisplayString() ?? 'null'}',
        );
        return res;
      }
    }

    if (parent is AssignmentExpression) {
      var res = parent.staticType;
      logger.finer(
        'Expected type from AssignmentExpression: '
        '${res?.getDisplayString() ?? 'null'}',
      );
      return res;
    }

    if (parent is ReturnStatement) {
      var res = node.enclosingExecutableElement?.returnType;
      logger.finer(
        'Expected type from ReturnStatement: '
        '${res?.getDisplayString() ?? 'null'}',
      );
      return res;
    }

    if (parent is YieldStatement) {
      var res = node.enclosingExecutableElement?.returnType.yieldType;
      logger.finer(
        'Expected type from YieldStatement: '
        '${res?.getDisplayString() ?? 'null'}',
      );
      return res;
    }

    logger.finer('No expected type found for node');
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
