import 'package:analyzer/src/lint/registry.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:analyzer_testing/utilities/utilities.dart';
import 'package:essential_lints/src/warnings/warning.dart';
import 'package:essential_lints_annotations/essential_lints_annotations.dart';
import 'package:meta/meta.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

@SubtypeNaming(suffix: 'Test')
@SubtypeAnnotating(annotations: [reflectiveTest], option: .onlyConcrete)
abstract class MultiWarningTestProcessor extends AnalysisRuleTest {
  @override
  String get analysisRule => rule.rule.code.name;

  @override
  @mustBeOverridden
  MultiWarningRule get rule;

  @override
  void setUp() {
    Registry.ruleRegistry.registerWarningRule(rule);
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
abstract class WarningTestProcessor extends AnalysisRuleTest {
  @override
  String get analysisRule => rule.rule.code.name;

  @override
  @mustBeOverridden
  WarningRule get rule;

  @override
  void setUp() {
    Registry.ruleRegistry.registerWarningRule(rule);
    super.setUp();
    newAnalysisOptionsYamlFile(testPackageRootPath, '''
${analysisOptionsContent()}
optional-checks:
  propagate-linter-exceptions: true
''');
    super.setUp();
  }
}
