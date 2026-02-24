import 'dart:async';

import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:essential_lints/src/fixes/same_package_direct_import.dart';
import 'package:essential_lints/src/rules/essential_lint_rules.dart';
import 'package:essential_lints/src/rules/same_package_direct_import.dart';
import 'package:essential_lints/src/warnings/getters_in_member_list.dart';
import 'package:essential_lints/src/warnings/subtype_annotating.dart';
import 'package:essential_lints/src/warnings/subtype_naming.dart';

import 'rules/annotate_members_with.dart';
import 'rules/invalid_members.dart';
import 'rules/invalid_modifiers.dart';
import 'rules/report_shorter_lengths.dart';
import 'rules/static_enforcement.dart';

class InternalPlugin extends Plugin {
  @override
  String get name => '_internal_plugin';

  @override
  FutureOr<void> register(PluginRegistry registry) {
    registry
      ..registerWarningRule(GettersInMemberListRule())
      ..registerWarningRule(SubtypeAnnotatingRule())
      ..registerWarningRule(SubtypeNamingRule())
      ..registerWarningRule(AnnotateMembersWithRule())
      ..registerWarningRule(InvalidMembersRule())
      ..registerWarningRule(ReportShorterLengthsRule())
      ..registerWarningRule(StaticEnforcementRule())
      ..registerWarningRule(InvalidModifiersRule())
      ..registerWarningRule(SamePackageDirectImportRule())
      ..registerFixForRule(
        EssentialLintRules.samePackageDirectImport,
        SamePackageDirectImportFix.new,
      );
  }
}
