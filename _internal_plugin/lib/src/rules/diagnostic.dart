import 'package:essential_lints/src/warnings/essential_lint_warnings.dart'
    as diagnostic;

import 'rule.dart';

class InternalDiagnosticCode<R extends InternalLintRule>
    extends diagnostic.WarningCode<R> {
  const InternalDiagnosticCode({
    required super.rule,
    required super.problemMessage,
    super.uniqueName,
    super.severity = .WARNING,
    super.type = .STATIC_WARNING,
    super.correctionMessage,
  });
}

mixin SubDiagnostic<R extends InternalLintRule>
    on diagnostic.SubDiagnostic<InternalDiagnosticCode<R>, R> {}

enum InternalDiagnostics
    with
        diagnostic.EnumDiagnostic<InternalDiagnosticCode, InternalLintRule>,
        diagnostic.SuperDiagnostic<
          InternalMultiLints,
          InternalDiagnosticCode,
          InternalLintRule
        > {
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
  final InternalDiagnosticCode<InternalLintRule> code;

  @override
  final List<InternalMultiLints> subDiagnostics;
}

@diagnostic.staticAllEnforcement
enum InternalMultiLints
    with
        diagnostic.EnumDiagnostic<
          InternalDiagnosticCode<InternalLintRule>,
          InternalLintRule
        >,
        diagnostic.SubDiagnostic,
        SubDiagnostic {
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
  final InternalDiagnosticCode<InternalLintRule> code;
}
