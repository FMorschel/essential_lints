import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/error/error.dart';

import 'diagnostic.dart';

class InvalidModifiersRule extends AnalysisRule {
  InvalidModifiersRule()
    : super(
        name: 'invalid_modifiers',
        description: 'Modifiers that are invalid for a given modifier.',
      );

  @override
  DiagnosticCode get diagnosticCode => InternalDiagnosticCode(
    name: name,
    problemMessage: 'This modifier is invalid for the given modifier.',
    uniqueName: name,
    severity: .ERROR,
  );

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {}
}
