import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:analyzer/error/error.dart';

import 'fixes/alphabetize_arguments.dart';
import 'fixes/essential_lint_fixes.dart';
import 'fixes/fix.dart';
import 'rules/alphabetize_arguments.dart';
import 'rules/essential_lint_rules.dart';
import 'rules/rule.dart';

/// A typedef for the base fix constructor.
typedef FixGenerator =
    Fix Function({required CorrectionProducerContext context});

/// Mixin to integrate plugin rules.
mixin RulesPluginIntegration {
  /// Registers all lint rules with the given registry.
  void registerRules(PluginRegistry registry) {
    rules.forEach(registry.registerLintRule);
  }

  /// Returns the list of registered rules.
  List<Rule> get rules {
    final rules = <Rule>[];
    for (final rule in EssentialLintRules.values) {
      rules.add(switch (rule) {
        EssentialLintRules.alphabetizeArguments => AlphabetizeArgumentsRule(),
      });
    }
    return rules;
  }
}

/// Mixin to integrate plugin fixes.
mixin FixesPluginIntegration {
  /// Registers all fixes with the given registry.
  void registerFixes(PluginRegistry registry) {
    fixes.forEach((lintCode, generators) {
      for (final generator in generators) {
        registry.registerFixForRule(lintCode, generator);
      }
    });
  }

  /// Returns the list of registered fixes.
  Map<LintCode, List<FixGenerator>> get fixes {
    final fixes = <LintCode, List<FixGenerator>>{};

    void addFixTo(FixGenerator generator, List<EssentialLintRules> rules) {
      for (final rule in rules) {
        fixes.putIfAbsent(rule.code, () => []).add(generator);
      }
    }

    for (final fix in EssentialLintFixes.values) {
      switch (fix) {
        case EssentialLintFixes.alphabetizeArguments:
          addFixTo(AlphabetizeArgumentsFix.new, [
            EssentialLintRules.alphabetizeArguments,
          ]);
      }
    }
    return fixes;
  }
}
