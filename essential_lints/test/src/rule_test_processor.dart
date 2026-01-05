import 'package:analyzer/src/lint/registry.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:analyzer_testing/utilities/utilities.dart';
import 'package:essential_lints/src/rules/essential_lint_rules.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:essential_lints_annotations/essential_lints_annotations.dart';
import 'package:meta/meta.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

@SubtypeNaming(suffix: 'Test')
@SubtypeAnnotating(annotations: [reflectiveTest], option: .onlyConcrete)
abstract class LintTestProcessor extends AnalysisRuleTest {
  @override
  String get analysisRule => rule.rule.code.name;

  @override
  @mustBeOverridden
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

@SubtypeNaming(suffix: 'Test')
@SubtypeAnnotating(annotations: [reflectiveTest], option: .onlyConcrete)
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
