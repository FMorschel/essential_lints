import 'package:analyzer/src/lint/registry.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:analyzer_testing/utilities/utilities.dart';
import 'package:essential_lints/src/wanrings/warning.dart';

abstract class WarningTestProcessor extends AnalysisRuleTest {
  @override
  String get analysisRule => rule.rule.code.name;

  WarningRule get rule;

  @override
  void setUp() {
    Registry.ruleRegistry.registerWarningRule(rule);
    newAnalysisOptionsYamlFile(testPackageRootPath, '''
${analysisOptionsContent()}
optional-checks:
  propagate-linter-exceptions: true
''');
    super.setUp();
  }
}

abstract class MultiWarningTestProcessor extends AnalysisRuleTest {
  @override
  String get analysisRule => rule.rule.code.name;

  MultiWarningRule get rule;

  @override
  void setUp() {
    Registry.ruleRegistry.registerWarningRule(rule);
    newAnalysisOptionsYamlFile(testPackageRootPath, '''
${analysisOptionsContent()}
optional-checks:
  propagate-linter-exceptions: true
''');
    super.setUp();
  }
}
