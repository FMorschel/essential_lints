// This code is based on an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/always_remove_listener/always_remove_listener_rule.dart.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/analysis/uri_converter.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import '../utils/debug_log_mixin.dart';
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
class PendingListenerRule
    extends MultiLintRule<PendingListenerRule, PendingListener>
    with DebugLogMixin {
  /// {@macro pending_listener_rule}
  PendingListenerRule() : super(.pendingListener, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'PendingListenerRule',
  );

  String? _logFilePath;
  @override
  String? get logFilePath => _logFilePath;
  
  @override
  // ignore: library_private_types_in_public_api, not really public.
  _PendingListenerVisitor visitorFor(RuleContext context) =>
      _PendingListenerVisitor(this, context);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    if (logFilePath == null) {
      _logFilePath = r'D:\dev\logs\pending_listener.log';
      setLogListener(level: .ALL, logger: logger);
    }
    var visitor = visitorFor(context);
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
        for (var expression in visitor.instantiationListeners) {
          logger.fine(
            'Reporting listener instantiation: ${expression.toSource()}',
          );
          reportAtNode(
            // ignore: _internal_plugin/report_shorter_lengths more meaningful
            expression,
            diagnosticCode: PendingListener.listenerInstantiation,
          );
        }
      });
  }

  void _reportFor(
    Map<_ElementChain, List<Expression>> controllMap,
    Map<_ElementChain, List<Expression>> compareMap,
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
      var lastElement = entry.last;
      if (lastElement == null) {
        logger.warning(
          'No last element found in chain for entry: '
          '${entry.element?.displayName}, '
          'skipping reporting for this entry.',
        );
        continue;
      }
      var libraryFragment = lastElement.firstFragment.libraryFragment;
      if (libraryFragment == null) {
        logger.warning(
          'No library fragment found for element: ${lastElement.displayName}, '
          'skipping reporting for this element.',
        );
        continue;
      }
      if (!_setReporterForLibraryFragment(
        libraryFragment,
        context,
        uriConverter,
        lastElement,
      )) {
        continue;
      }
      var controlListeners = [
        for (var e in controllMap.entries)
          if (e.key.matches(entry)) ...e.value,
      ];
      var compareListeners = [
        for (var e in compareMap.entries)
          if (e.key.matches(entry)) ...e.value,
      ];
      logger.fine(
        'Processing element: ${entry.last?.displayName}, '
        'control count: ${controlListeners.length}, '
        'compare count: ${compareListeners.length}',
      );
      for (var control in controlListeners) {
        var hasMatch = false;
        for (var compare in compareListeners) {
          if (_expressionsMatch(control, compare)) {
            hasMatch = true;
            logger.finer('Expression matched: ${control.toSource()}');
            break;
          }
        }
        if (!hasMatch) {
          logger.fine(
            'Reporting unmatched expression: ${control.toSource()} '
            'for ${code.lowerCaseName}',
          );
          // ignore: _internal_plugin/report_shorter_lengths more meaningful
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
  _ElementChain _extractElementChain(
    Expression expression, [
    List<Expression>? instantiation,
    Expression? report,
  ]) {
    assert(
      (instantiation != null) == (report != null),
      'Both instatiation and report should be provided together.',
    );
    _logger.info(
      '_extractElementChain() started for: ${expression.toSource()}',
    );
    _ElementChain? chain;
    Expression? current = expression;

    while (current != null) {
      if (current is PropertyAccess) {
        if (current.propertyName.element?.baseElement case var element?) {
          if (chain == null) {
            chain = _ElementChain(element);
          } else {
            chain.add(element);
          }
          // If target is 'this', also add enclosing type (treat like implicit
          // this)
          if (current.target is ThisExpression) {
            if (!_isTopLevelOrLocal(element)) {
              if (element.enclosingElement case var enclosing?) {
                chain.add(enclosing);
              }
            }
          }
        }
        // If target is 'this', we've handled it above, so stop
        if (current.target is ThisExpression) {
          current = null;
        } else {
          current = current.target; // Continue with target
        }
      } else if (current is PrefixedIdentifier) {
        if (current.identifier.element?.baseElement case var element?) {
          if (chain == null) {
            chain = _ElementChain(element);
          } else {
            chain.add(element);
          }
        }
        if (current.prefix.element?.baseElement case var element?) {
          if (chain == null) {
            chain = _ElementChain(element);
          } else {
            chain.add(element);
          }
        }
        current = null; // End of chain
      } else if (current is Identifier) {
        if (current.element?.baseElement case var element?) {
          if (chain == null) {
            chain = _ElementChain(element);
          } else {
            chain.add(element);
          }
          // Check if we need to add enclosing type
          if (!_isTopLevelOrLocal(element)) {
            if (element.enclosingElement case var enclosing?) {
              chain.add(enclosing);
            }
          }
        }
        current = null; // End of chain
      } else if (current is PostfixExpression) {
        current = current.operand; // Continue with operand
      } else if (current
          case InstanceCreationExpression(
                parent: CascadeExpression(
                  parent: AssignmentExpression(
                        writeElement: var element?,
                        :var leftHandSideOrNull,
                      ) ||
                      VariableDeclaration(
                        declaredFragment: Fragment(:var element),
                        :var leftHandSideOrNull,
                      ),
                ),
              ) ||
              DotShorthandConstructorInvocation(
                parent: CascadeExpression(
                  parent: AssignmentExpression(
                        writeElement: var element?,
                        :var leftHandSideOrNull,
                      ) ||
                      VariableDeclaration(
                        declaredFragment: Fragment(:var element),
                        :var leftHandSideOrNull,
                      ),
                ),
              )) {
        if (chain == null) {
          chain = _ElementChain(element);
        } else {
          chain.add(element);
        }
        // Check if we need to add enclosing type
        if (!_isTopLevelOrLocal(element)) {
          if (element.enclosingElement case var enclosing?) {
            chain.add(enclosing);
          }
        }
        if (leftHandSideOrNull?.parent case Expression exp) {
          current = exp; // Continue with left-hand side
        }
      } else if (current
          case InstanceCreationExpression() ||
              DotShorthandConstructorInvocation()) {
        // Always warn.
        if (report != null) {
          instantiation?.add(report);
        }
        current = null;
        continue;
      } else {
        current = null; // Unknown type, end chain
      }
    }

    chain ??= _ElementChain.nullElement;

    // Log after extraction
    _logger.finer(
      'Extracted element chain (length: ${chain.length}) for: '
      '${expression.toSource()}',
    );
    return chain;
  }

  /// Checks if an element is a top-level or local element.
  static bool _isTopLevelOrLocal(Element? element) {
    var result =
        element is TopLevelVariableElement ||
        element is TopLevelFunctionElement ||
        element is LocalFunctionElement ||
        element is LocalVariableElement ||
        element is FormalParameterElement;
    _logger.finer(
      'Checked top-level/local for ${element?.displayName}: $result',
    );
    return result;
  }

  /// Checks if two expressions reference the same chain of elements.
  bool _expressionsMatch(Expression expr1, Expression expr2) {
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
          'Expressions do not match at index $i: ${chain1[i]?.displayName} != '
          '${chain2[i]?.displayName}',
        );
        return false;
      }
    }

    _logger.finer('Expressions match (length: ${chain1.length})');
    return true;
  }
}

class _ElementChain {
  _ElementChain(Element? element)
    : element = element is PropertyAccessorElement ? element.variable : element;

  static final nullElement = _ElementChain(null);

  final Element? element;
  _ElementChain? parent;

  int get length => element == null ? 0 : 1 + (parent?.length ?? 0);

  bool get isEmpty => length == 0;

  Element? get last => parent?.last ?? element;

  void add(Element? element) {
    if (element == null) return;
    if (parent case var parent? when parent.element != null) {
      PendingListenerRule._logger.warning(
        'Adding element to chain with existing parent: '
        '${parent.element?.displayName}, '
        'new element: ${element.displayName}',
      );
      parent.add(element);
    } else {
      parent = _ElementChain(element);
    }
  }

  Element? operator [](int index) {
    if (index < 0) return null;
    if (index == 0) return element;
    return parent?[index - 1];
  }

  bool matches(_ElementChain? other) {
    if (length != other?.length) return false;
    for (var i = length - 1; i >= 0; i--) {
      if (this[i] != other?[i]) return false;
    }
    return true;
  }

  @override
  String toString() => parent == null
      ? '${element?.displayName}'
      : '$parent.${element?.displayName}';
}

class _PendingListenerVisitor extends BaseVisitor<PendingListenerRule> {
  _PendingListenerVisitor(super.rule, super.context);

  static const _addListenerName = 'addListener';
  static const _removeListenerName = 'removeListener';
  static const _disposeName = 'dispose';
  static const _methodNames = <String>{_addListenerName, _removeListenerName};
  static const _listenableTypeName = 'Listenable';
  static const _changeNotifierTypeName = 'ChangeNotifier';
  static final Uri _flutterChangeNotifierUri = .parse(
    'package:flutter/src/foundation/change_notifier.dart',
  );

  final _instantiationListeners = <Expression>[];
  final _addedListeners = <_ElementChain, List<Expression>>{};
  final _removedListeners = <_ElementChain, List<Expression>>{};
  final _disposedElements = <_ElementChain>{};
  final _addedClosures = <_ElementChain, List<({int offset, int length})>>{};
  final _removedClosures = <({int offset, int length})>[];

  List<Expression> get instantiationListeners =>
      List.unmodifiable(_instantiationListeners);

  /// All added listeners, including those on disposed elements.
  Map<_ElementChain, List<Expression>> get addedListeners =>
      Map.unmodifiable(_addedListeners);

  /// Added listeners with disposed elements filtered out.
  /// Use this when checking for pending listeners.
  Map<_ElementChain, List<Expression>> get addedListenersFilteringDisposed {
    var filtered = {
      for (final key in _addedListeners.keys.whereNot(
        (key) => _disposedElements.any(key.matches),
      ))
        key: _addedListeners[key]!,
    };
    if (_disposedElements.isNotEmpty) {
      logger.fine(
        'Filtered out ${_disposedElements.length} disposed element(s) from '
        'added listeners: '
        '${_disposedElements.map((e) => e.element?.displayName).join(", ")}',
      );
    }
    return Map.unmodifiable(filtered);
  }

  Map<_ElementChain, List<Expression>> get removedListeners =>
      Map.unmodifiable(_removedListeners);

  void reportPendingClosures() {
    logger.info('reportPendingClosures() started');
    // Report closures added to non-disposed elements
    for (var entry in _addedClosures.entries) {
      if (!_disposedElements.any((chain) => chain.matches(entry.key))) {
        for (var closure in entry.value) {
          logger.fine(
            'Reporting closure on non-disposed element: '
            '${entry.key.element?.displayName}',
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
      logger.fine('Reporting closure in removeListener');
      rule.reportAtOffset(
        closure.offset,
        closure.length,
        diagnosticCode: PendingListener.closuresCannotBeMatched,
      );
    }
    logger.info('reportPendingClosures() completed');
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    logger.info('visitMethodInvocation() started for: ${node.toSource()}');
    var targetType =
        node.realTarget?.staticType.whenTypeOrNull<InterfaceType>() ??
        node.methodName.element?.enclosingElement
            .whenTypeOrNull<InterfaceElement>()
            ?.thisType;
    if (!_isDisposeFromChangeNotifier(node.methodName, targetType) &&
        !_isAddOrRemoveListenerFromListenable(node, targetType)) {
      logger.finer(
        'Method ${node.methodName.name} from $targetType is not relevant, '
        'skipping.',
      );
      return;
    }
    var targetElement = _targetElement(node);
    if (targetElement == null) {
      logger.finer(
        'Could not determine target element for method invocation: '
        '${node.toSource()}',
      );
      return;
    }
    logger.finer(
      'Processing method invocation on ${targetElement.element?.displayName}: '
      '${node.methodName.name}',
    );
    if (_isDisposeFromChangeNotifier(node.methodName, targetType)) {
      _disposedElements.add(targetElement);
      logger.fine(
        'Marked element as disposed: ${targetElement.element?.displayName}',
      );
      return;
    }
    if (!_methodNames.contains(node.methodName.name)) {
      logger.finer(
        'Method ${node.methodName.name} is not addListener or removeListener, '
        'skipping.',
      );
      return;
    }
    logger.fine(
      'Processing listener method ${node.methodName.name} on Listenable: '
      '${targetType?.getDisplayString()}',
    );
    var firstArgument = node.argumentList.arguments.firstOrNull;
    if (firstArgument == null) {
      // No arguments provided yet.
      logger.finer(
        'No arguments provided to ${node.methodName.name} on '
        '${targetElement.element?.displayName}',
      );
      return;
    }
    if (firstArgument case FunctionExpression(:var body, :var offset)) {
      // Track closures, report later based on disposal status
      var length = body.offset - offset;
      logger.fine(
        'Detected closure in ${node.methodName.name} on '
        '${targetElement.element?.displayName}',
      );
      if (node.methodName.name == _addListenerName) {
        _addedClosures.putIfNoMatch(targetElement, () => []).add((
          offset: offset,
          length: length,
        ));
      } else if (node.methodName.name == _removeListenerName) {
        _removedClosures.add((offset: offset, length: length));
      }
      return;
    }
    if (node.methodName.name == _addListenerName) {
      // Argument is being added.
      logger.finer(
        'Adding listener to ${targetElement.element?.displayName}: '
        '${firstArgument.toSource()}',
      );
      _addFor(targetElement, firstArgument);
    } else if (node.methodName.name == _removeListenerName) {
      // Argument is being removed.
      logger.finer(
        'Removing listener from ${targetElement.element?.displayName}: '
        '${firstArgument.toSource()}',
      );
      _removeFor(targetElement, firstArgument);
    }
  }

  bool _isAddOrRemoveListenerFromListenable(
    MethodInvocation node,
    InterfaceType? targetType,
  ) {
    return _methodNames.contains(node.methodName.name) &&
        (targetType != null &&
            (_isListenableType(targetType) ||
                targetType.allSupertypes.any(_isListenableType)));
  }

  void _addFor(_ElementChain element, Expression expression) {
    logger.finer(
      'Tracking added listener on ${element.element?.displayName}: '
      '${expression.toSource()}',
    );
    _addedListeners.putIfNoMatch(element, () => []).add(expression);
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

  void _removeFor(_ElementChain element, Expression expression) {
    logger.finer(
      'Tracking removed listener from ${element.element?.displayName}: '
      '${expression.toSource()}',
    );
    _removedListeners.putIfNoMatch(element, () => []).add(expression);
  }

  _ElementChain? _targetElement(MethodInvocation node) {
    var target = node.realTarget;

    // If there's no explicit target, use the enclosing type
    if (target == null) {
      var result = node.enclosingTypeElement;
      if (result != null) {
        logger.finer(
          'Resolved target element from enclosing type: '
          '${result.displayName}',
        );
      }
      return _ElementChain(result);
    }

    // Extract the full element chain from the target expression
    // This ensures widget.controller and oldWidget.controller are tracked
    // as different elements
    var firstArgument = node.argumentList.arguments.firstOrNull;
    var chain = rule._extractElementChain(
      target,
      firstArgument == null ? null : _instantiationListeners,
      firstArgument,
    );

    if (chain.isEmpty) {
      logger.warning(
        'Unable to extract element chain for target: ${target.toSource()}',
      );
      return null;
    }

    // Use the first element in the chain (the most specific one)
    // For widget.controller, this would be the controller property
    logger.finer(
      'Resolved target element from expression chain (length ${chain.length}): '
      '${chain.element?.displayName}',
    );

    return chain;
  }
}

extension<K extends _ElementChain, V> on Map<K, V> {
  /// Adds a value to the list for the given key, creating the list if it
  /// doesn't exist. If a matching key already exists (based on .matches), it
  /// adds to that key's list instead.
  V putIfNoMatch(K key, V Function() create) {
    var existingKey = keys.firstWhereOrNull(key.matches) ?? key;
    var list = this[existingKey] ?? create();
    return this[existingKey] = list;
  }
}

extension on AstNode {
  Expression? get leftHandSideOrNull {
    if (this case AssignmentExpression(:var leftHandSide)) {
      return leftHandSide;
    }
    return null;
  }
}
