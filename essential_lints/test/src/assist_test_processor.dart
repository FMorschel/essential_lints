import 'dart:async';

import 'package:analysis_server_plugin/edit/assist/assist.dart';
import 'package:analysis_server_plugin/edit/assist/dart_assist_context.dart';
import 'package:analysis_server_plugin/src/correction/assist_processor.dart'
    as assist_processor;
import 'package:analyzer/src/test_utilities/test_code_format.dart'
    as test_code_format;
import '../../lib/src/assist/essential_lint_assists.dart';
import '../../lib/src/rules/essential_lint_rules.dart';
import 'package:test/test.dart';

import 'base_edit_test_processor.dart';

abstract class AssistTestProcessor extends BaseEditTestProcessor {
  EssentialLintAssists get assistKind;

  @override
  late final analysisRule = EssentialLintRules.values.first.code.name;

  /// Asserts that there is an assist of the given [assistKind] at [offset]
  /// which produces the [expected] code when applied to [testCode]. The map of
  /// [additionallyChangedFiles] can be used to test assists that can modify
  /// more than the test file. The keys are expected to be the paths to the
  /// files that are modified (other than the test file) and the values are
  /// pairs of source code: the states of the code before and after the edits
  /// have been applied.
  Future<void> assertHasAssist(
    String expected, {
    List<({String path, String original, String result})>?
    additionallyChangedFiles,
    int index = 0,
  }) async {
    setPositionOrRange(index);
    additionallyChangedFiles = additionallyChangedFiles
        ?.map(
          (record) => (
            path: record.path,
            original: test_code_format.TestCode.parseNormalized(
              record.original,
            ).code,
            result: test_code_format.TestCode.parseNormalized(
              record.result,
            ).code,
          ),
        )
        .toList();

    // Remove any marker in the expected code. We allow markers to prevent an
    // otherwise empty line from having the leading whitespace be removed.
    var assists = await _computeAssists();
    Assist assist;
    try {
      assist = assists.firstWhere((assist) => assist.kind == assistKind);
    } catch (e) {
      fail('Expected assist $assistKind not found in\n${assists.join('\n')}');
    }
    var change = assist.change;
    expect(change.id, assistKind.id);
    // apply to "file"
    if (additionallyChangedFiles == null) {
      matchesExpected(expected, change: change);
    } else {
      expect(change.edits, hasLength(additionallyChangedFiles.length + 1));
      var fileEdit = change.getFileEdit(testFile.path)!;
      matchesExpected(expected, fileEdit: fileEdit);
      for (final (:path, :original, :result) in additionallyChangedFiles) {
        var fileEdit = change.getFileEdit(path)!;
        matchesExpected(
          result,
          fileEdit: fileEdit,
          target: path,
          original: original,
        );
      }
    }
  }

  /// Asserts that there is no [Assist] of the given [assistKind] at [offset].
  Future<void> assertNoAssist([int index = 0]) async {
    setPositionOrRange(index);
    var assists = await _computeAssists();
    for (final assist in assists) {
      if (assist.kind == assistKind) {
        fail('Unexpected assist $assistKind in\n${assists.join('\n')}');
      }
    }
  }

  Future<List<Assist>> _computeAssists() async {
    var libraryResult = testLibrary;
    if (libraryResult == null) {
      return const [];
    }
    var context = DartAssistContext(
      instrumentationService,
      workspace,
      libraryResult,
      testUnit,
      offset,
      length,
    );
    return assist_processor.computeAssists(context);
  }
}
