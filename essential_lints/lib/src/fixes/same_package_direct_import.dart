import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/src/workspace/workspace.dart'; // ignore: implementation_imports, not exported
import 'package:analyzer_plugin/src/utilities/change_builder/change_builder_dart.dart'; // ignore: implementation_imports, needed for imports
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../rules/analysis_rule.dart';
import '../rules/same_package_direct_import.dart';
import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template same_package_direct_import_fix}
/// A fix that replaces indirect imports within the same package with direct
/// imports.
/// {@endtemplate}
@staticLoggerEnforcement
class SamePackageDirectImportFix extends CorrectionProducerLogger with LintFix {
  /// {@macro same_package_direct_import_fix}
  SamePackageDirectImportFix({required super.context}) : super(_logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'SamePackageDirectImportFix',
  );

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintFixes get fix => .samePackageDirectImportFix;

  Workspace get _workspace =>
      sessionHelper.session.analysisContext.contextRoot.workspace;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    logger.info('SamePackageDirectImportFix.compute() started');
    if (diagnostic == null) {
      logger.finer('Diagnostic is null, returning');
      return;
    }
    logger.fine('Diagnostic found');
    var node = this.node.parent;
    logger.finer('Parent node type: ${node.runtimeType}');
    if (node is! ImportDirective) {
      logger.finer('Parent node is not ImportDirective, returning');
      return;
    }
    logger.fine('Parent node is ImportDirective');
    var libraryPackage = _workspace.findPackageFor(
      unitResult.libraryElement.firstFragment.source.fullName,
    );
    if (libraryPackage == null) {
      logger.finer('Library package not found in workspace, returning');
      return;
    }
    logger.fine('Found library package: ${libraryPackage.root}');
    var uris = SamePackageDirectImportVisitor.uris(node, libraryPackage);
    if (uris.isEmpty) {
      logger.finer('No direct import URIs found, returning');
      return;
    }
    logger.fine('Found ${uris.length} direct import URIs');
    var options = getCodeStyleOptions(unitResult.file);
    var package = options.usePackageUris;
    var relative = options.useRelativeUris;
    logger.fine(
      'Code style options: usePackageUris=$package, useRelativeUris=$relative',
    );
    await builder.addDartFileEdit(file, createEditsForImports: false, (
      builder,
    ) {
      var imports = <String>{};
      for (var uri in uris) {
        if (builder is DartFileEditBuilderImpl) {
          if (package || !relative) {
            logger.finer('  Adding absolute URI: $uri');
            imports.add(builder.importLibraryWithAbsoluteUri(uri));
          } else {
            logger.finer('  Adding relative URI: $uri');
            imports.add(builder.importLibraryWithRelativeUri(uri));
          }
        }
      }
      var quote = options.preferredQuoteForUris(const []);
      var prefix = node.prefix?.name ?? '';
      if (prefix.isNotEmpty) {
        prefix = ' as $prefix';
        logger.finer('Import has prefix: $prefix');
      }
      logger.fine(
        'Writing ${imports.length} import statements with quote style: $quote',
      );
      builder.addReplacement(range.node(node), (builder) {
        for (var (index, import) in imports.indexed) {
          builder.write('import $quote$import$quote$prefix;');
          if (index < imports.length - 1) {
            builder.writeln();
          }
        }
      });
    });
    logger.info('SamePackageDirectImportFix.compute() completed successfully');
  }
}
