// This code is based on an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/always_remove_listener/always_remove_listener_rule.dart.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/analysis/uri_converter.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/extensions/ast.dart';
import '../utils/extensions/object.dart';
import 'analysis_rule.dart';
import 'essential_lint_rules.dart';
import 'rule.dart';

/// {@template pending_listener_rule}
/// A lint rule that detects pending listeners and reminds developers to
/// remove them.
/// {@endtemplate}
@staticLoggerEnforcement
class PendingListenerRule extends MultiLintRule<PendingListener> {
  /// {@macro pending_listener_rule}
  PendingListenerRule() : super(.pendingListener, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'PendingListenerRule',
  );

  @override
  List<PendingListener> get subDiagnostics => PendingListener.values;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _PendingListenerVisitor(this, context);
    registry
      ..addMethodInvocation(this, visitor)
      ..afterLibrary(this, () {
        var addedListeners = visitor.addedListeners;
        var addedListenersFilteringDisposed =
            visitor.addedListenersFilteringDisposed;
        var removedListeners = visitor.removedListeners;
        logger.info(
          'Analysis complete: ${addedListeners.length} element(s) with added '
          'listeners (${addedListenersFilteringDisposed.length} after '
          'filtering disposed), ${removedListeners.length} element(s) with '
          'removed listeners',
        );
        // Report closures based on disposal status
        visitor.reportPendingClosures();
        // Check for pending listeners (filter out disposed elements)
        _reportFor(
          addedListenersFilteringDisposed,
          removedListeners,
          context,
          rule,
        );
        // Check for unnecessary removes (use all added listeners)
        _reportFor(
          removedListeners,
          addedListeners,
          context,
          PendingListener.unnecessaryRemove,
        );
      });
  }

  void _reportFor(
    Map<Element, List<Expression>> controllMap,
    Map<Element, List<Expression>> compareMap,
    RuleContext context,
    DiagnosticCode code,
  ) {
    logger
      ..info('_reportFor() started for: ${code.lowerCaseName}')
      ..fine(
        'Reporting for code: ${code.lowerCaseName} with ${controllMap.length} '
        'element(s)',
      );
    var library = context.libraryElement;
    if (library == null) {
      logger.warning(
        'No library element found in context, cannot report '
        '${code.lowerCaseName}',
      );
      return;
    }
    var uriConverter = library.session.uriConverter;
    for (var entry in controllMap.keys) {
      var libraryFragment = entry.firstFragment.libraryFragment;
      if (libraryFragment == null) {
        logger.warning(
          'No library fragment found for element: ${entry.displayName}, '
          'skipping reporting for this element.',
        );
        continue;
      }
      if (!_setReporterForLibraryFragment(
        libraryFragment,
        context,
        uriConverter,
        entry,
      )) {
        continue;
      }
      var controlListeners = controllMap[entry]!;
      var compareListeners = [...?compareMap[entry]];
      logger.fine(
        'Processing element: ${entry.displayName}, '
        'control count: ${controlListeners.length}, '
        'compare count: ${compareListeners.length}',
      );
      for (var control in controlListeners) {
        var hasMatch = false;
        for (var compare in compareListeners) {
          if (_expressionsMatch(control, compare)) {
            hasMatch = true;
            logger.finer(
              'Expression matched: ${control.toSource()}',
            );
            break;
          }
        }
        if (!hasMatch) {
          logger.fine(
            'Reporting unmatched expression: ${control.toSource()} '
            'for ${code.lowerCaseName}',
          );
          reportAtNode(control, diagnosticCode: code);
        }
      }
    }
  }

  bool _setReporterForLibraryFragment(
    LibraryFragment libraryFragment,
    RuleContext context,
    UriConverter uriConverter,
    Element entry,
  ) {
    logger.info(
      '_setReporterForLibraryFragment() started for: ${entry.displayName}',
    );
    var uri = libraryFragment.source.uri;
    var unit = context.allUnits.firstWhereOrNull(
      (unit) =>
          uriConverter.uriToPath(unit.file.toUri()) ==
          uriConverter.uriToPath(uri),
    );
    if (unit == null) {
      logger.warning(
        'Could not find compilation unit for element: ${entry.displayName} '
        'with URI: $uri',
      );
      return false;
    }
    reporter = unit.diagnosticReporter;
    logger.finer(
      'Set reporter for element: ${entry.displayName} with URI: $uri',
    );
    return true;
  }

  /// Extracts a chain of elements from an expression.
  /// For `a.b.c`, returns a list with [c element, b element, a element].
  static List<Element> _extractElementChain(Expression expression) {
    _logger.info(
      '_extractElementChain() started for: ${expression.toSource()}',
    );
    var chain = <Element>[];
    Expression? current = expression;

    while (current != null) {
      if (current is Identifier) {
        if (current.element != null) {
          chain.add(current.element!);
          // Check if we need to add enclosing type
          var element = current.element!;
          if (!_isTopLevelOrLocal(element)) {
            if (element.enclosingElement case var enclosing?) {
              chain.add(enclosing);
            }
          }
        }
        current = null; // End of chain
      } else if (current is PropertyAccess) {
        if (current.propertyName.element != null) {
          chain.add(current.propertyName.element!);
        }
        current = current.target; // Continue with target
      } else if (current is PrefixedIdentifier) {
        if (current.identifier.element != null) {
          chain.add(current.identifier.element!);
        }
        if (current.prefix.element != null) {
          chain.add(current.prefix.element!);
        }
        current = null; // End of chain
      } else {
        current = null; // Unknown type, end chain
      }
    }

    // Log after extraction
    _logger.finer(
      'Extracted element chain (length: ${chain.length}) for: '
      '${expression.toSource()}',
    );
    return chain;
  }

  /// Checks if an element is a top-level or local element.
  static bool _isTopLevelOrLocal(Element element) {
    var result =
        element is TopLevelVariableElement ||
        element is TopLevelFunctionElement ||
        element is LocalFunctionElement ||
        element is LocalVariableElement ||
        element is FormalParameterElement;
    _logger.finer(
      'Checked top-level/local for ${element.displayName}: $result',
    );
    return result;
  }

  /// Checks if two expressions reference the same chain of elements.
  static bool _expressionsMatch(Expression expr1, Expression expr2) {
    _logger.finer(
      'Comparing expressions: ${expr1.toSource()} vs ${expr2.toSource()}',
    );
    var chain1 = _extractElementChain(expr1);
    var chain2 = _extractElementChain(expr2);

    if (chain1.length != chain2.length) {
      _logger.finer(
        'Expressions do not match: different lengths ${chain1.length} vs '
        '${chain2.length}',
      );
      return false;
    }

    for (var i = 0; i < chain1.length; i++) {
      if (chain1[i] != chain2[i]) {
        _logger.finer(
          'Expressions do not match at index $i: ${chain1[i].displayName} != '
          '${chain2[i].displayName}',
        );
        return false;
      }
    }

    _logger.finer('Expressions match (length: ${chain1.length})');
    return true;
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
  final _addedClosures = <Element, List<({int offset, int length})>>{};
  final _removedClosures = <({int offset, int length})>[];

  /// All added listeners, including those on disposed elements.
  Map<Element, List<Expression>> get addedListeners =>
      Map.unmodifiable(_addedListeners);

  /// Added listeners with disposed elements filtered out.
  /// Use this when checking for pending listeners.
  Map<Element, List<Expression>> get addedListenersFilteringDisposed {
    var filtered = {
      for (final key in _addedListeners.keys.whereNot(
        _disposedElements.contains,
      ))
        key: _addedListeners[key]!,
    };
    if (_disposedElements.isNotEmpty) {
      rule.logger.fine(
        'Filtered out ${_disposedElements.length} disposed element(s) from '
        'added listeners: '
        '${_disposedElements.map((e) => e.displayName).join(", ")}',
      );
    }
    return Map.unmodifiable(filtered);
  }

  Map<Element, List<Expression>> get removedListeners =>
      Map.unmodifiable(_removedListeners);

  void reportPendingClosures() {
    rule.logger.info('reportPendingClosures() started');
    // Report closures added to non-disposed elements
    for (var entry in _addedClosures.entries) {
      if (!_disposedElements.contains(entry.key)) {
        for (var closure in entry.value) {
          rule.logger.fine(
            'Reporting closure on non-disposed element: '
            '${entry.key.displayName}',
          );
          rule.reportAtOffset(
            closure.offset,
            closure.length,
            diagnosticCode: PendingListener.closuresCannotBeMatched,
          );
        }
      }
    }

    // Always report closures in removeListener
    for (var closure in _removedClosures) {
      rule.logger.fine('Reporting closure in removeListener');
      rule.reportAtOffset(
        closure.offset,
        closure.length,
        diagnosticCode: PendingListener.closuresCannotBeMatched,
      );
    }
    rule.logger.info('reportPendingClosures() completed');
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    rule.logger.info('visitMethodInvocation() started for: ${node.toSource()}');
    var targetType = node.realTarget?.staticType
        .whenTypeOrNull<InterfaceType>();
    var targetElement = _targetElement(node);
    if (targetElement == null) {
      rule.logger.finer(
        'Could not determine target element for method invocation: '
        '${node.toSource()}',
      );
      return;
    }
    rule.logger.finer(
      'Processing method invocation on ${targetElement.displayName}: '
      '${node.methodName.name}',
    );
    if (_isDisposeFromChangeNotifier(node.methodName, targetType)) {
      _disposedElements.add(targetElement);
      rule.logger.fine(
        'Marked element as disposed: ${targetElement.displayName}',
      );
    }
    if (_methodNames.contains(node.methodName.name) &&
        targetType != null &&
        (_isListenableType(targetType) ||
            targetType.allSupertypes.any(_isListenableType))) {
      rule.logger.fine(
        'Processing listener method ${node.methodName.name} on Listenable: '
        '${targetType.getDisplayString()}',
      );
      var firstArgument = node.argumentList.arguments.firstOrNull;
      if (firstArgument == null) {
        // No arguments provided yet.
        rule.logger.finer(
          'No arguments provided to ${node.methodName.name} on '
          '${targetElement.displayName}',
        );
      } else if (firstArgument case FunctionExpression(
        :var body,
        :var offset,
      )) {
        // Track closures, report later based on disposal status
        var length = body.offset - offset;
        rule.logger.fine(
          'Detected closure in ${node.methodName.name} on '
          '${targetElement.displayName}',
        );
        if (node.methodName.name == _addListenerName) {
          _addedClosures.putIfAbsent(targetElement, () => []).add((
            offset: offset,
            length: length,
          ));
        } else if (node.methodName.name == _removeListenerName) {
          _removedClosures.add((offset: offset, length: length));
        }
      } else if (node.methodName.name == _addListenerName) {
        // Argument is being added.
        rule.logger.finer(
          'Adding listener to ${targetElement.displayName}: '
          '${firstArgument.toSource()}',
        );
        _addFor(targetElement, firstArgument);
      } else if (node.methodName.name == _removeListenerName) {
        // Argument is being removed.
        rule.logger.finer(
          'Removing listener from ${targetElement.displayName}: '
          '${firstArgument.toSource()}',
        );
        _removeFor(targetElement, firstArgument);
      }
    } else if (_methodNames.contains(node.methodName.name)) {
      rule.logger.finer(
        'Method ${node.methodName.name} on '
        '${targetElement.displayName} is not a Listenable type or type is null',
      );
    }
  }

  void _addFor(Element element, Expression expression) {
    rule.logger.finer(
      'Tracking added listener on ${element.displayName}: '
      '${expression.toSource()}',
    );
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
    rule.logger.finer(
      'Tracking removed listener from ${element.displayName}: '
      '${expression.toSource()}',
    );
    _removedListeners.putIfAbsent(element, () => []).add(expression);
  }

  Element? _targetElement(MethodInvocation node) {
    var target = node.realTarget;
    Element? result;
    if (target case Identifier(:var element)) {
      result = element;
      rule.logger.finer(
        'Resolved target element from Identifier: ${element?.displayName}',
      );
    } else if (target case PropertyAccess(:var propertyName)) {
      result = propertyName.element;
      rule.logger.finer(
        'Resolved target element from PropertyAccess: '
        '${propertyName.element?.displayName}',
      );
    } else if (target case PrefixedIdentifier(:var identifier)) {
      result = identifier.element;
      rule.logger.finer(
        'Resolved target element from PrefixedIdentifier: '
        '${identifier.element?.displayName}',
      );
    } else if (node.enclosingTypeElement case var enclosingType?) {
      result = enclosingType;
      rule.logger.finer(
        'Resolved target element from enclosing type: '
        '${enclosingType.displayName}',
      );
    }
    if (result == null) {
      assert(false, 'Unable to determine target element for $node');
      rule.logger.warning(
        'Unable to determine target element for: ${node.toSource()}',
      );
    }
    return result;
  }
}
