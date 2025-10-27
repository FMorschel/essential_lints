import 'dart:async';

import 'package:analysis_server_plugin/edit/assist/assist.dart' show Assist;
import 'package:analysis_server_plugin/edit/assist/dart_assist_context.dart';
import 'package:analysis_server_plugin/src/correction/assist_processor.dart'
    as assist_processor;
import 'package:analysis_server_plugin/src/correction/dart_change_workspace.dart'
    as dart_change_workspace;
import 'package:analysis_server_plugin/src/correction/fix_generators.dart'
    as fix_generators;
import 'package:analysis_server_plugin/src/plugin_server.dart' as plugin_server;
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart'
    as analysis_context_collection;
import 'package:analyzer/src/test_utilities/platform.dart' as platform;
import 'package:analyzer/src/test_utilities/test_code_format.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:essential_lints/main.dart';
import 'package:essential_lints/src/assist/essential_lint_assists.dart';
import 'package:essential_lints/src/plugin_integration.dart';
import 'package:test/test.dart';

import 'fix_test.dart';

abstract class AssistTest extends AnalysisRuleTest
    with
        RulesPluginIntegration,
        FixesPluginIntegration,
        PrivateMixin,
        SelectionMixin {
  EssentialLintAssists get assistKind;

  final channel = FakeChannel();

  @override
  late final TestCode testCode;

  @override
  late final analysisRule = rules.first.rule.code.name;

  late final plugin_server.PluginServer pluginServer;

  Folder get byteStoreRoot => getFolder('/byteStore');

  Folder get sdkRoot => getFolder('/sdk');

  @override
  Future<void> setUp() async {
    pluginServer = plugin_server.PluginServer(
      plugins: [plugin],
      resourceProvider: resourceProvider,
    );
    await pluginServer.initialize();
    pluginServer.start(channel);
    await pluginServer.handlePluginVersionCheck(
      PluginVersionCheckParams(
        byteStoreRoot.path,
        sdkRoot.path,
        '0.0.1',
      ),
    );
    super.setUp();
  }

  @override
  Future<void> tearDown() async {
    fix_generators.registeredFixGenerators.clearLintProducers();
    await analysisContextCollection?.dispose();
    analysisContextCollection = null;
    await super.tearDown();
  }

  late String code;

  late ResolvedUnitResult testUnit;

  late ResolvedLibraryResult? testLibrary;

  @override
  analysis_context_collection.AnalysisContextCollectionImpl?
  analysisContextCollection;

  Future<void> resolveTestCode(String code) async {
    testCode = TestCode.parseNormalized(code);
    this.code = testCode.code;
    testFile.writeAsStringSync(this.code);
    testUnit = await resolveFile(testFile.path);
    testLibrary = await resolveLibrary(testFile.path);
  }

  /// Asserts that there is an assist of the given [assistKind] at [offset]
  /// which produces the [expected] code when applied to [testCode]. The map of
  /// [additionallyChangedFiles] can be used to test assists that can modify
  /// more than the test file. The keys are expected to be the paths to the
  /// files that are modified (other than the test file) and the values are
  /// pairs of source code: the states of the code before and after the edits
  /// have been applied.
  Future<void> assertHasAssist(
    String expected, {
    Map<String, List<String>>? additionallyChangedFiles,
    int index = 0,
  }) async {
    setPositionOrRange(index);
    expected = platform.normalizeNewlinesForPlatform(expected);
    additionallyChangedFiles = additionallyChangedFiles?.map(
      (key, value) => MapEntry(
        key,
        value.map(platform.normalizeNewlinesForPlatform).toList(),
      ),
    );

    // Remove any marker in the expected code. We allow markers to prevent an
    // otherwise empty line from having the leading whitespace be removed.
    expected = TestCode.parse(expected).code;
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
    var fileEdits = change.edits;
    if (additionallyChangedFiles == null) {
      expect(fileEdits, hasLength(1));
      expect(change.edits[0].file, testFile.path);
      var resultCode = SourceEdit.applySequence(code, change.edits[0].edits);
      expect(resultCode, expected);
    } else {
      expect(fileEdits, hasLength(additionallyChangedFiles.length + 1));
      var fileEdit = change.getFileEdit(testFile.path)!;
      var resultCode = SourceEdit.applySequence(code, fileEdit.edits);
      expect(resultCode, expected);
      for (final additionalEntry in additionallyChangedFiles.entries) {
        var filePath = additionalEntry.key;
        var pair = additionalEntry.value;
        var fileEdit = change.getFileEdit(filePath)!;
        var resultCode = SourceEdit.applySequence(pair[0], fileEdit.edits);
        expect(resultCode, pair[1]);
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
      TestInstrumentationService(),
      dart_change_workspace.DartChangeWorkspace([
        sessionFor(testUnit.path),
      ]),
      libraryResult,
      testUnit,
      offset,
      length,
    );
    return assist_processor.computeAssists(context);
  }
}

mixin SelectionMixin on AnalysisRuleTest {
  TestCode get testCode;

  late int offset;
  late int length;

  void setPosition(int index) {
    if (index < 0 || index >= testCode.positions.length) {
      throw ArgumentError('Index out of bounds for positions.');
    }
    offset = testCode.positions[index].offset;
    length = 0;
  }

  void setPositionOrRange(int index) {
    if (index < 0) {
      throw ArgumentError('Index must be non-negative.');
    }
    if (testCode.positions.isNotEmpty) {
      setPosition(index);
    } else if (testCode.ranges.isNotEmpty) {
      setRange(index);
    } else {
      throw ArgumentError('Test code must contain a position or range marker.');
    }
  }

  void setRange(int index) {
    if (index < 0 || index >= testCode.ranges.length) {
      throw ArgumentError('Index out of bounds for ranges.');
    }
    var range = testCode.ranges[index].sourceRange;
    offset = range.offset;
    length = range.length;
  }
}
