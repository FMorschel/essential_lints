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
import 'rules/getters_in_member_list.dart';
import 'rules/prefer_explicitly_named_parameters.dart';
import 'rules/prefer_first.dart';
import 'rules/prefer_last.dart';
import 'rules/rule.dart';

/// A typedef for the base fix constructor.
typedef FixGenerator =
    Fix Function({required CorrectionProducerContext context});

/// Mixin to integrate plugin fixes.
mixin AssistsPluginIntegration {
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

  /// Registers all assists with the given registry.
  void registerAssists(PluginRegistry registry) {
    assists.forEach(registry.registerAssist);
  }
}

/// Mixin to integrate plugin fixes.
mixin FixesPluginIntegration {
  /// Returns the list of registered fixes.
  Map<LintCode, List<FixGenerator>> get fixes {
    final fixes = <LintCode, List<FixGenerator>>{};

    void addFixTo(FixGenerator generator, List<EssentialLintRules> rules) {
      for (final rule in rules) {
        fixes.putIfAbsent(rule.code, () => []).add(generator);
      }
    }

    for (final fix in EssentialLintFixes.values) {
      var _ = switch (fix) {
        .alphabetizeArguments => addFixTo(AlphabetizeArgumentsFix.new, [
          .alphabetizeArguments,
        ]),
        .doubleLiteralFormat => addFixTo(DoubleLiteralFormatFix.new, [
          .doubleLiteralFormat,
        ]),
      };
    }
    return fixes;
  }

  /// Registers all fixes with the given registry.
  void registerFixes(PluginRegistry registry) {
    fixes.forEach((lintCode, generators) {
      for (final generator in generators) {
        registry.registerFixForRule(lintCode, generator);
      }
    });
  }
}

/// Mixin to integrate plugin rules.
mixin RulesPluginIntegration {
  /// Returns the list of registered rules.
  Set<Rule> get rules {
    final rules = <Rule>{};
    // Single instance to satisfy exhaustive switch requirement.
    var gettersInMemberListRule = GettersInMemberListRule();
    for (final rule in EssentialLintRules.values) {
      rules.add(switch (rule) {
        .alphabetizeArguments => AlphabetizeArgumentsRule(),
        .doubleLiteralFormat => DoubleLiteralFormatRule(),
        .preferExplicitlyNamedParameter => PreferExplicitlyNamedParameterRule(),
        .preferFirst => PreferFirstRule(),
        .preferLast => PreferLastRule(),
        .gettersInMemberList ||
        .missingInstanceGettersInMemberList ||
        .notClassGettersInMemberList ||
        .emptyMemberListNameGettersInMemberList ||
        .invalidMemberListGettersInMemberList ||
        .nonMemberInGettersInMemberList => gettersInMemberListRule,
      });
    }
    return rules;
  }

  /// Registers all lint rules with the given registry.
  void registerRules(PluginRegistry registry) {
    rules.forEach(registry.registerLintRule);
  }
}
