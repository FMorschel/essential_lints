// This code is based on an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/avoid_unnecessary_setstate/avoid_unnecessary_setstate_rule.dart.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import '../utils/diagnostic_message.dart';
import '../utils/extensions/ast.dart';
import '../utils/extensions/element.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template unnecessary_setstate_rule}
/// A rule that detects unnecessary calls to setState in Flutter widgets.
/// {@endtemplate}
@staticLoggerEnforcement
class UnnecessarySetstateRule extends LintRule<UnnecessarySetstateRule> {
  /// {@macro unnecessary_setstate_rule}
  UnnecessarySetstateRule() : super(.unnecessarySetstate, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'UnnecessarySetstateRule',
  );

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _UnnecessarySetstateVisitor(this, context);
    registry.addMethodInvocation(this, visitor);
  }
}

class _UnnecessarySetstateVisitor extends BaseVisitor<UnnecessarySetstateRule> {
  _UnnecessarySetstateVisitor(super.rule, super.context);

  static const _setStateName = 'setState';

  bool foundOneSetState = false;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    logger.info('visitMethodInvocation() started for: ${node.toSource()}');
    if (foundOneSetState) {
      logger.finer('Already reported once; skipping further checks');
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
      logger.finer(
        'Invocation is not a matching setState call or not in '
        'State class; skipping',
      );
      return;
    }
    var enclosingExecutable = node.enclosingExecutableElementIfSync;
    if (enclosingExecutable == null) {
      logger.finer('No enclosing executable element (sync), skipping');
      return;
    }
    var classDeclaration = node.thisOrAncestorOfType<ClassDeclaration>();
    if (classDeclaration == null) {
      assert(false, 'Class declaration should not be null here.');
      logger.warning(
        'Expected class declaration not found for setState invocation',
      );
      return;
    }
    logger.fine('Detected setState invocation; searching lifecycle call sites');
    foundOneSetState = true;
    var nodes = _SyncCallVisitor.findLifecycleCallSites(
      element,
      null,
      classDeclaration,
    );
    logger.fine('Found ${nodes.length} lifecycle call site(s) to report');
    for (var node in nodes) {
      logger.fine('Reporting call site: ${node.toSource()}');
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

class _SyncCallVisitor extends RecursiveAstVisitor<void> {
  _SyncCallVisitor._(
    this._classDeclaration,
    this._executableElement,
    this._invoked,
    this._visitedElements,
  ) {
    UnnecessarySetstateRule._logger.finer(
      '_SyncCallVisitor created for executable: '
      '${_executableElement.displayName}',
    );
  }

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

  final _callSites = <SimpleIdentifier>[];

  @override
  void visitAssignmentExpression(AssignmentExpression node) {
    var containing = node.enclosingExecutableElementIfSync;
    if (_Assignment(node.leftHandSide).name case var name?
        when containing != null) {
      _handleInvocation(node.writeElement, containing, null, name);
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
    if (containing != null && node.propertyName.element is! MethodElement) {
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
    if (containing != null && node.element is! MethodElement) {
      _handleInvocation(node.element, containing, null, node);
    }
    super.visitSimpleIdentifier(node);
  }

  void _handleInvocation(
    Element? invoked,
    ExecutableElement containing,
    AstNode? target,
    SimpleIdentifier reportingNode,
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

  static List<SimpleIdentifier> findLifecycleCallSites(
    ExecutableElement element,
    ExecutableElement? invoked,
    ClassDeclaration classDeclaration, {
    Set<ExecutableElement>? visitedElements,
  }) {
    UnnecessarySetstateRule._logger.finer(
      'findLifecycleCallSites() started for: ${element.displayName}',
    );
    if (visitedElements != null && visitedElements.contains(element)) {
      UnnecessarySetstateRule._logger.finer(
        'Already visited element: ${element.displayName}, returning empty',
      );
      return [];
    }
    var visitor = _SyncCallVisitor._(
      classDeclaration,
      element,
      invoked,
      visitedElements ?? {},
    );
    classDeclaration.accept(visitor);
    UnnecessarySetstateRule._logger.finer(
      'findLifecycleCallSites() found ${visitor._callSites.length} call '
      'site(s) for: ${element.displayName}',
    );
    return visitor._callSites;
  }
}

extension type _Assignment(Expression expression) {
  SimpleIdentifier? get name => switch (expression) {
    PropertyAccess(:var propertyName) => propertyName,
    PrefixedIdentifier(:var identifier) => identifier,
    SimpleIdentifier identifier => identifier,
    _ => null,
  };
}
