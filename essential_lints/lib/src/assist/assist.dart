import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';

import 'essential_lint_assists.dart';

/// {@template fix}
/// The base class for all essential lint fixes.
/// {@endtemplate}
abstract class Assist extends ResolvedCorrectionProducer {
  /// {@macro fix}
  Assist({required super.context});

  @override
  CorrectionApplicability get applicability => .singleLocation;

  /// The essential lint fix associated with this correction producer.
  EssentialLintAssists get assist;

  @override
  AssistKind get assistKind => assist;
}
