import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import '../utils/extensions/ast.dart';
import 'rule.dart';

/// {@template returning_widgets_rule}
/// A rule that prevents returning widgets from functions/methods.
/// {@endtemplate}
class ReturningWidgetsRule extends LintRule {
  /// {@macro returning_widgets_rule}
  ReturningWidgetsRule() : super(.returningWidgets);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _ReturningWidgetsVisitor(this, context);
    registry
      ..addFunctionDeclaration(this, visitor)
      ..addMethodDeclaration(this, visitor);
  }
}

class _ReturningWidgetsVisitor extends SimpleAstVisitor<void> {
  _ReturningWidgetsVisitor(this.rule, this.context);

  static const _buildName = 'build';

  ReturningWidgetsRule rule;
  RuleContext context;

  bool isWidgetType(TypeAnnotation? returnType) {
    if (returnType == null) return false;
    var type = returnType.type;
    if (type == null) return false;
    return type is InterfaceType && type.element.isWidget;
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    if (isWidgetType(node.returnType)) {
      rule.reportAtToken(node.name);
    }
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    if (isWidgetType(node.returnType) && node.notInStateOrStateless ||
        node.name.lexeme != _buildName) {
      rule.reportAtToken(node.name);
    }
  }
}

extension on MethodDeclaration {
  bool get notInStateOrStateless =>
      !enclosingTypeElement.isState && !enclosingTypeElement.isStatelessWidget;
}

extension on InterfaceElement {
  static const _widgetName = 'Widget';
  static const _statelessWidgetName = 'StatelessWidget';
  static const _stateName = 'State';
  static final Uri _uriFramework = .parse(
    'package:flutter/src/widgets/framework.dart',
  );

  bool get isState {
    var self = this;
    if (self is! ClassElement) {
      return false;
    }
    return self._isExactly(_stateName, _uriFramework) ||
        self.allSupertypes.any(
          (type) => type.element._isExactly(_stateName, _uriFramework),
        );
  }

  bool get isStatelessWidget {
    var self = this;
    if (self is! ClassElement) {
      return false;
    }
    return self._isExactly(_statelessWidgetName, _uriFramework) ||
        self.allSupertypes.any(
          (type) =>
              type.element._isExactly(_statelessWidgetName, _uriFramework),
        );
  }

  bool get isWidget {
    var self = this;
    if (self is! ClassElement) {
      return false;
    }
    if (_isExactly(_widgetName, _uriFramework)) {
      return true;
    }
    return self.allSupertypes.any(
      (type) => type.element._isExactly(_widgetName, _uriFramework),
    );
  }

  /// Whether this is the exact [type] defined in the file with the given [uri].
  bool _isExactly(String type, Uri uri) {
    var self = this;
    return self is ClassElement && self.name == type && self.library.uri == uri;
  }
}
