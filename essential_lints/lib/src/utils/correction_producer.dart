import 'package:analysis_server_plugin/edit/change_builder/change_builder.dart';
import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analysis_server_plugin/edit/range_factory.dart' as r;
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

  /// A helper getter for the [r.range] instance.
  r.RangeFactory get range => r.range;
}

/// {@template correction_producer_timer}
/// The decorator that times the execution of specific CorrectionProducers
/// {@endtemplate}
class CorrectionProducerTimer extends ResolvedCorrectionProducer {
  CorrectionProducerTimer._(
    GeneratorProducer generator, {
    required super.context,
  }) : _producer = generator(context: context);

  /// {@macro correction_producer_timer}
  static TimedGeneratorProducer timed(GeneratorProducer generator) =>
      ({required context}) =>
          CorrectionProducerTimer._(context: context, generator);

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

/// A typedef for the base producer logger generator.
typedef GeneratorProducer =
    CorrectionProducerLogger Function({
      required CorrectionProducerContext context,
    });

/// A typedef for the timed producer logger generator.
typedef TimedGeneratorProducer =
    CorrectionProducerTimer Function({
      required CorrectionProducerContext context,
    });

/// Extension on the base producer logger generator.
extension GeneratorProducerExt on GeneratorProducer {
  /// A simpler getter that wraps the generator into a timed version.
  TimedGeneratorProducer get timed => CorrectionProducerTimer.timed(this);
}
