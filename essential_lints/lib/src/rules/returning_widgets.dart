// This code is based on an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/avoid_returning_widgets/avoid_returning_widgets_rule.dart.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/extensions/ast.dart';
import '../utils/extensions/element.dart';
import '../utils/extensions/logger.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template returning_widgets_rule}
/// A rule that prevents returning widgets from functions/methods.
/// {@endtemplate}
@staticLoggerEnforcement
class ReturningWidgetsRule extends LintRule {
  /// {@macro returning_widgets_rule}
  ReturningWidgetsRule() : super(.returningWidgets, _logger);

  static final Logger _logger = EssentialLintsPlugin.logger.newChild(
    'ReturningWidgetsRule',
  );

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
    var element = node.enclosingTypeElement;
    if (isWidgetType(node.returnType) &&
        (element?.inheritedMembers.entries.none(
              (entry) =>
                  entry.key.name == node.declaredFragment?.element.lookupName,
            ) ??
            true)) {
      rule.reportAtToken(node.name);
    }
  }
}
