import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/error/error.dart';

mixin BuiltInRules {
  List<AnalysisRule> get builtInRules {
    return [
      _BuiltInRule('prefer_relative_imports'),
    ];
  }
}

class _BuiltInRule extends AnalysisRule {
  _BuiltInRule(String name) : super(description: '', name: name);

  @override
  late DiagnosticCode diagnosticCode = _DiagnosticCode(
    name,
    '',
    uniqueName: name,
  );
}

class _DiagnosticCode extends LintCode {
  _DiagnosticCode(
    super.name,
    super.problemMessage, {
    required super.uniqueName,
  });

  @override
  DiagnosticSeverity get severity => .NONE;

  @override
  DiagnosticType get type => .HINT;
}
