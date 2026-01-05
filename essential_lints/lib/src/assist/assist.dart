import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

import 'essential_lint_assists.dart';

/// {@template assist}
/// The base mixin for all essential assists.
/// {@endtemplate}
@SubtypeNaming(containing: 'Assist')
mixin Assist on ResolvedCorrectionProducer {
  @override
  CorrectionApplicability get applicability => .singleLocation;

  /// The essential assist associated with this correction producer.
  EssentialLintAssists get assist;

  @override
  AssistKind get assistKind => assist;
}
