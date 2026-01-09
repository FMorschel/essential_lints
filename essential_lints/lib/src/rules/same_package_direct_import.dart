import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/resolver/scope.dart'; // ignore: implementation_imports, not exported
import 'package:analyzer/workspace/workspace.dart';

import 'rule.dart';

/// {@template same_package_direct_import}
/// A lint rule that enforces direct imports within the same package.
/// {@endtemplate}
class SamePackageDirectImportRule extends LintRule {
  /// {@macro same_package_direct_import}
  SamePackageDirectImportRule() : super(.samePackageDirectImport);

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
    // Find all elements exposed by this import.
    var libraryImport = node.libraryImport;
    if (libraryImport == null) {
      super.visitImportDirective(node);
      return;
    }
    // If from a different package, skip.
    switch (libraryImport.uri) {
      case DirectiveUriWithRelativeUriString(:var relativeUriString):
        var uri = Uri.parse(relativeUriString);
        if (uri.scheme.isEmpty) {
          break;
        }
        if (uri.scheme != 'package') {
          super.visitImportDirective(node);
          return;
        }
        if (uri.pathSegments.isEmpty) {
          super.visitImportDirective(node);
          return;
        }
        var source = libraryImport.importedLibrary?.firstFragment.source;
        if (source == null) {
          super.visitImportDirective(node);
          return;
        }
        var package = _package ?? _context?.package;
        if (!(package?.contains(source) ?? false)) {
          super.visitImportDirective(node);
          return;
        }
    }
    var namespace = libraryImport.namespace;
    var usedElements = <Element>{};
    node.root.accept(_NamespaceElementCollector(namespace, usedElements));
    for (var element in usedElements) {
      if (element.library?.uri case var uri?
          when uri != libraryImport.importedLibrary?.uri) {
        _rule?.reportAtNode(node.uri);
        if (_rule != null) {
          break;
        }
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
    var visitor = SamePackageDirectImportVisitor._(package: package);
    importDirective.accept(visitor);
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
    }
    super.visitNamedType(node);
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    var element = node.element;
    if (element != null && namespace.definedNames2[node.name] == element) {
      usedElements.add(element);
    }
    super.visitSimpleIdentifier(node);
  }
}
