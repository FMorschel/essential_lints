import 'package:essential_lints/src/warnings/essential_lint_warnings.dart'
    as d
    show SubDiagnostic;
import 'package:essential_lints/src/warnings/essential_lint_warnings.dart'
    hide SubDiagnostic;
import 'package:essential_lints/src/warnings/warning.dart';

part 'other.dart';

@staticAllEnforcement
enum SubLints
    with
        EnumDiagnostic<InternalDiagnosticCode, TestRule>,
        d.SubDiagnostic<InternalDiagnosticCode, TestRule>,
        SubDiagnostic<InternalDiagnosticCode, TestRule> {
  subLint(
    InternalDiagnosticCode(
      rule: .instance,
      uniqueName: 'sub_lint',
      problemMessage: '',
    ),
  );

  const SubLints(this.code);

  static const List<EnumDiagnostic> all = [...values, base];

  static const BaseLints base = .subDiagnostic;

  @override
  final InternalDiagnosticCode code;
}
