import 'dart:async';

import 'package:analysis_server_plugin/edit/fix/dart_fix_context.dart';
import 'package:analysis_server_plugin/edit/fix/fix.dart';
import 'package:analysis_server_plugin/src/correction/dart_change_workspace.dart'
    as dart_change_workspace;
import 'package:analysis_server_plugin/src/correction/fix_generators.dart'
    as fix_generators;
import 'package:analysis_server_plugin/src/correction/fix_processor.dart'
    as fix_processor;
import 'package:analysis_server_plugin/src/plugin_server.dart' as plugin_server;
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/instrumentation/service.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart'
    as analysis_context_collection;
import 'package:analyzer/src/dart/analysis/byte_store.dart' as byte_store;
import 'package:analyzer/src/dart/analysis/driver_based_analysis_context.dart'
    as driver_based_analysis_context;
import 'package:analyzer/src/test_utilities/test_code_format.dart';
import 'package:analyzer_plugin/channel/channel.dart';
import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
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
    await _analysisContextCollection?.dispose();
    _analysisContextCollection = null;
    await super.tearDown();
  }

  late String code;

  late ResolvedUnitResult testUnit;

  late ResolvedLibraryResult? testLibrary;

  @override
  analysis_context_collection.AnalysisContextCollectionImpl?
  _analysisContextCollection;

  Future<void> resolveTestCode(String code) async {
    this.code = code;
    testFile.writeAsStringSync(code);
    testUnit = await resolveFile(testFile.path);
    testLibrary = await resolveLibrary(testFile.path);
  }

  Diagnostic _singleDiagnostic() {
    final diagnostics = testUnit.diagnostics;
    if (diagnostics.isEmpty) {
      throw StateError('Expected at least one diagnostic, found none.');
    }
    if (diagnostics.length > 1) {
      throw StateError(
        'Expected a single diagnostic, found ${diagnostics.length}.',
      );
    }
    return diagnostics.first;
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
    expected = normalizeNewlinesForPlatform(expected);
    additionallyChangedFiles = additionallyChangedFiles?.map(
      (key, value) =>
          MapEntry(key, value.map(normalizeNewlinesForPlatform).toList()),
    );

    // Remove any marker in the expected code. We allow markers to prevent an
    // otherwise empty line from having the leading whitespace be removed.
    expected = TestCode.parse(expected).code;
    var assist = await _assertHasAssist();
    _change = assist.change;
    expect(_change.id, kind.id);
    // apply to "file"
    var fileEdits = _change.edits;
    if (additionallyChangedFiles == null) {
      expect(fileEdits, hasLength(1));
      expect(_change.edits[0].file, testFile.path);
      _resultCode = SourceEdit.applySequence(testCode, _change.edits[0].edits);
      expect(_resultCode, expected);
    } else {
      expect(fileEdits, hasLength(additionallyChangedFiles.length + 1));
      var fileEdit = _change.getFileEdit(testFile.path)!;
      _resultCode = SourceEdit.applySequence(testCode, fileEdit.edits);
      expect(_resultCode, expected);
      for (var additionalEntry in additionallyChangedFiles.entries) {
        var filePath = additionalEntry.key;
        var pair = additionalEntry.value;
        var fileEdit = _change.getFileEdit(filePath)!;
        var resultCode = SourceEdit.applySequence(pair[0], fileEdit.edits);
        expect(resultCode, pair[1]);
      }
    }
    return _change;
  }

  /// Asserts that there is no [Assist] of the given [kind] at [offset].
  Future<void> assertNoAssist([int index = 0]) async {
    setPositionOrRange(index);
    var assists = await _computeAssists();
    for (var assist in assists) {
      if (assist.kind == kind) {
        fail('Unexpected assist $kind in\n${assists.join('\n')}');
      }
    }
  }

  /// Computes fixes for the given [diagnostic] in [testUnit].
  Future<List<Fix>> _computeFixes(Diagnostic diagnostic) async {
    var libraryResult = testLibrary;
    if (libraryResult == null) {
      return const [];
    }
    var context = DartFixContext(
      instrumentationService: TestInstrumentationService(),
      workspace: dart_change_workspace.DartChangeWorkspace([
        sessionFor(testUnit.path),
      ]),
      libraryResult: libraryResult,
      unitResult: testUnit,
      error: diagnostic,
    );
    return fix_processor.computeFixes(context);
  }
}

extension on SomeResolvedLibraryResult {
  T? ifTypeOrNull<T extends SomeResolvedLibraryResult>() {
    if (this is T) {
      return this as T;
    }
    return null;
  }
}

mixin SelectionMixin on AssistTest {
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
