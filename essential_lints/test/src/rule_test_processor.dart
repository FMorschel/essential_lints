import 'package:analyzer/src/lint/registry.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:analyzer_testing/utilities/utilities.dart';
import 'package:essential_lints/src/rules/essential_lint_rules.dart';
import 'package:essential_lints/src/rules/rule.dart';

abstract class LintTestProcessor extends AnalysisRuleTest {
  @override
  String get analysisRule => rule.rule.code.name;

  @override
  LintRule get rule;

  @override
  void setUp() {
    Registry.ruleRegistry.registerLintRule(rule);
    super.setUp();
    newAnalysisOptionsYamlFile(testPackageRootPath, '''
${analysisOptionsContent()}
optional-checks:
  propagate-linter-exceptions: true
''');
    super.setUp();
  }
}

abstract class MultiLintTestProcessor<T extends SubLints>
    extends AnalysisRuleTest {
  @override
  String get analysisRule => rule.rule.code.name;

  @override
  MultiLintRule<T> get rule;

  @override
  void setUp() {
    Registry.ruleRegistry.registerLintRule(rule);
    super.setUp();
    newAnalysisOptionsYamlFile(testPackageRootPath, '''
${analysisOptionsContent()}
optional-checks:
  propagate-linter-exceptions: true
''');
    super.setUp();
  }
}
