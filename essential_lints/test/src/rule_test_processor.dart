import 'package:analyzer/src/lint/registry.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:analyzer_testing/utilities/utilities.dart';
import 'package:essential_lints/src/rules/rule.dart';

abstract class RuleTestProcessor extends AnalysisRuleTest {
  Rule get rule;

  @override
  String get analysisRule => rule.rule.code.name;

  @override
  void setUp() {
    Registry.ruleRegistry.registerLintRule(rule);
    newAnalysisOptionsYamlFile(testPackageRootPath, '''
${analysisOptionsContent()}
optional-checks:
  propagate-linter-exceptions: true
''');
    super.setUp();
  }
}
