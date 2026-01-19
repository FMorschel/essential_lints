import 'package:analyzer/analysis_rule/analysis_rule.dart';

import '../warnings/essential_lint_warnings.dart';

/// {@template essentialAnalysisRule}
/// The base class for all essential analysis rules.
/// {@endtemplate}
abstract class EssentialAnalysisRule extends AnalysisRule {
  /// {@macro essentialAnalysisRule}
  EssentialAnalysisRule({required super.name, required super.description});

  @override
  EnumDiagnostic get diagnosticCode;
}

/// {@template essentialMultiAnalysisRule}
/// The base class for all essential multi-diagnostic analysis rules.
/// {@endtemplate}
abstract class EssentialMultiAnalysisRule extends MultiAnalysisRule {
  /// {@macro essentialMultiAnalysisRule}
  EssentialMultiAnalysisRule({required super.name, required super.description});

  @override
  List<EnumDiagnostic> get diagnosticCodes;
}
