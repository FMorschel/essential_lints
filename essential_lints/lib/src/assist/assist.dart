import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';

import 'essential_lint_assists.dart';

/// {@template fix}
/// The base mixin for all essential lint fixes.
/// {@endtemplate}
mixin Assist on ResolvedCorrectionProducer {
  @override
  CorrectionApplicability get applicability => .singleLocation;

  /// The essential lint fix associated with this correction producer.
  EssentialLintAssists get assist;

  @override
  AssistKind get assistKind => assist;
}
