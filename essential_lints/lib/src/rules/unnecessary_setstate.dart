// This code is based on the an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/avoid_unnecessary_setstate/avoid_unnecessary_setstate_rule.dart.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';

import '../utils/diagnostic_message.dart';
import '../utils/extensions/ast.dart';
import '../utils/extensions/element.dart';
import 'rule.dart';

/// {@template unnecessary_setstate_rule}
/// A rule that detects unnecessary calls to setState in Flutter widgets.
/// {@endtemplate}
class UnnecessarySetstateRule extends LintRule {
  /// {@macro unnecessary_setstate_rule}
  UnnecessarySetstateRule() : super(.unnecessarySetstate);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _UnnecessarySetstateVisitor(this, context);
    registry.addMethodInvocation(this, visitor);
  }
}

class _SyncCallVisitor extends RecursiveAstVisitor<void> {
  _SyncCallVisitor._(
    this._classDeclaration,
    this._executableElement,
    this._invoked,
    this._visitedElements,
  );

  static const _initStateName = 'initState';
  static const _didChangeDependenciesName = 'didChangeDependencies';
  static const _didUpdateWidgetName = 'didUpdateWidget';
  static const _buildName = 'build';
  static const _disposeName = 'dispose';

  static const _lifecycleMethods = <String>{
    _initStateName,
    _didChangeDependenciesName,
    _didUpdateWidgetName,
    _disposeName,
    _buildName,
  };

  final Set<ExecutableElement> _visitedElements;
  final ExecutableElement _executableElement;
  final ExecutableElement? _invoked;
  final ClassDeclaration _classDeclaration;

  final _callSites = <AstNode>[];

  @override
  void visitAssignmentExpression(AssignmentExpression node) {
    var containing = node.enclosingExecutableElementIfSync;
    if (containing != null) {
      _handleInvocation(
        node.writeElement,
        containing,
        null,
        node.leftHandSide,
      );
    }
    super.visitAssignmentExpression(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    var containing = node.enclosingExecutableElementIfSync;
    if (containing != null) {
      _handleInvocation(
        node.methodName.element,
        containing,
        node.target,
        node.methodName,
      );
    }

    super.visitMethodInvocation(node);
  }

  @override
  void visitPropertyAccess(PropertyAccess node) {
    var containing = node.enclosingExecutableElementIfSync;
    if (containing != null) {
      _handleInvocation(
        node.propertyName.element,
        containing,
        node.target,
        node.propertyName,
      );
    }
    super.visitPropertyAccess(node);
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    var containing = node.enclosingExecutableElementIfSync;
    if (containing != null) {
      _handleInvocation(
        node.element,
        containing,
        null,
        node,
      );
    }
    super.visitSimpleIdentifier(node);
  }

  void _handleInvocation(
    Element? invoked,
    ExecutableElement containing,
    AstNode? target,
    AstNode reportingNode,
  ) {
    var isLifecycleMethod =
        _lifecycleMethods.contains(containing.displayName) &&
        _executableElement.enclosingElement == containing.enclosingElement;
    if (invoked case ExecutableElement invoked
        when (target == null || target is ThisExpression) &&
            invoked == _executableElement) {
      if (isLifecycleMethod) {
        _callSites.add(reportingNode);
      } else {
        _callSites.addAll(
          findLifecycleCallSites(
            containing,
            invoked,
            _classDeclaration,
            visitedElements: {..._visitedElements, invoked},
          ),
        );
      }
      return;
    }
    if (isLifecycleMethod &&
        containing == _executableElement &&
        (_invoked == null || _invoked == invoked)) {
      _callSites.add(reportingNode);
    }
  }

  static List<AstNode> findLifecycleCallSites(
    ExecutableElement element,
    ExecutableElement? invoked,
    ClassDeclaration classDeclaration, {
    Set<ExecutableElement>? visitedElements,
  }) {
    if (visitedElements != null && visitedElements.contains(element)) {
      return [];
    }
    final visitor = _SyncCallVisitor._(
      classDeclaration,
      element,
      invoked,
      visitedElements ?? {},
    );
    classDeclaration.accept(visitor);
    return visitor._callSites;
  }
}

class _UnnecessarySetstateVisitor extends SimpleAstVisitor<void> {
  _UnnecessarySetstateVisitor(this.rule, this.context);

  static const _setStateName = 'setState';

  UnnecessarySetstateRule rule;
  RuleContext context;
  bool foundOneSetState = false;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (foundOneSetState) {
      return;
    }
    var methodName = node.methodName;
    var element = methodName.element;
    // Check if the method is `setState`.
    if (methodName.name != _setStateName ||
        // If not inside a State class, skip.
        !node.enclosingTypeElement.isState ||
        // If the setState is not from this State class, skip.
        node.target != null && node.target is! ThisExpression ||
        element is! MethodElement) {
      return;
    }
    var enclosingExecutable = node.enclosingExecutableElementIfSync;
    if (enclosingExecutable == null) {
      return;
    }
    var classDeclaration = node.thisOrAncestorOfType<ClassDeclaration>();
    if (classDeclaration == null) {
      assert(false, 'Class declaration should not be null here.');
      return;
    }
    foundOneSetState = true;
    var nodes = _SyncCallVisitor.findLifecycleCallSites(
      element,
      null,
      classDeclaration,
    );
    for (final node in nodes) {
      rule.reportAtNode(
        node,
        contextMessages: [
          if (node.enclosingExecutableElement != enclosingExecutable)
            DiagnosticMessageImpl(
              filePath: context.definingUnit.file.path,
              message: 'The call to `setState` happens here.',
              offset: methodName.offset,
              length: methodName.length,
              url: null,
            ),
        ],
      );
    }
  }
}
