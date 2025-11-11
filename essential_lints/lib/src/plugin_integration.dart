import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analysis_server_plugin/registry.dart';
// ignore: implementation_imports, open issue
import 'package:analysis_server_plugin/src/correction/fix_generators.dart'
    as fix_generators;
import 'package:analyzer/error/error.dart';

import 'assist/essential_lint_assists.dart';
import 'assist/remove_useless_else.dart';
import 'fixes/add_missing_members.dart';
import 'fixes/alphabetize_arguments.dart';
import 'fixes/create_getter.dart';
import 'fixes/double_literal_format.dart';
import 'fixes/essential_lint_fixes.dart';
import 'fixes/fix.dart';
import 'fixes/remove_expression.dart';
import 'rules/alphabetize_arguments.dart';
import 'rules/double_literal_format.dart';
import 'rules/essential_lint_rules.dart';
import 'rules/padding_over_container.dart';
import 'rules/prefer_explicitly_named_parameters.dart';
import 'rules/prefer_first.dart';
import 'rules/prefer_last.dart';
import 'rules/returning_widgets.dart';
import 'rules/rule.dart';
import 'warnings/essential_lint_warnings.dart';
import 'warnings/getters_in_member_list.dart';
import 'warnings/warning.dart';

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
  /// Returns the list of registered lint fixes.
  Map<LintCode, List<FixGenerator>> get lintFixes {
    final fixes = <LintCode, List<FixGenerator>>{};

    void addFixTo(FixGenerator generator, List<EssentialLintRules> rules) {
      for (final rule in rules) {
        fixes.putIfAbsent(rule, () => []).add(generator);
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

  /// Returns the list of registered lint fixes.
  Map<DiagnosticCode, List<FixGenerator>> get warningFixes {
    final fixes = <DiagnosticCode, List<FixGenerator>>{};

    void addFixTo(FixGenerator generator, List<EnumDiagnostic> rules) {
      for (final rule in rules) {
        fixes.putIfAbsent(rule, () => []).add(generator);
      }
    }

    for (final fix in EssentialLintWarningFixes.values) {
      var _ = switch (fix) {
        .addMissingMembers => addFixTo(AddMissingMembersFix.new, [
          EssentialMultiWarnings.gettersInMemberList,
        ]),
        .removeExpression => addFixTo(RemoveExpressionFix.new, [
          GettersInMemberList.nonMemberIn,
        ]),
        .createGetter => addFixTo(CreateGetterFix.new, [
          GettersInMemberList.missingList,
        ]),
      };
    }
    return fixes;
  }

  /// Registers all fixes with the given registry.
  void registerFixes(PluginRegistry registry) {
    lintFixes.forEach((diagnosticCode, generators) {
      for (final generator in generators) {
        registry.registerFixForRule(diagnosticCode, generator);
      }
    });
    warningFixes.forEach((diagnosticCode, generators) {
      for (final generator in generators) {
        registry.registerFixForRule(diagnosticCode, generator);
      }
    });
  }
}

/// Mixin to integrate plugin rules.
mixin RulesPluginIntegration {
  /// Returns the list of registered rules.
  Set<LintRule> get rules {
    final rules = <LintRule>{};
    for (final rule in EssentialLintRules.values) {
      rules.add(switch (rule) {
        .alphabetizeArguments => AlphabetizeArgumentsRule(),
        .doubleLiteralFormat => DoubleLiteralFormatRule(),
        .preferExplicitlyNamedParameter => PreferExplicitlyNamedParameterRule(),
        .preferFirst => PreferFirstRule(),
        .preferLast => PreferLastRule(),
        .returningWidgets => ReturningWidgetsRule(),
        .paddingOverContainer => PaddingOverContainerRule(),
      });
    }
    return rules;
  }

  /// Registers all lint rules with the given registry.
  void registerRules(PluginRegistry registry) {
    rules.forEach(registry.registerLintRule);
  }
}

/// Mixin to integrate plugin rules.
mixin WarningsPluginIntegration {
  /// Returns the list of registered warnings.
  Set<MultiWarningRule> get warnings {
    final rules = <MultiWarningRule>{};
    // Single instance to satisfy exhaustive switch requirement.
    for (final rule in EssentialMultiWarnings.values) {
      rules.add(switch (rule) {
        .gettersInMemberList => GettersInMemberListRule(),
      });
    }
    return rules;
  }

  /// Registers all lint rules with the given registry.
  void registerWarnings(PluginRegistry registry) {
    warnings.forEach(registry.registerWarningRule);
  }
}
