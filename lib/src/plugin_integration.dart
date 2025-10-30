import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analysis_server_plugin/registry.dart';
// ignore: implementation_imports, open issue
import 'package:analysis_server_plugin/src/correction/fix_generators.dart'
    as fix_generators;
import 'package:analyzer/error/error.dart';

import 'assist/essential_lint_assists.dart';
import 'assist/remove_useless_else.dart';
import 'fixes/alphabetize_arguments.dart';
import 'fixes/double_literal_format.dart';
import 'fixes/essential_lint_fixes.dart';
import 'fixes/fix.dart';
import 'rules/alphabetize_arguments.dart';
import 'rules/double_literal_format.dart';
import 'rules/essential_lint_rules.dart';
import 'rules/prefer_explicitly_named_parameters.dart';
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
        .alphabetizeArguments => AlphabetizeArgumentsRule(),
        .preferExplicitlyNamedParameter => PreferExplicitlyNamedParameterRule(),
        .doubleLiteralFormat => DoubleLiteralFormatRule(),
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
        case .alphabetizeArguments:
          addFixTo(AlphabetizeArgumentsFix.new, [
            .alphabetizeArguments,
          ]);
        case .doubleLiteralFormat:
          addFixTo(DoubleLiteralFormatFix.new, [
            .doubleLiteralFormat,
          ]);
      }
    }
    return fixes;
  }
}

/// Mixin to integrate plugin fixes.
mixin AssistsPluginIntegration {
  /// Registers all assists with the given registry.
  void registerAssists(PluginRegistry registry) {
    assists.forEach(registry.registerAssist);
  }

  /// Returns the list of registered assists.
  Set<fix_generators.ProducerGenerator> get assists {
    final assists = <fix_generators.ProducerGenerator>{};

    for (final assist in EssentialLintAssists.values) {
      switch (assist) {
        case EssentialLintAssists.removeUselessElse:
          assists.add(RemoveUselessElse.new);
      }
    }
    return assists;
  }
}
