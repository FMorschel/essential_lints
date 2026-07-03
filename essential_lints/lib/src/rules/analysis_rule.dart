import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:essential_lints_annotations/essential_lints_annotations.dart';
// ignore: implementation_imports internal
import 'package:essential_lints_annotations/src/_internal/static_enforcement.dart';
import 'package:logging/logging.dart';

import '../utils/base_visitor.dart';
import '../utils/extensions/ast_visitor.dart';
import '../warnings/essential_lint_warnings.dart'
    show EnumDiagnostic, SubDiagnostic, SuperDiagnostic, WarningCode;

/// Static enforcement to ensure a static logger is present in all analysis
/// rules.
const staticLoggerEnforcement = StaticEnforcement(#_logger, th<Logger>());

/// Shared base class for all essential analysis rules.
sealed class AbstractEssentialAnalysisRule<
  Self extends AbstractEssentialAnalysisRule<Self, Diagnostic>?,
  Diagnostic extends WarningCode
> {
  /// The essential lint rule associated with this analysis rule.
  Diagnostic get rule;

  /// The logger for this analysis rule.
  Logger get logger;

  /// The visitor for this analysis rule, which will be registered with the
  /// analyzer.
  Visitor<Self, void> visitorFor(RuleContext context);

  /// The method overriden by each subclass to register the visitor to whatever
  /// node they need.
  void registerVisitor(
    RuleVisitorRegistry registry,
    Visitor<Self, void> base,
    AstVisitor<void> timed,
  );

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
  Self extends EssentialAnalysisRule<Self, Diagnostic>,
  Diagnostic extends WarningCode
>
    extends AnalysisRule
    with RuleMixin<Self, Diagnostic>
    implements AbstractEssentialAnalysisRule<Self, Diagnostic> {
  /// {@macro essentialAnalysisRule}
  EssentialAnalysisRule(this.rule, this.logger)
    : super(name: rule.lowerCaseUniqueName, description: rule.description);

  @override
  final Diagnostic rule;

  @override
  final Logger logger;

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
  Self extends EssentialMultiAnalysisRule<Self, Diagnostic, Sub>,
  Diagnostic extends SuperDiagnostic<Sub>,
  Sub extends SubDiagnostic
>
    extends MultiAnalysisRule
    with MultiRuleMixin<Self, Diagnostic>
    implements AbstractEssentialAnalysisRule<Self, Diagnostic> {
  /// {@macro essentialMultiAnalysisRule}
  EssentialMultiAnalysisRule(this.rule, this.logger)
    : super(name: rule.lowerCaseUniqueName, description: rule.code.description);

  @override
  final Logger logger;

  /// The essential lint rule associated with this analysis rule.
  @override
  final Diagnostic rule;

  @override
  List<EnumDiagnostic> get diagnosticCodes => rule.all;
}

/// {@template rule_mixin}
/// Mixin that implements the default body for `registerNodeProcessors`.
/// {@endtemplate}
mixin RuleMixin<
  Self extends AbstractEssentialAnalysisRule<Self, Diagnostic>,
  Diagnostic extends WarningCode
>
    implements AbstractEssentialAnalysisRule<Self, Diagnostic>, AnalysisRule {
  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    logger.fine('Registering node processors');
    var base = visitorFor(context);
    var timed = base.timed;
    registerVisitor(registry, base, timed);
    registry.afterLibrary(this, () {
      logger.info('Completed library analysis in ${timed.stopwatch.elapsed}');
    });
    logger.fine('Registered node processors');
  }
}

/// {@macro rule_mixin}
mixin MultiRuleMixin<
  Self extends AbstractEssentialAnalysisRule<Self, Diagnostic>,
  Diagnostic extends WarningCode
>
    implements
        AbstractEssentialAnalysisRule<Self, Diagnostic>,
        MultiAnalysisRule {
  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    logger.fine('Registering node processors');
    var base = visitorFor(context);
    var timed = base.timed;
    registerVisitor(registry, base, timed);
    registry.afterLibrary(this, () {
      logger.info('Completed library analysis in ${timed.stopwatch.elapsed}');
    });
    logger.fine('Registered node processors');
  }
}
