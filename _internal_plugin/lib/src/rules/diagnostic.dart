import 'package:analyzer/error/error.dart';

class InternalDiagnosticCode extends DiagnosticCode {
  InternalDiagnosticCode({
    required super.name,
    required super.problemMessage,
    required super.uniqueName,
    this.severity = .WARNING,
    this.type = .STATIC_WARNING,
    super.correctionMessage,
    super.hasPublishedDocs,
    super.isUnresolvedIdentifier,
  });

  @override
  final DiagnosticSeverity severity;

  @override
  final DiagnosticType type;
}
