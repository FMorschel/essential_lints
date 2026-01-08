import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/src/workspace/pub.dart'; // ignore: implementation_imports, not exported
import 'package:analyzer/src/workspace/workspace.dart';
import 'package:analyzer_plugin/src/utilities/change_builder/change_builder_dart.dart'; // ignore: implementation_imports, needed for imports
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

import '../rules/same_package_direct_import.dart';
import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template same_package_direct_import_fix}
/// A fix that replaces indirect imports within the same package with direct
/// imports.
/// {@endtemplate}
class SamePackageDirectImportFix extends ResolvedCorrectionProducer
    with LintFix {
  /// {@macro same_package_direct_import_fix}
  SamePackageDirectImportFix({required super.context});

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintFixes get fix => .samePackageDirectImportFix;

  Workspace get _workspace =>
      sessionHelper.session.analysisContext.contextRoot.workspace;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    if (diagnostic == null) {
      return;
    }
    var node = this.node.parent;
    if (node is! ImportDirective) {
      return;
    }
    PubPackage pubPackage;
    var libraryPackage = _workspace.findPackageFor(
      unitResult.libraryElement.firstFragment.source.fullName,
    );
    if (libraryPackage is PubPackage) {
      pubPackage = libraryPackage;
    } else {
      return;
    }
    var uris = SamePackageDirectImportVisitor.uris(node, pubPackage);
    if (uris.isEmpty) {
      return;
    }
    var options = getCodeStyleOptions(unitResult.file);
    var package = options.usePackageUris;
    var relative = options.useRelativeUris;
    await builder.addDartFileEdit(file, createEditsForImports: false, (
      builder,
    ) {
      var imports = <String>{};
      for (var uri in uris) {
        if (builder is DartFileEditBuilderImpl) {
          if (package || !relative) {
            imports.add(builder.importLibraryWithAbsoluteUri(uri));
          } else {
            imports.add(builder.importLibraryWithRelativeUri(uri));
          }
        }
      }
      var quote = options.preferredQuoteForUris(const []);
      var prefix = node.prefix?.name ?? '';
      if (prefix.isNotEmpty) {
        prefix = ' as $prefix';
      }
      builder.addReplacement(range.node(node), (builder) {
        for (var (index, import) in imports.indexed) {
          builder.write('import $quote$import$quote$prefix;');
          if (index < imports.length - 1) {
            builder.writeln();
          }
        }
      });
    });
  }
}
