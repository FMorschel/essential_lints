import 'package:essential_lints/src/warnings/essential_lint_warnings.dart';

class InternalDiagnosticCode extends WarningCode {
  const InternalDiagnosticCode({
    required super.name,
    required super.problemMessage,
    required super.description,
    super.uniqueName,
    super.severity = .WARNING,
    super.type = .STATIC_WARNING,
    super.correctionMessage,
    super.hasPublishedDocs,
  });
}
