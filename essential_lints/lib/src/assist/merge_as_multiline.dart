import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:logging/logging.dart';

import '../fixes/fix.dart';
import '../plugin.dart';
import '../rules/analysis_rule.dart';
import 'assist.dart';
import 'essential_lint_assists.dart';

/// {@template swap_cases}
/// Assist to remove useless else statements.
/// {@endtemplate}
@staticLoggerEnforcement
class MergeAsMultilineAssist extends CorrectionProducerLogger with Assist {
  /// {@macro swap_cases}
  MergeAsMultilineAssist({required super.context}) : super(_logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'MergeAsMultilineAssist',
  );

  @override
  EssentialLintAssists get assist => .mergeAsMultiline;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    logger.info('MergeAsMultilineAssist.compute() started');
    var node = this.node;
    if (node is! StringLiteral && node is! InterpolationString) {
      logger.finer('Node is not a StringLiteral, returning');
      return;
    }
    if (node case InterpolationString(:var parent?)) {
      node = parent;
    }
    AdjacentStrings adjacentStrings;
    if (node is AdjacentStrings) {
      adjacentStrings = node;
    } else if (node.parent case AdjacentStrings node) {
      adjacentStrings = node;
    } else {
      logger.finer('Node is not part of AdjacentStrings, returning');
      return;
    }
    await builder.addDartFileEdit(file, (builder) {
      var lastEndsInQuote = switch (adjacentStrings.strings.last) {
        SimpleStringLiteral(:var value) => value.endsWith("'"),
        StringInterpolation(:var lastString) => lastString.value.endsWith("'"),
        _ => throw ArgumentError(
          'Unexpected StringLiteral type: ${adjacentStrings.runtimeType}',
        ),
      };
      var couldBeRaw = !lastEndsInQuote;
      var anyIsRaw = false;
      var mergeWith = <(StringLiteral, StringLiteral, String)>[];
      for (var (string, next) in adjacentStrings.stringPairs) {
        if (couldBeRaw && string.contains("'''")) {
          couldBeRaw = false;
        }
        if (couldBeRaw &&
            (string is StringInterpolation || next is StringInterpolation)) {
          couldBeRaw = false;
        }
        if (couldBeRaw &&
            !anyIsRaw &&
            (string is SimpleStringLiteral && string.isRaw ||
                next is SimpleStringLiteral && next.isRaw)) {
          anyIsRaw = true;
        }
        if (lineInfo.onSameLine(string.end, next.offset)) {
          mergeWith.add((string, next, ''));
        } else {
          mergeWith.add((string, next, builder.eol));
        }
      }
      var contentsOffset = adjacentStrings.strings.first.contentsOffset;
      if (couldBeRaw && anyIsRaw) {
        builder.addSimpleReplacement(
          range.startOffsetEndOffset(
            adjacentStrings.strings.first.offset,
            contentsOffset,
          ),
          "r'''${builder.eol}",
        );
      } else {
        builder.addSimpleReplacement(
          range.startOffsetEndOffset(
            adjacentStrings.strings.first.offset,
            contentsOffset,
          ),
          "'''${builder.eol}",
        );
      }
      if (!couldBeRaw) {
        for (var string in adjacentStrings.strings.take(
          adjacentStrings.strings.length - 1,
        )) {
          if (string is SimpleStringLiteral) {
            var escaped = string.value.replaceAll("'''", r"''\'");
            if (string.isRaw) {
              escaped = escaped.replaceAll(r'\', r'\\').replaceAll(r'$', r'\$');
            }
            builder.addSimpleReplacement(
              range.startOffsetEndOffset(
                string.contentsOffset,
                string.contentsEnd,
              ),
              escaped,
            );
          } else if (string is StringInterpolation) {
            for (var part in string.elements) {
              if (part is InterpolationString) {
                var escaped = part.value.replaceAll("'''", r"''\'");
                builder.addSimpleReplacement(
                  range.startOffsetEndOffset(
                    part.contentsOffset,
                    part.contentsEnd,
                  ),
                  escaped,
                );
              }
            }
          }
        }
      }
      for (var (string, next, separator) in mergeWith) {
        var offset = string.contentsEnd;
        var end = next.contentsOffset;
        builder.addSimpleReplacement(
          range.startOffsetEndOffset(offset, end),
          separator,
        );
      }
      switch (adjacentStrings.strings.last) {
        case SimpleStringLiteral(:var value, :var isRaw):
          if (value.isEmpty) {
            break;
          }
          var escaped = value
              .substring(0, value.length - 1)
              .replaceAll("'''", r"''\'");
          if (isRaw) {
            escaped = escaped.replaceAll(r'\', r'\\').replaceAll(r'$', r'\$');
          }
          builder.addSimpleReplacement(
            range.startOffsetEndOffset(
              adjacentStrings.strings.last.contentsOffset,
              adjacentStrings.strings.last.contentsEnd - 1,
            ),
            escaped,
          );
        case StringInterpolation(:var elements):
          var texts = elements.whereType<InterpolationString>().toList();
          for (var part in texts.take(texts.length - 1)) {
            if (part.value.isEmpty) {
              break;
            }
            var escaped = part.value.replaceAll("'''", r"''\'");
            builder.addSimpleReplacement(
              range.startOffsetEndOffset(part.contentsOffset, part.contentsEnd),
              escaped,
            );
          }
          if (texts.last.value.isEmpty) {
            break;
          }
          var lastUntilLast = texts.last.value.substring(
            0,
            texts.last.value.length - 1,
          );
          if (lastUntilLast.contains("'''")) {
            var escaped = lastUntilLast.replaceAll("'''", r"''\'");
            builder.addSimpleReplacement(
              range.startOffsetEndOffset(
                texts.last.contentsOffset,
                texts.last.contentsEnd - 1,
              ),
              escaped,
            );
          }
        default:
          break;
      }
      if (lastEndsInQuote) {
        builder.addSimpleReplacement(
          range.startOffsetEndOffset(
            adjacentStrings.strings.last.contentsEnd - 1,
            adjacentStrings.strings.last.contentsEnd,
          ),
          r"\'",
        );
      }
      var lastContentEnd = adjacentStrings.strings.last.contentsEnd;
      builder.addSimpleReplacement(
        range.startOffsetEndOffset(lastContentEnd, adjacentStrings.end),
        "'''",
      );
    });
    logger.info('MergeAsMultilineAssist.compute() completed successfully');
  }
}

extension on StringLiteral {
  int get contentsOffset => switch (this) {
    StringInterpolation(:var contentsOffset) => contentsOffset,
    SimpleStringLiteral(:var contentsOffset) => contentsOffset,
    _ => throw ArgumentError('Unexpected StringLiteral type: $runtimeType'),
  };
  int get contentsEnd => switch (this) {
    StringInterpolation(:var contentsEnd) => contentsEnd,
    SimpleStringLiteral(:var contentsEnd) => contentsEnd,
    _ => throw ArgumentError('Unexpected StringLiteral type: $runtimeType'),
  };

  bool contains(String string) {
    if (this case SimpleStringLiteral(:var value) when value.contains(string)) {
      return true;
    }
    return false;
  }
}

extension on AdjacentStrings {
  List<(StringLiteral, StringLiteral)> get stringPairs {
    return [
      for (var i = 0; i < strings.length - 1; i++) (strings[i], strings[i + 1]),
    ];
  }
}
