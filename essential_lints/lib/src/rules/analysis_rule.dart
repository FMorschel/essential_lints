import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:essential_lints_annotations/essential_lints_annotations.dart';
// ignore: implementation_imports internal
import 'package:essential_lints_annotations/src/_internal/static_enforcement.dart';
import 'package:logging/logging.dart';

import '../warnings/essential_lint_warnings.dart' hide SubtypeAnnotating;

/// {@template essentialAnalysisRule}
/// The base class for all essential analysis rules.
/// {@endtemplate}
@SubtypeAnnotating(
  annotations: [StaticEnforcement(#_logger, th<Logger>())],
  option: .onlyConcrete,
)
abstract class EssentialAnalysisRule extends AnalysisRule {
  /// {@macro essentialAnalysisRule}
  EssentialAnalysisRule(this.rule)
    : super(
        name: rule.lowerCaseUniqueName,
        description: rule.code.description,
      );

  /// The essential lint rule associated with this analysis rule.
  final EnumDiagnostic rule;

  @override
  EnumDiagnostic get diagnosticCode;
}

/// {@template essentialMultiAnalysisRule}
/// The base class for all essential multi-diagnostic analysis rules.
/// {@endtemplate}
abstract class EssentialMultiAnalysisRule extends MultiAnalysisRule {
  /// {@macro essentialMultiAnalysisRule}
  EssentialMultiAnalysisRule(this.rule)
    : super(
        name: rule.lowerCaseUniqueName,
        description: rule.code.description,
      );

  /// The essential lint rule associated with this analysis rule.
  final EnumDiagnostic rule;

  @override
  List<EnumDiagnostic> get diagnosticCodes;
}
