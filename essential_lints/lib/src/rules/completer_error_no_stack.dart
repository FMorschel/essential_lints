import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/type.dart';

import '../utils/extensions/ast.dart';
import '../utils/extensions/object.dart';
import 'rule.dart';

/// {@template complete_error_no_stack}
/// Checks for `Completer.completeError` without stack traces.
/// {@endtemplate}
class CompleterErrorNoStackRule extends LintRule {
  /// {@macro complete_error_no_stack}
  CompleterErrorNoStackRule() : super(.completerErrorNoStack);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _CompleterErrorNoStackVisitor(this, context);
    registry.addMethodInvocation(this, visitor);
  }
}

class _CompleterErrorNoStackVisitor extends SimpleAstVisitor<void> {
  _CompleterErrorNoStackVisitor(this.rule, this.context);

  static const _methodName = 'completeError';
  static const _completerTypeName = 'Completer';
  static final Uri _completerLibraryUri = .parse('dart:async');

  final CompleterErrorNoStackRule rule;
  final RuleContext context;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    var targetType =
        node.realTarget?.staticType.whenTypeOrNull<InterfaceType>() ??
        node.enclosingTypeElement?.thisType;
    if (node.methodName.name != _methodName) {
      return;
    }
    if (!_isCompleteErrorFromCompleter(
      node.methodName,
      targetType,
    )) {
      return;
    }
    if (node.argumentList.arguments.length == 1) {
      rule.reportAtNode(node.methodName);
    }
  }

  bool _isCompleteErrorFromCompleter(
    SimpleIdentifier methodName,
    InterfaceType? target,
  ) {
    if (methodName.name != _methodName) {
      return false;
    }
    if (target is! InterfaceType) {
      return false;
    }
    return _isCompleter(target) || target.allSupertypes.any(_isCompleter);
  }

  bool _isCompleter(InterfaceType type) =>
      type.element.displayName == _completerTypeName &&
      type.element.library.uri == _completerLibraryUri;
}
