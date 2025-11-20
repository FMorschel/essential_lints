// This code is based on an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/always_remove_listener/always_remove_listener_rule.dart.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart';
import 'package:collection/collection.dart';

import '../utils/extensions/ast.dart';
import '../utils/extensions/object.dart';
import 'essential_lint_rules.dart';
import 'rule.dart';

/// {@template pending_listener_rule}
/// A lint rule that detects pending listeners and reminds developers to
/// remove them.
/// {@endtemplate}
class PendingListenerRule extends MultiLintRule<PendingListener> {
  /// {@macro pending_listener_rule}
  PendingListenerRule() : super(.pendingListener);

  @override
  List<PendingListener> get subLints => PendingListener.values;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _PendingListenerVisitor(this, context);
    registry
      ..addMethodInvocation(this, visitor)
      ..afterLibrary(this, () {
        var addedListeners = visitor.addedListeners;
        var removedListeners = visitor.removedListeners;
        _reportFor(addedListeners, removedListeners, rule);
        _reportFor(
          removedListeners,
          addedListeners,
          PendingListener.unnecessaryRemove,
        );
      });
  }

  void _reportFor(
    Map<Element, List<Expression>> controllMap,
    Map<Element, List<Expression>> compareMap,
    DiagnosticCode code,
  ) {
    for (final entry in controllMap.keys) {
      var controlListeners = controllMap[entry]!;
      var compareListeners = [...?compareMap[entry]];
      var comparedIdentifiers = compareListeners.whereType<Identifier>().map(
        (i) => i.element,
      );
      for (final control in controlListeners.whereType<Identifier>()) {
        if (!comparedIdentifiers.contains(control.element)) {
          reportAtNode(control, diagnosticCode: code);
        }
      }
      var comparedPropertyAccesses = compareListeners
          .whereType<PropertyAccess>()
          .map(
            (i) => (
              target: i.target?.toSource(),
              property: i.propertyName.element,
            ),
          );
      for (final control in controlListeners.whereType<PropertyAccess>()) {
        if (!comparedPropertyAccesses.contains((
          target: control.target?.toSource(),
          property: control.propertyName.element,
        ))) {
          reportAtNode(control, diagnosticCode: code);
        }
      }
      var comparedPrefixedIdentifiers = compareListeners
          .whereType<PrefixedIdentifier>()
          .map(
            (i) => (
              prefix: i.prefix.element,
              identifier: i.identifier.element,
            ),
          );
      for (final control in controlListeners.whereType<PrefixedIdentifier>()) {
        if (!comparedPrefixedIdentifiers.contains((
          prefix: control.prefix.element,
          identifier: control.identifier.element,
        ))) {
          reportAtNode(control, diagnosticCode: code);
        }
      }
    }
  }
}

class _PendingListenerVisitor extends SimpleAstVisitor<void> {
  _PendingListenerVisitor(this.rule, this.context);

  static const _addListenerName = 'addListener';
  static const _removeListenerName = 'removeListener';
  static const _disposeName = 'dispose';
  static const _methodNames = <String>{_addListenerName, _removeListenerName};
  static const _listenableTypeName = 'Listenable';
  static const _changeNotifierTypeName = 'ChangeNotifier';
  static final Uri _flutterChangeNotifierUri = .parse(
    'package:flutter/src/foundation/change_notifier.dart',
  );

  final PendingListenerRule rule;
  final RuleContext context;

  final _addedListeners = <Element, List<Expression>>{};
  final _removedListeners = <Element, List<Expression>>{};
  final _disposedElements = <Element>{};

  Map<Element, List<Expression>> get addedListeners => {
    for (final key in _addedListeners.keys.whereNot(_disposedElements.contains))
      key: _addedListeners[key]!,
  };

  Map<Element, List<Expression>> get removedListeners =>
      .from(_removedListeners);

  @override
  void visitMethodInvocation(MethodInvocation node) {
    var targetType = node.realTarget?.staticType
        .whenTypeOrNull<InterfaceType>();
    var targetElement = _targetElement(node);
    if (targetElement == null) {
      return;
    }
    if (_isDisposeFromChangeNotifier(node.methodName, targetType)) {
      _disposedElements.add(targetElement);
    }
    if (_methodNames.contains(node.methodName.name) &&
        targetType != null &&
        (_isListenableType(targetType) ||
            targetType.allSupertypes.any(_isListenableType))) {
      var firstArgument = node.argumentList.arguments.firstOrNull;
      if (firstArgument == null) {
        // No arguments provided yet.
      } else if (firstArgument case FunctionExpression(
        :var body,
        :var offset,
      )) {
        // Closures can't ever be matched so always report.
        var length = body.offset - offset;
        rule.reportAtOffset(
          offset,
          length,
          diagnosticCode: PendingListener.closuresCannotBeMatched,
        );
      } else if (node.methodName.name == _addListenerName) {
        // Argument is being added.
        _addFor(targetElement, firstArgument);
      } else if (node.methodName.name == _removeListenerName) {
        // Argument is being removed.
        _removeFor(targetElement, firstArgument);
      }
    }
  }

  void _addFor(Element element, Expression expression) {
    _addedListeners.putIfAbsent(element, () => []).add(expression);
  }

  bool _isChangeNotifier(InterfaceType type) =>
      type.element.displayName == _changeNotifierTypeName &&
      type.element.library.uri == _flutterChangeNotifierUri;

  bool _isDisposeFromChangeNotifier(
    SimpleIdentifier methodName,
    InterfaceType? target,
  ) {
    if (methodName.name != _disposeName) {
      return false;
    }
    if (target is! InterfaceType) {
      return false;
    }
    return _isChangeNotifier(target) ||
        target.allSupertypes.any(_isChangeNotifier);
  }

  bool _isListenableType(InterfaceType type) =>
      type.element.displayName == _listenableTypeName &&
      type.element.library.uri == _flutterChangeNotifierUri;

  void _removeFor(Element element, Expression expression) {
    _removedListeners.putIfAbsent(element, () => []).add(expression);
  }

  Element? _targetElement(MethodInvocation node) {
    var target = node.target;
    if (target case Identifier(:var element)) {
      return element;
    } else if (target case PropertyAccess(:var propertyName)) {
      return propertyName.element;
    } else if (target case PrefixedIdentifier(:var identifier)) {
      return identifier.element;
    } else if (node.enclosingTypeElement case var enclosingType?) {
      return enclosingType;
    }
    assert(false, 'Unable to determine target element for $node');
    return null;
  }
}
