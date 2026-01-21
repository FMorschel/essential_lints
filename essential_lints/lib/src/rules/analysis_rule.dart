import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:essential_lints_annotations/essential_lints_annotations.dart';
// ignore: implementation_imports internal
import 'package:essential_lints_annotations/src/_internal/static_enforcement.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../warnings/essential_lint_warnings.dart'
    hide SubtypeAnnotating, SubtypeNaming;

/// Static enforcement to ensure a static logger is present in all analysis
/// rules.
const staticLoggerEnforcement = StaticEnforcement(#_logger, th<Logger>());

/// {@template essentialAnalysisRule}
/// The base class for all essential analysis rules.
/// {@endtemplate}
@SubtypeAnnotating(
  annotations: [staticLoggerEnforcement],
  option: .onlyConcrete,
)
@SubtypeNaming(suffix: 'Rule')
abstract class EssentialAnalysisRule extends AnalysisRule {
  /// {@macro essentialAnalysisRule}
  EssentialAnalysisRule(this.rule, this.logger)
    : super(
        name: rule.lowerCaseUniqueName,
        description: rule.code.description,
      );

  /// The logger for this analysis rule.
  final Logger logger;

  /// The essential lint rule associated with this analysis rule.
  final EnumDiagnostic rule;

  @override
  EnumDiagnostic get diagnosticCode => rule;

  @override
  @mustBeOverridden
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  );
}

/// {@template essentialMultiAnalysisRule}
/// The base class for all essential multi-diagnostic analysis rules.
/// {@endtemplate}
@SubtypeAnnotating(
  annotations: [staticLoggerEnforcement],
  option: .onlyConcrete,
)
@SubtypeNaming(suffix: 'Rule')
abstract class EssentialMultiAnalysisRule<T extends EnumDiagnostic>
    extends MultiAnalysisRule {
  /// {@macro essentialMultiAnalysisRule}
  EssentialMultiAnalysisRule(this.rule, this.logger)
    : super(
        name: rule.lowerCaseUniqueName,
        description: rule.code.description,
      );

  /// The logger for this analysis rule.
  final Logger logger;

  /// The essential lint rule associated with this analysis rule.
  final EnumDiagnostic rule;

  /// The list of sub-diagnostics associated with this analysis rule.
  List<T> get subDiagnostics;

  @override
  List<EnumDiagnostic> get diagnosticCodes => [
    rule,
    ...subDiagnostics,
  ];

  @override
  @mustBeOverridden
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  );
}
