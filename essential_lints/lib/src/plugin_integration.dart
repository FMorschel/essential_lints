import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analysis_server_plugin/registry.dart';
// ignore: implementation_imports, open issue
import 'package:analysis_server_plugin/src/correction/fix_generators.dart'
    as fix_generators;
import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/error/error.dart';
import 'package:logging/logging.dart';

import 'assist/essential_lint_assists.dart';
import 'assist/remove_useless_else.dart';
import 'fixes/add_missing_members.dart';
import 'fixes/alphabetize_arguments.dart';
import 'fixes/create_getter.dart';
import 'fixes/essential_lint_fixes.dart';
import 'fixes/fix.dart';
import 'fixes/numeric_constant_style.dart';
import 'fixes/remove_expression.dart';
import 'fixes/replace_with_border_radius_all.dart';
import 'fixes/replace_with_from_border_side.dart';
import 'fixes/replace_with_squared_box.dart';
import 'fixes/sort_enum_constants.dart';
import 'fixes/use_padding_property.dart';
import 'plugin.dart';
import 'rules/alphabetize_arguments.dart';
import 'rules/alphabetize_enum_constants.dart';
import 'rules/border_all.dart';
import 'rules/border_radius_all.dart';
import 'rules/empty_container.dart';
import 'rules/essential_lint_rules.dart';
import 'rules/first_getter.dart';
import 'rules/last_getter.dart';
import 'rules/numeric_constant_style.dart';
import 'rules/padding_over_container.dart';
import 'rules/pending_listener.dart';
import 'rules/prefer_explicitly_named_parameters.dart';
import 'rules/returning_widgets.dart';
import 'rules/unnecessary_setstate.dart';
import 'utils/extensions/logger.dart';
import 'warnings/essential_lint_warnings.dart';
import 'warnings/getters_in_member_list.dart';
import 'warnings/subtype_annotating.dart';
import 'warnings/subtype_naming.dart';
import 'warnings/warning.dart';

/// A typedef for the base fix constructor.
typedef FixGenerator =
    Fix Function({required CorrectionProducerContext context});

/// Mixin to integrate plugin fixes.
mixin AssistsPluginIntegration {
  /// The logger for the assists integration.
  static final Logger logger = EssentialLintsPlugin.logger.newChild(
    'AssistsPluginIntegration',
  );

  /// Returns the list of registered assists.
  Set<fix_generators.ProducerGenerator> get assists {
    logger.info('Mapping assists');
    final assists = <fix_generators.ProducerGenerator>{};

    for (final assist in EssentialLintAssists.values) {
      switch (assist) {
        case EssentialLintAssists.removeUselessElse:
          assists.add(RemoveUselessElse.new);
      }
    }
    logger.info('Mapped assists');
    return assists;
  }

  /// Registers all assists with the given registry.
  void registerAssists(PluginRegistry registry) {
    logger.info('Registering assists');
    for (final generator in assists) {
      try {
        registry.registerAssist(generator);
        // ignore: avoid_catches_without_on_clauses, handles integration
      } catch (e, st) {
        logger.severe(
          'Failed to register assist generator '
          "'${generator.runtimeType}'",
          e,
          st,
        );
      }
    }
    logger.info('Registered assists');
  }
}

/// Mixin to integrate plugin fixes.
mixin FixesPluginIntegration {
  /// The logger for the fixes integration.
  static final Logger logger = EssentialLintsPlugin.logger.newChild(
    'FixesPluginIntegration',
  );

  /// Returns the list of registered lint fixes.
  Map<LintCode, List<FixGenerator>> get lintFixes {
    logger.info('Mapping lint fixes');
    final fixes = <LintCode, List<FixGenerator>>{};

    void addFixTo(FixGenerator generator, List<EssentialLintRules> rules) {
      for (final rule in rules) {
        fixes.putIfAbsent(rule, () => []).add(generator);
      }
    }

    addFixTo(RemoveExpressionFix.new, [.emptyContainer]);

    for (final fix in EssentialLintFixes.values) {
      var _ = switch (fix) {
        .alphabetizeArguments => addFixTo(AlphabetizeArgumentsFix.new, [
          .alphabetizeArguments,
        ]),
        .numericConstantStyle => addFixTo(NumericConstantStyleFix.new, [
          .numericConstantStyle,
        ]),
        .usePaddingProperty => addFixTo(UsePaddingPropertyFix.new, [
          .paddingOverContainer,
        ]),
        .replaceWithSizedBox => addFixTo(ReplaceWithSizedBoxFix.new, [
          .emptyContainer,
        ]),
        .sortEnumConstants => addFixTo(SortEnumConstantsFix.new, [
          .alphabetizeEnumConstants,
        ]),
        .replaceWithFromBorderSide => addFixTo(
          ReplaceWithFromBorderSideFix.new,
          [.borderAll],
        ),
        .replaceWithBorderRadiusAll => addFixTo(
          ReplaceWithBorderRadiusAllFix.new,
          [.borderRadiusAll],
        ),
      };
    }
    logger.info('Mapped lint fixes');
    return fixes;
  }

  /// Returns the list of registered lint fixes.
  Map<DiagnosticCode, List<FixGenerator>> get warningFixes {
    logger.info('Mapping warning fixes');
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
    logger.info('Mapped warning fixes');
    return fixes;
  }

  /// Registers all fixes with the given registry.
  void registerFixes(PluginRegistry registry) {
    logger.info('Registering lint fixes');
    lintFixes.forEach((diagnosticCode, generators) {
      for (final generator in generators) {
        try {
          registry.registerFixForRule(diagnosticCode, generator);
          // ignore: avoid_catches_without_on_clauses, handles integration
        } catch (e, st) {
          logger.severe(
            'Failed to register fix for rule '
            "'${diagnosticCode.name}'",
            e,
            st,
          );
        }
      }
    });
    logger
      ..info('Registered lint fixes')
      ..info('Registering warning fixes');
    warningFixes.forEach((diagnosticCode, generators) {
      for (final generator in generators) {
        try {
          registry.registerFixForRule(diagnosticCode, generator);
          // ignore: avoid_catches_without_on_clauses, handles integration
        } catch (e, st) {
          logger.severe(
            'Failed to register fix for rule '
            "'${diagnosticCode.name}'",
            e,
            st,
          );
        }
      }
    });
    logger.info('Registered warning fixes');
  }
}

/// Mixin to integrate plugin rules.
mixin RulesPluginIntegration {
  /// The logger for the rules integration.
  static final Logger logger = EssentialLintsPlugin.logger.newChild(
    'RulesPluginIntegration',
  );

  /// Returns the list of registered rules.
  Set<AbstractAnalysisRule> get rules {
    logger.info('Mapping lint rules');
    final rules = <AbstractAnalysisRule>{};
    for (final rule in EssentialLintRules.values) {
      rules.add(switch (rule) {
        .alphabetizeEnumConstants => AlphabetizeEnumConstantsRule(),
        .alphabetizeArguments => AlphabetizeArgumentsRule(),
        .numericConstantStyle => NumericConstantStyleRule(),
        .preferExplicitlyNamedParameter => PreferExplicitlyNamedParameterRule(),
        .firstGetter => FirstGetterRule(),
        .lastGetter => LastGetterRule(),
        .returningWidgets => ReturningWidgetsRule(),
        .paddingOverContainer => PaddingOverContainerRule(),
        .unnecessarySetstate => UnnecessarySetstateRule(),
        .emptyContainer => EmptyContainerRule(),
        .borderAll => BorderAllRule(),
        .borderRadiusAll => BorderRadiusAllRule(),
      });
    }
    logger
      ..info('Mapped lint rules')
      ..info('Mapping multi lint rules');
    for (final rule in EssentialMultiLints.values) {
      rules.add(switch (rule) {
        .pendingListener => PendingListenerRule(),
      });
    }
    logger.info('Mapped multi lint rules');
    return rules;
  }

  /// Registers all lint rules with the given registry.
  void registerRules(PluginRegistry registry) {
    logger.info('Registering lint rules');
    for (final rule in rules) {
      try {
        registry.registerLintRule(rule);
        // ignore: avoid_catches_without_on_clauses, handles integration
      } catch (e, st) {
        logger.severe(
          'Failed to register rule '
          "'${rule.name}'",
          e,
          st,
        );
      }
    }
    logger.info('Registered lint rules');
  }
}

/// Mixin to integrate plugin rules.
mixin WarningsPluginIntegration {
  /// The logger for the warnings integration.
  static final Logger logger = EssentialLintsPlugin.logger.newChild(
    'WarningsPluginIntegration',
  );

  /// Returns the list of registered warnings.
  Set<MultiWarningRule> get warnings {
    logger.info('Mapping warning rules');
    final rules = <MultiWarningRule>{};
    // Single instance to satisfy exhaustive switch requirement.
    for (final rule in EssentialMultiWarnings.values) {
      rules.add(switch (rule) {
        .gettersInMemberList => GettersInMemberListRule(),
        .subtypeNaming => SubtypeNamingRule(),
        .subtypeAnnotating => SubtypeAnnotatingRule(),
      });
    }
    logger.info('Mapped warning rules');
    return rules;
  }

  /// Registers all lint rules with the given registry.
  void registerWarnings(PluginRegistry registry) {
    logger.info('Registering warning rules');
    for (final rule in warnings) {
      try {
        registry.registerWarningRule(rule);
        // ignore: avoid_catches_without_on_clauses, handles integration
      } catch (e, st) {
        logger.severe(
          'Failed to register warning rule',
          e,
          st,
        );
      }
    }
    logger.info('Registered warning rules');
  }
}
