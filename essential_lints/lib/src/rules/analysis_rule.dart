import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:essential_lints_annotations/essential_lints_annotations.dart';
// ignore: implementation_imports internal
import 'package:essential_lints_annotations/src/_internal/static_enforcement.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../utils/base_visitor.dart';
import '../warnings/essential_lint_warnings.dart'
    show EnumDiagnostic, SubDiagnostic, SuperDiagnostic, WarningCode;

/// Static enforcement to ensure a static logger is present in all analysis
/// rules.
const staticLoggerEnforcement = StaticEnforcement(#_logger, th<Logger>());

/// Shared base class for all essential analysis rules.
sealed class AbstractEssentialAnalysisRule<Diagnostic extends WarningCode> {
  /// The logger for this analysis rule.
  Logger get logger;

  @mustBeOverridden
  // ignore: public_member_api_docs, will be provided by the analyzer class.
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  );
}

/// {@template essentialAnalysisRule}
/// The base class for all essential analysis rules.
/// {@endtemplate}
@SubtypeAnnotating(
  annotations: [staticLoggerEnforcement],
  option: .onlyConcrete,
)
@SubtypeNaming(suffix: 'Rule')
abstract class EssentialAnalysisRule<
  R extends EssentialAnalysisRule<R, Visitor, Diagnostic>,
  Visitor extends BaseVisitor<R>,
  Diagnostic extends WarningCode
>
    extends AnalysisRule
    implements AbstractEssentialAnalysisRule<Diagnostic> {
  /// {@macro essentialAnalysisRule}
  EssentialAnalysisRule(this.rule, this.logger)
    : super(name: rule.lowerCaseUniqueName, description: rule.description);

  @override
  final Logger logger;

  /// The essential lint rule associated with this analysis rule.
  final Diagnostic rule;

  @override
  Diagnostic get diagnosticCode => rule;
}

/// {@template essentialMultiAnalysisRule}
/// The base class for all essential multi-diagnostic analysis rules.
/// {@endtemplate}
@SubtypeAnnotating(
  annotations: [staticLoggerEnforcement],
  option: .onlyConcrete,
)
@SubtypeNaming(suffix: 'Rule')
abstract class EssentialMultiAnalysisRule<
  R extends EssentialMultiAnalysisRule<R, Visitor, Diagnostic, Sub>,
  Visitor extends BaseVisitor<R>,
  Diagnostic extends SuperDiagnostic<Sub>,
  Sub extends SubDiagnostic
>
    extends MultiAnalysisRule
    implements AbstractEssentialAnalysisRule<Diagnostic> {
  /// {@macro essentialMultiAnalysisRule}
  EssentialMultiAnalysisRule(this.rule, this.logger)
    : super(name: rule.lowerCaseUniqueName, description: rule.code.description);

  @override
  final Logger logger;

  /// The essential lint rule associated with this analysis rule.
  final Diagnostic rule;

  /// The list of sub-diagnostics associated with this analysis rule.
  List<Sub> get subDiagnostics => rule.subDiagnostics;

  @override
  List<EnumDiagnostic> get diagnosticCodes => rule.all;
}
