import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/error/error.dart';
import 'package:meta/meta.dart';

import 'essential_lint_rules.dart';

/// {@template rule}
/// The base class for all essential lint rules.
/// {@endtemplate}
abstract class Rule extends AnalysisRule {
  /// {@macro rule}
  Rule(this.rule)
    : super(
        name: rule.code.name,
        description: rule.code.problemMessage,
      );

  /// The essential lint rule associated with this analysis rule.
  final EssentialLintRules rule;

  @override
  DiagnosticCode get diagnosticCode => rule.code;

  @override
  @mustBeOverridden
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  );
}
