import 'package:essential_lints/src/warnings/essential_lint_warnings.dart'
    as diagnostic;

import 'rule.dart';

class InternalDiagnosticCode extends diagnostic.WarningCode {
  const InternalDiagnosticCode({
    required InternalLintRule super.rule,
    required super.problemMessage,
    super.uniqueName,
    super.severity = .WARNING,
    super.type = .STATIC_WARNING,
    super.correctionMessage,
  });
}

mixin SubDiagnostic on diagnostic.SubDiagnostic {}

enum InternalDiagnostics
    with
        diagnostic.EnumDiagnostic,
        diagnostic.SuperDiagnostic<InternalMultiLints> {
  subDiagnostic(
    InternalDiagnosticCode(
      rule: .subDiagnostic,
      problemMessage: "The SubDiagnostic name doesn't match base's name.",
      correctionMessage: "Change the SubDiagnostic name to '{0}'.",
    ),
    InternalMultiLints.values,
  );

  const InternalDiagnostics(this.code, this.subDiagnostics);

  @override
  final InternalDiagnosticCode code;

  @override
  final List<InternalMultiLints> subDiagnostics;
}

@diagnostic.staticAllEnforcement
enum InternalMultiLints
    with diagnostic.EnumDiagnostic, diagnostic.SubDiagnostic, SubDiagnostic {
  nonUniqueName(
    InternalDiagnosticCode(
      rule: .subDiagnostic,
      uniqueName: 'non_unique_name',
      problemMessage: "The SubDiagnostic name isn't unique.",
      correctionMessage: 'Change the SubDiagnostic name to be unique.',
    ),
  );

  const InternalMultiLints(this.code);

  static const List<diagnostic.EnumDiagnostic> all = [...values, base];

  static const InternalDiagnostics base = .subDiagnostic;

  @override
  final InternalDiagnosticCode code;
}
