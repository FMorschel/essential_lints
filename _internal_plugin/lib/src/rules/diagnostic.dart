import 'package:analyzer/error/error.dart';

class InternalDiagnosticCode extends DiagnosticCode {
  const InternalDiagnosticCode({
    required super.name,
    required super.problemMessage,
    String? uniqueName,
    this.severity = .WARNING,
    this.type = .STATIC_WARNING,
    super.correctionMessage,
    super.hasPublishedDocs,
    super.isUnresolvedIdentifier,
  }) : super(uniqueName: uniqueName ?? name);

  @override
  final DiagnosticSeverity severity;

  @override
  final DiagnosticType type;
}
