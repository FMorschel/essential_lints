import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/extensions/ast.dart';
import '../utils/extensions/object.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template complete_error_no_stack}
/// Checks for `Completer.completeError` without stack traces.
/// {@endtemplate}
@staticLoggerEnforcement
class CompleterErrorNoStackRule extends LintRule {
  /// {@macro complete_error_no_stack}
  CompleterErrorNoStackRule() : super(.completerErrorNoStack, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'CompleterErrorNoStackRule',
  );

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _CompleterErrorNoStackVisitor(this, context);
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
    var method = node.methodName.name;
    rule.logger.info('visitMethodInvocation() started for: $method');

    var targetType =
        node.realTarget?.staticType.whenTypeOrNull<InterfaceType>() ??
        node.enclosingTypeElement?.thisType;
    rule.logger.finer(
      'Resolved targetType: '
      '${targetType?.element.displayName // Formatting hack.
          ?? targetType?.getDisplayString() ?? 'null'}',
    );

    if (method != _methodName) {
      rule.logger.finer('Method "$method" is not "$_methodName" — skipping');
      return;
    }

    rule.logger.finer('Checking whether invocation is from Completer');
    if (!_isCompleteErrorFromCompleter(node.methodName, targetType)) {
      rule.logger.finer('Invocation is not Completer.completeError — skipping');
      return;
    }

    var argCount = node.argumentList.arguments.length;
    rule.logger.fine(
      'Found completeError invocation with $argCount argument(s)',
    );
    if (argCount == 1) {
      rule.logger.fine('Reporting completeError call without stackTrace');
      rule.reportAtNode(node.methodName);
    } else {
      rule.logger.finer(
        'completeError called with stack trace or multiple args — no report',
      );
    }
  }

  bool _isCompleteErrorFromCompleter(
    SimpleIdentifier methodName,
    InterfaceType? target,
  ) {
    rule.logger.finer(
      '_isCompleteErrorFromCompleter() started for: ${methodName.name}',
    );
    if (methodName.name != _methodName) {
      rule.logger.finer(
        'Method name mismatch: ${methodName.name} != $_methodName',
      );
      return false;
    }
    if (target is! InterfaceType) {
      rule.logger.finer(
        'Target is not an InterfaceType: ${target.runtimeType}',
      );
      return false;
    }

    var direct = _isCompleter(target);
    if (direct) {
      rule.logger.finer(
        'Target type ${target.element.displayName} is a Completer',
      );
      return true;
    }

    var fromSupertypes = target.allSupertypes.any(_isCompleter);
    rule.logger.finer('Found completer in supertypes: $fromSupertypes');
    return fromSupertypes;
  }

  bool _isCompleter(InterfaceType type) => (() {
    var name = type.element.displayName;
    var uri = type.element.library.uri;
    var isMatch = name == _completerTypeName && uri == _completerLibraryUri;
    rule.logger.finer(
      'Checking type: $name, library: $uri -> isCompleter: $isMatch',
    );
    return isMatch;
  })();
}
