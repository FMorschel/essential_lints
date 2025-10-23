import 'package:analysis_server_plugin/edit/fix/dart_fix_context.dart';
import 'package:analysis_server_plugin/edit/fix/fix.dart';
import 'package:analysis_server_plugin/src/correction/dart_change_workspace.dart';
import 'package:analysis_server_plugin/src/correction/fix_processor.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/instrumentation/service.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/src/dart/analysis/byte_store.dart';
import 'package:analyzer/src/dart/analysis/driver_based_analysis_context.dart';
import 'package:analyzer/src/lint/registry.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:essential_lints/src/plugin_integration.dart';
import 'package:test/test.dart';

abstract class FixTest extends AnalysisRuleTest
    with RulesPluginIntegration, FixesPluginIntegration, PrivateMixin {
  FixKind get fixKind;

  @override
  late final analysisRule = rules.first.rule.code.name;

  @override
  void setUp() {
    rules.forEach(Registry.ruleRegistry.registerLintRule);
    fixes.forEach((lintCode, generators) {
      for (final generator in generators) {
        // Register the fixes for the rules.
      }
    });
    super.setUp();
  }

  late String code;

  late ResolvedUnitResult testUnit;

  late ResolvedLibraryResult? testLibrary;

  @override
  AnalysisContextCollectionImpl? _analysisContextCollection;

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

  Future<void> assertHasFix(String expected) async {
    var diagnostic = _singleDiagnostic();
    var fixes = await _computeFixes(diagnostic);
    var fix = fixes.where((fix) => fix.kind == fixKind).toList();
    expect(fix, hasLength(1));
    final fileEdits = fix.single.change.edits;
    expect(fileEdits, hasLength(1));
    var fileContent = code;
    var resultCode = SourceEdit.applySequence(
      fileContent,
      fileEdits.single.edits,
    );
    expect(resultCode, expected);
  }

  Future<void> assertNoFix() async {
    var diagnostic = _singleDiagnostic();
    var fixes = await _computeFixes(diagnostic);
    expect(fixes, isEmpty);
  }

  /// Computes fixes for the given [diagnostic] in [testUnit].
  Future<List<Fix>> _computeFixes(Diagnostic diagnostic) async {
    var libraryResult = testLibrary;
    if (libraryResult == null) {
      return const [];
    }
    var context = DartFixContext(
      instrumentationService: TestInstrumentationService(),
      workspace: DartChangeWorkspace([sessionFor(testUnit.path)]),
      libraryResult: libraryResult,
      unitResult: testUnit,
      error: diagnostic,
    );
    return computeFixes(context);
  }
}

class TestInstrumentationService implements InstrumentationService {
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

mixin PrivateMixin on AnalysisRuleTest {
  /// The byte store that is reused between tests.
  ///
  /// This allows reusing all unlinked and linked summaries for SDK, so that
  /// tests run much faster. However nothing is preserved between Dart VM runs,
  /// so changes to the implementation are still fully verified.
  static final MemoryByteStore _sharedByteStore = MemoryByteStore();

  final MemoryByteStore _byteStore = _sharedByteStore;

  AnalysisContextCollectionImpl? get _analysisContextCollection;
  set _analysisContextCollection(AnalysisContextCollectionImpl? value);

  List<String> get _collectionIncludedPaths => [workspaceRootPath];

  AnalysisSession sessionFor(String path) {
    var analysisContext = _contextFor(path);
    return analysisContext.currentSession;
  }

  /// Resolves a Dart source file at [path].
  ///
  /// [path] must be converted for this file system.
  Future<ResolvedLibraryResult?> resolveLibrary(String path) async {
    var analysisContext = _contextFor(path);
    var session = analysisContext.currentSession;
    return (await session.getResolvedLibrary(
      path,
    )).ifTypeOrNull<ResolvedLibraryResult>();
  }

  DriverBasedAnalysisContext _contextFor(String path) {
    _createAnalysisContexts();

    var convertedPath = convertPath(path);
    return _analysisContextCollection!.contextFor(convertedPath);
  }

  /// Creates all analysis contexts in [_collectionIncludedPaths].
  void _createAnalysisContexts() {
    if (_analysisContextCollection != null) {
      return;
    }

    _analysisContextCollection = AnalysisContextCollectionImpl(
      byteStore: _byteStore,
      declaredVariables: {},
      enableIndex: true,
      includedPaths: _collectionIncludedPaths.map(convertPath).toList(),
      resourceProvider: resourceProvider,
      sdkPath: newFolder('/sdk').path,
    );
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
