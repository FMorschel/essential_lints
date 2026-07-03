import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:essential_lints_annotations/essential_lints_annotations.dart';
import 'package:logging/logging.dart';

import '../rules/analysis_rule.dart';

/// {@template correction_producer_logger}
/// The base class for all essential correction producers with logging.
/// {@endtemplate}
@SubtypeAnnotating(
  annotations: [staticLoggerEnforcement],
  option: .onlyConcrete,
)
abstract class CorrectionProducerLogger extends ResolvedCorrectionProducer {
  /// {@macro correction_producer_logger}
  CorrectionProducerLogger(this.logger, {required super.context});

  /// The logger for this correction producer.
  final Logger logger;
}

/// {@template correction_producer_timer}
/// The decorator that times the execution of specific CorrectionProducers
/// {@endtemplate}
class CorrectionProducerTimer extends ResolvedCorrectionProducer {
  /// {@macro correction_producer_timer}
  CorrectionProducerTimer(this._producer, {required super.context});

  /// The decorated correction producer.
  final CorrectionProducerLogger _producer;

  @override
  CorrectionApplicability get applicability => _producer.applicability;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    var stopwatch = Stopwatch()..start();
    try {
      await _producer.compute(builder);
    } finally {
      stopwatch.stop();
      _producer.logger.info('Processing time: ${stopwatch.elapsed}');
    }
  }
}
