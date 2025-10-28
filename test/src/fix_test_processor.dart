import 'dart:async';

import 'package:analysis_server_plugin/edit/dart/dart_fix_kind_priority.dart';
import 'package:analysis_server_plugin/edit/fix/dart_fix_context.dart';
import 'package:analysis_server_plugin/edit/fix/fix.dart';
import 'package:analysis_server_plugin/src/correction/fix_processor.dart'
    as fix_processor;
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test/test.dart';

import 'base_edit_test_processor.dart';

typedef DiagnosticFilter = bool Function(Diagnostic diagnostic);

abstract class FixTestProcessor extends BaseEditTestProcessor {
  FixKind get fixKind;

  Rule get rule;

  @override
  String get analysisRule => rule.rule.code.name;

  Future<void> assertHasFix(
    String expected, {
    DiagnosticFilter? filter,
    String? target,
    int? expectedNumberOfFixesForKind,
    Pattern? matchFixMessage,
    bool allowFixAllFixes = false,
  }) async {
    var diagnostic = _singleDiagnostic(filter: filter);
    var fixes = await _computeFixes(diagnostic);
    var fix = _parseFix(
      fixes,
      expectedNumberOfFixesForKind: expectedNumberOfFixesForKind,
      matchFixMessage: matchFixMessage,
      allowFixAllFixes: allowFixAllFixes,
    );
    expect(fix, hasLength(1));
    matchesExpected(expected, change: fix.single.change, target: target);
  }

  List<Fix> _parseFix(
    List<Fix> fixes, {
    int? expectedNumberOfFixesForKind,
    Pattern? matchFixMessage,
    bool allowFixAllFixes = false,
  }) {
    fixes = fixes.where((fix) => fix.kind == fixKind).toList();
    if (expectedNumberOfFixesForKind != null) {
      expect(
        fixes,
        hasLength(expectedNumberOfFixesForKind),
        reason:
            'Expected $expectedNumberOfFixesForKind fixes for kind $fixKind, '
            'found ${fixes.length}.',
      );
    }
    if (matchFixMessage != null) {
      fixes = fixes
          .where((fix) => fix.kind.message.contains(matchFixMessage))
          .toList();
      expect(
        fixes,
        isNotEmpty,
        reason:
            'Expected at least one fix matching message "$matchFixMessage", '
            'found none.',
      );
    }
    for (final fix in fixes) {
      if (!allowFixAllFixes &&
          fix.kind.priority == DartFixKindPriority.inFile) {
        fail(
          'A fix-all fix was found for the error: $fixKind '
          'in the computed set of fixes:\n${fixes.join('\n')}',
        );
      }
    }
    return fixes;
  }

  Future<void> assertNoFix({DiagnosticFilter? filter}) async {
    var diagnostic = _singleDiagnostic(filter: filter);
    var fixes = await _computeFixes(diagnostic);
    expect(fixes, isEmpty);
  }

  Diagnostic _singleDiagnostic({DiagnosticFilter? filter}) {
    var diagnostics = testUnit.diagnostics;
    if (filter != null) {
      diagnostics = diagnostics.where(filter).toList();
    }
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

  /// Computes fixes for the given [diagnostic] in [testUnit].
  Future<List<Fix>> _computeFixes(Diagnostic diagnostic) async {
    var libraryResult = testLibrary;
    if (libraryResult == null) {
      return const [];
    }
    var context = DartFixContext(
      instrumentationService: instrumentationService,
      workspace: workspace,
      libraryResult: libraryResult,
      unitResult: testUnit,
      error: diagnostic,
    );
    return fix_processor.computeFixes(context);
  }
}
