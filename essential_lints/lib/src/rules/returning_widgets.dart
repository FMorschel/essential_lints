// This code is based on an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/avoid_returning_widgets/avoid_returning_widgets_rule.dart.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import '../utils/extensions/ast.dart';
import '../utils/extensions/element.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template returning_widgets_rule}
/// A rule that prevents returning widgets from functions/methods.
/// {@endtemplate}
@staticLoggerEnforcement
class ReturningWidgetsRule extends LintRule<ReturningWidgetsRule> {
  /// {@macro returning_widgets_rule}
  ReturningWidgetsRule() : super(.returningWidgets, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
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

class _ReturningWidgetsVisitor extends BaseVisitor<ReturningWidgetsRule> {
  _ReturningWidgetsVisitor(super.rule, super.context);

  bool isWidgetType(TypeAnnotation? returnType) {
    if (returnType == null) {
      logger.finer('isWidgetType() returning false: returnType is null');
      return false;
    }
    var type = returnType.type;
    if (type == null) {
      logger.finer(
        'isWidgetType() returning false: resolved type is null for '
        '${returnType.toSource()}',
      );
      return false;
    }
    var result = type is InterfaceType && type.element.isWidget;
    logger.fine('isWidgetType(${returnType.toSource()}) => $result');
    return result;
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    logger.info('visitFunctionDeclaration() started for: ${node.name.lexeme}');
    if (isWidgetType(node.returnType)) {
      logger.fine('Reporting function returning widget: ${node.name.lexeme}');
      rule.reportAtToken(node.name);
    }
    logger.info(
      'visitFunctionDeclaration() completed for: ${node.name.lexeme}',
    );
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    logger.info('visitMethodDeclaration() started for: ${node.name.lexeme}');
    var element = node.enclosingTypeElement;
    var shouldReport =
        isWidgetType(node.returnType) &&
        (element?.inheritedMembers.entries.none(
              (entry) =>
                  entry.key.name == node.declaredFragment?.element.lookupName,
            ) ??
            true);
    logger.finer('Method shouldReport=$shouldReport for ${node.name.lexeme}');
    if (shouldReport) {
      logger.fine('Reporting method returning widget: ${node.name.lexeme}');
      rule.reportAtToken(node.name);
    }
    logger.info('visitMethodDeclaration() completed for: ${node.name.lexeme}');
  }
}
