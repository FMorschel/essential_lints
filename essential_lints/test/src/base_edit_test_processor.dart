import 'dart:async';

import 'package:analysis_server_plugin/src/correction/assist_generators.dart'
    as assist_generators;
import 'package:analysis_server_plugin/src/correction/dart_change_workspace.dart'
    as dart_change_workspace;
import 'package:analysis_server_plugin/src/correction/fix_generators.dart'
    as fix_generators;
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/instrumentation/service.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart'
    as analysis_context_collection;
import 'package:analyzer/src/dart/analysis/byte_store.dart' as byte_store;
import 'package:analyzer/src/dart/analysis/driver_based_analysis_context.dart'
    as driver_based_analysis_context;
import 'package:analyzer/src/lint/registry.dart' as registry;
import 'package:analyzer/src/test_utilities/test_code_format.dart'
    as test_code_format;
import 'package:analyzer_plugin/channel/channel.dart';
import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:essential_lints/src/plugin_integration.dart';
import 'package:test/test.dart';

abstract class BaseEditTestProcessor extends AnalysisRuleTest
    with
        _PrivateMixin,
        _SelectionMixin,
        RulesPluginIntegration,
        FixesPluginIntegration,
        AssistsPluginIntegration,
        WarningsPluginIntegration {
  static final channel = _FakeChannel();

  late String code;
  late ResolvedUnitResult testUnit;
  late ResolvedLibraryResult? testLibrary;
  @override
  late test_code_format.TestCode testCode;

  @override
  analysis_context_collection.AnalysisContextCollectionImpl?
  analysisContextCollection;

  Folder get byteStoreRoot => getFolder('/byteStore');

  // ignore: library_private_types_in_public_api, only used internally.
  _TestInstrumentationService get instrumentationService => .new();
  Folder get sdkRoot => getFolder('/sdk');
  dart_change_workspace.DartChangeWorkspace get workspace => .new([
    sessionFor(testUnit.path),
  ]);
  void matchesExpected(
    String expected, {
    SourceChange? change,
    SourceFileEdit? fileEdit,
    String? target,
    String? original,
  }) {
    assert(
      (change != null) ^ (fileEdit != null),
      'Provide either change or fileEdit, not both.',
    );
    expect(change?.edits ?? const <Object>[1], hasLength(1));
    fileEdit = change?.edits.single ?? fileEdit!;
    String code;
    if (target != null) {
      expect(fileEdit.file, target);
      code = original ?? getFile(target).readAsStringSync();
    } else {
      code = original ?? this.code;
    }
    var resultCode = SourceEdit.applySequence(code, fileEdit.edits);
    expect(
      resultCode,
      test_code_format.TestCode.parseNormalized(expected).code,
    );
  }

  Future<void> resolveTestCode(String code) async {
    testCode = test_code_format.TestCode.parseNormalized(code);
    this.code = testCode.code;
    testFile.writeAsStringSync(testCode.code);
    testUnit = await resolveFile(testFile.path);
    testLibrary = await resolveLibrary(testFile.path);
  }

  @override
  Future<void> setUp() async {
    rules.forEach(registry.Registry.ruleRegistry.registerLintRule);
    warnings.forEach(registry.Registry.ruleRegistry.registerWarningRule);
    fix_generators.registeredFixGenerators.lintProducers.addAll(lintFixes);
    fix_generators.registeredFixGenerators.nonLintProducers.addAll(
      warningFixes,
    );
    assist_generators.registeredAssistGenerators.producerGenerators.addAll(
      assists,
    );
    super.setUp();
  }

  @override
  Future<void> tearDown() async {
    await analysisContextCollection?.dispose();
    analysisContextCollection = null;
    await super.tearDown();
  }
}

class _FakeChannel implements PluginCommunicationChannel {
  @override
  void close() {}

  @override
  void listen(
    void Function(Request request)? onRequest, {
    void Function()? onDone,
    Function? onError,
    Function? onNotification,
  }) {}

  @override
  void sendNotification(Notification notification) {}

  @override
  void sendResponse(Response response) {}
}

mixin _PrivateMixin on AnalysisRuleTest {
  /// The byte store that is reused between tests.
  ///
  /// This allows reusing all unlinked and linked summaries for SDK, so that
  /// tests run much faster. However nothing is preserved between Dart VM runs,
  /// so changes to the implementation are still fully verified.
  static final byte_store.MemoryByteStore _sharedByteStore =
      byte_store.MemoryByteStore();

  final byte_store.MemoryByteStore _byteStore = _sharedByteStore;

  analysis_context_collection.AnalysisContextCollectionImpl?
  get analysisContextCollection;
  set analysisContextCollection(
    analysis_context_collection.AnalysisContextCollectionImpl? value,
  );

  List<String> get _collectionIncludedPaths => [workspaceRootPath];

  /// Resolves a Dart source file at [path].
  ///
  /// [path] must be converted for this file system.
  Future<ResolvedLibraryResult?> resolveLibrary(String path) async {
    var analysisContext = _contextFor(path);
    var session = analysisContext.currentSession;
    return (await session.getResolvedLibraryContaining(
      path,
    )).ifTypeOrNull<ResolvedLibraryResult>();
  }

  AnalysisSession sessionFor(String path) {
    var analysisContext = _contextFor(path);
    return analysisContext.currentSession;
  }

  driver_based_analysis_context.DriverBasedAnalysisContext _contextFor(
    String path,
  ) {
    _createAnalysisContexts();

    var convertedPath = convertPath(path);
    return analysisContextCollection!.contextFor(convertedPath);
  }

  /// Creates all analysis contexts in [_collectionIncludedPaths].
  void _createAnalysisContexts() {
    if (analysisContextCollection != null) {
      return;
    }

    analysisContextCollection =
        analysis_context_collection.AnalysisContextCollectionImpl(
          byteStore: _byteStore,
          declaredVariables: {},
          enableIndex: true,
          includedPaths: _collectionIncludedPaths.map(convertPath).toList(),
          resourceProvider: resourceProvider,
          sdkPath: newFolder('/sdk').path,
        );
  }
}

mixin _SelectionMixin on AnalysisRuleTest {
  late int offset;

  late int length;
  test_code_format.TestCode get testCode;

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

class _TestInstrumentationService implements InstrumentationService {
  @override
  void logException(
    Object exception, [
    StackTrace? stackTrace,
    List<InstrumentationServiceAttachment>? attachments,
  ]) {
    throw StateError('$exception\n\n$stackTrace');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
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
