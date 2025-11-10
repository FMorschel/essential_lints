import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/pubspec.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:meta/meta.dart';

import 'essential_lint_warnings.dart';

/// {@template rule}
/// The base class for all essential lint rules.
/// {@endtemplate}
abstract class WarningRule<T extends SubWarnings> extends AnalysisRule {
  /// {@macro rule}
  WarningRule(this.rule)
    : super(
        name: rule.code.name,
        description: rule.code.description,
      );

  /// The essential lint rule associated with this analysis rule.
  final EssentialLintWarnings<T> rule;

  late DiagnosticReporter _reporter;

  @override
  DiagnosticCode get diagnosticCode => rule.code;

  @override
  set reporter(DiagnosticReporter value) {
    super.reporter = value;
    _reporter = value;
  }

  @override
  @mustBeOverridden
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  );

  @override
  void reportAtNode(
    AstNode? node, {
    List<Object> arguments = const [],
    List<DiagnosticMessage>? contextMessages,
    T? diagnosticCode,
  }) {
    if (diagnosticCode == null) {
      return super.reportAtNode(
        node,
        arguments: arguments,
        contextMessages: contextMessages,
      );
    }
    if (node == null) {
      return;
    }
    _reporter.atNode(
      node,
      diagnosticCode.code,
      arguments: arguments,
      contextMessages: contextMessages,
    );
  }

  @override
  void reportAtOffset(
    int offset,
    int length, {
    List<Object> arguments = const [],
    List<DiagnosticMessage>? contextMessages,
    T? diagnosticCode,
  }) {
    _reporter.atOffset(
      offset: offset,
      length: length,
      diagnosticCode: diagnosticCode?.code ?? rule.code,
      arguments: arguments,
      contextMessages: contextMessages,
    );
  }

  @override
  void reportAtPubNode(
    PubspecNode node, {
    List<Object> arguments = const [],
    List<DiagnosticMessage> contextMessages = const [],
    T? diagnosticCode,
  }) {
    if (diagnosticCode == null) {
      return super.reportAtPubNode(
        node,
        arguments: arguments,
        contextMessages: contextMessages,
      );
    }
    _reporter.atSourceSpan(
      node.span,
      diagnosticCode.code,
      arguments: arguments,
      contextMessages: contextMessages,
    );
  }

  @override
  void reportAtToken(
    Token token, {
    List<Object> arguments = const [],
    List<DiagnosticMessage>? contextMessages,
    T? diagnosticCode,
  }) {
    if (diagnosticCode == null) {
      return super.reportAtToken(
        token,
        arguments: arguments,
        contextMessages: contextMessages,
      );
    }
    _reporter.atToken(
      token,
      diagnosticCode.code,
      arguments: arguments,
      contextMessages: contextMessages,
    );
  }
}
