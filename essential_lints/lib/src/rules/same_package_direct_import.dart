import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/resolver/scope.dart'; // ignore: implementation_imports, not exported
import 'package:analyzer/workspace/workspace.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template same_package_direct_import}
/// A lint rule that enforces direct imports within the same package.
/// {@endtemplate}
@staticLoggerEnforcement
class SamePackageDirectImportRule extends LintRule {
  /// {@macro same_package_direct_import}
  SamePackageDirectImportRule() : super(.samePackageDirectImport, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'SamePackageDirectImportRule',
  );

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = SamePackageDirectImportVisitor._(
      rule: this,
      context: context,
    );
    registry.addImportDirective(this, visitor);
  }
}

/// {@template same_package_direct_import_visitor}
/// A visitor that checks for indirect imports within the same package and
/// reports them.
/// {@endtemplate}
class SamePackageDirectImportVisitor extends SimpleAstVisitor<void> {
  /// {@macro same_package_direct_import_visitor}
  SamePackageDirectImportVisitor._({
    SamePackageDirectImportRule? rule,
    RuleContext? context,
    WorkspacePackage? package,
  }) : _package = package,
       _rule = rule,
       _context = context;

  final SamePackageDirectImportRule? _rule;
  final RuleContext? _context;
  final WorkspacePackage? _package;

  /// A callback of all detected URIs.
  final Set<Uri> _uris = {};

  @override
  void visitImportDirective(ImportDirective node) {
    _rule?.logger.info(
      'visitImportDirective() started for: ${node.uri.toSource()}',
    );
    // Find all elements exposed by this import.
    var libraryImport = node.libraryImport;
    if (libraryImport == null) {
      _rule?.logger.finer(
        'No libraryImport found for import: ${node.uri.toSource()}',
      );
      super.visitImportDirective(node);
      return;
    }
    // If from a different package, skip.
    switch (libraryImport.uri) {
      case DirectiveUriWithRelativeUriString(:var relativeUriString):
        var uri = Uri.parse(relativeUriString);
        SamePackageDirectImportRule._logger.finer('Parsed import URI: $uri');
        if (uri.scheme.isEmpty) {
          _rule?.logger.finer(
            'URI has empty scheme, treating as relative: $uri',
          );
          break;
        }
        if (uri.scheme != 'package') {
          _rule?.logger.finer('Skipping non-package import: $uri');
          super.visitImportDirective(node);
          return;
        }
        if (uri.pathSegments.isEmpty) {
          _rule?.logger.finer('Skipping import with empty path segments: $uri');
          super.visitImportDirective(node);
          return;
        }
        var source = libraryImport.importedLibrary?.firstFragment.source;
        if (source == null) {
          _rule?.logger.warning('Could not resolve source for import: $uri');
          super.visitImportDirective(node);
          return;
        }
        var package = _package ?? _context?.package;
        if (!(package?.contains(source) ?? false)) {
          _rule?.logger.finer(
            'Import $uri is from a different package, skipping',
          );
          super.visitImportDirective(node);
          return;
        }
    }
    var namespace = libraryImport.namespace;
    var usedElements = <Element>{};
    node.root.accept(_NamespaceElementCollector(namespace, usedElements));
    _rule?.logger.fine(
      'Collected ${usedElements.length} used element(s) for import '
      '${node.uri.toSource()}',
    );
    for (var element in usedElements) {
      if (element.library?.uri case var uri?
          when uri != libraryImport.importedLibrary?.uri) {
        _rule?.logger.fine('Reporting indirect import for uri: $uri');
        _rule?.reportAtNode(node.uri);
        if (_rule != null) {
          break;
        }
        SamePackageDirectImportRule._logger.fine(
          'Recording collected uri: $uri',
        );
        _uris.add(uri);
      }
    }
  }

  /// Collects all URIs of direct imports within the same package found for the
  /// given [importDirective].
  static Set<Uri> uris(
    ImportDirective importDirective,
    WorkspacePackage? package,
  ) {
    SamePackageDirectImportRule._logger.info(
      'Collecting direct import URIs for import: '
      '${importDirective.uri.toSource()}',
    );
    var visitor = SamePackageDirectImportVisitor._(package: package);
    importDirective.accept(visitor);
    SamePackageDirectImportRule._logger.fine(
      'Collected ${visitor._uris.length} uri(s)',
    );
    return visitor._uris;
  }
}

class _NamespaceElementCollector extends RecursiveAstVisitor<void> {
  _NamespaceElementCollector(this.namespace, this.usedElements);

  final Namespace namespace;
  final Set<Element> usedElements;

  @override
  void visitNamedType(NamedType node) {
    var element = node.element;
    if (element != null &&
        namespace.definedNames2[node.name.lexeme] == element) {
      usedElements.add(element);
      SamePackageDirectImportRule._logger.finer(
        'Namespace collector added NamedType element: ${element.displayName}',
      );
    }
    super.visitNamedType(node);
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    var element = node.element;
    if (element != null && namespace.definedNames2[node.name] == element) {
      usedElements.add(element);
      SamePackageDirectImportRule._logger.finer(
        'Namespace collector added SimpleIdentifier element: '
        '${element.displayName}',
      );
    }
    super.visitSimpleIdentifier(node);
  }
}
