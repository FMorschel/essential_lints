import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import '../src/current_package_path.dart';

/// Visitor that collects all referenced constructor elements in the AST.
class ConstructorReferenceCollector extends RecursiveAstVisitor<void> {
  final Set<ConstructorElement> constructors = {};

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    var element = node.constructorName.element;
    if (element != null) {
      constructors.add(element);
    }
    super.visitInstanceCreationExpression(node);
  }

  @override
  void visitConstructorReference(ConstructorReference node) {
    var element = node.constructorName.element;
    if (element != null) {
      constructors.add(element);
    }
    super.visitConstructorReference(node);
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    var element = node.element;
    if (element is ConstructorElement) {
      constructors.add(element);
    }
    super.visitSimpleIdentifier(node);
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    var element = node.element;
    if (element is ConstructorElement) {
      constructors.add(element);
    }
    super.visitPrefixedIdentifier(node);
  }

  @override
  void visitPropertyAccess(PropertyAccess node) {
    var element = node.propertyName.element;
    if (element is ConstructorElement) {
      constructors.add(element);
    }
    super.visitPropertyAccess(node);
  }

  @override
  void visitSuperConstructorInvocation(SuperConstructorInvocation node) {
    var element = node.element;
    if (element != null) {
      constructors.add(element);
    }
    super.visitSuperConstructorInvocation(node);
  }

  @override
  void visitRedirectingConstructorInvocation(
    RedirectingConstructorInvocation node,
  ) {
    var element = node.element;
    if (element != null) {
      constructors.add(element);
    }
    super.visitRedirectingConstructorInvocation(node);
  }

  @override
  void visitDotShorthandInvocation(DotShorthandInvocation node) {
    var element = node.memberName.element;
    if (element is ConstructorElement) {
      constructors.add(element);
    }
    super.visitDotShorthandInvocation(node);
  }

  @override
  void visitDotShorthandConstructorInvocation(
    DotShorthandConstructorInvocation node,
  ) {
    var element = node.element;
    if (element != null) {
      constructors.add(element);
    }
    super.visitDotShorthandConstructorInvocation(node);
  }
}

void main() {
  late AnalysisContextCollection collection;
  late ResolvedLibraryResult sortDeclarationsResult;
  late Set<ConstructorElement> referencedConstructors;

  setUpAll(() async {
    var currentPackageDir = await essentialLintsAnnotationsPackage();
    var sortDeclarationsPath = path.normalize(
      path.join(
        currentPackageDir.path,
        'lib',
        'src',
        'sorting_members',
        'sort_declarations.dart',
      ),
    );

    var testFilePath = path.normalize(
      path.join(
        currentPackageDir.path,
        'test',
        'sorting_declarations_test.dart',
      ),
    );

    collection = AnalysisContextCollection(
      includedPaths: [sortDeclarationsPath, testFilePath],
    );

    // Resolve the sort_declarations.dart library
    var context = collection.contextFor(sortDeclarationsPath);
    var result = await context.currentSession.getResolvedLibrary(
      sortDeclarationsPath,
    );

    if (result is! ResolvedLibraryResult) {
      throw StateError('Failed to resolve sort_declarations library: $result');
    }
    sortDeclarationsResult = result;

    // Collect constructor references from both the library and the test file
    var collector = ConstructorReferenceCollector();

    // Collect from the library itself (for tearoffs like `.new`)
    for (var unit in sortDeclarationsResult.units) {
      unit.unit.visitChildren(collector);
    }

    // Parse the test file and collect all constructor references
    var testContext = collection.contextFor(testFilePath);
    var testResult = await testContext.currentSession.getResolvedUnit(
      testFilePath,
    );

    if (testResult is! ResolvedUnitResult) {
      throw StateError('Failed to resolve test file: $testResult');
    }

    testResult.unit.visitChildren(collector);
    referencedConstructors = collector.constructors;
  });

  tearDownAll(() async {
    await collection.dispose();
  });

  group('Code quality checks', () {
    test('All static fields should be const', () {
      var classElements = sortDeclarationsResult.element.classes;

      expect(classElements, isNotEmpty, reason: 'No classes found in library');

      var nonConstStaticFields = <String>[];

      for (var classElement in classElements) {
        for (var field in classElement.fields) {
          if (field.isStatic && !field.isSynthetic && !field.isConst) {
            nonConstStaticFields.add(
              '${classElement.displayName}.${field.displayName}',
            );
          }
        }
      }

      expect(
        nonConstStaticFields,
        isEmpty,
        reason:
            'The following static fields are not const:\n'
            '  - ${nonConstStaticFields.join('\n  - ')}',
      );
    });

    test('All constructors should be const', () {
      var classElements = sortDeclarationsResult.element.classes;

      expect(classElements, isNotEmpty, reason: 'No classes found in library');

      var nonConstConstructors = <String>[];

      for (var classElement in classElements) {
        for (var constructor in classElement.constructors) {
          if (!constructor.isSynthetic && !constructor.isConst) {
            var name = constructor.name;
            var constructorName = name == null || name.isEmpty
                ? '${classElement.displayName}()'
                : '${classElement.displayName}.$name()';
            nonConstConstructors.add(constructorName);
          }
        }
      }

      expect(
        nonConstConstructors,
        isEmpty,
        reason:
            'The following constructors are not const:\n'
            '  - ${nonConstConstructors.join('\n  - ')}',
      );
    });

    test('All constructors should be referenced', () {
      var classElements = sortDeclarationsResult.element.classes;

      expect(classElements, isNotEmpty, reason: 'No classes found in library');

      // Collect classes that are extended by other classes
      // If a class is extended, its constructor is implicitly used
      var extendedClasses = <InterfaceElement>{};
      for (var classElement in classElements) {
        var supertype = classElement.supertype;
        if (supertype != null) {
          extendedClasses.add(supertype.element);
        }
      }

      // Helper to check if a class is or extends/implements Modifiable or is SortDeclaration
      bool isModifiableOrSortDeclaration(InterfaceElement element) {
        if (element.name == 'SortDeclaration') return true;
        for (var t in element.allSupertypes) {
          if (t.element.name == '_Modifiable') {
            return true;
          }
        }
        return false;
      }

      var unreferencedConstructors = <String>[];

      for (var classElement in classElements) {
        // If this class is extended, its constructors are considered used
        if (extendedClasses.contains(classElement)) continue;

        // Ignore modifiable and base classes using the type system
        if (isModifiableOrSortDeclaration(classElement)) continue;

        for (var constructor in classElement.constructors) {
          if (!constructor.isSynthetic && constructor.isPublic) {
            var isReferenced = referencedConstructors.contains(constructor);
            if (!isReferenced) {
              var name = constructor.name;
              var constructorName = name == null || name.isEmpty
                  ? '${classElement.displayName}()'
                  : '${classElement.displayName}.$name()';
              unreferencedConstructors.add(constructorName);
            }
          }
        }
      }

      expect(
        unreferencedConstructors,
        isEmpty,
        reason:
            'The following constructors are not referenced in '
            'sorting_declarations_test.dart:\n'
            '  - ${unreferencedConstructors.join('\n  - ')}',
      );
    });
  });
}
