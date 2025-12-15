// ignore_for_file: avoid_print displaying information

import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import 'src/current_package_path.dart';

@immutable
final class _Nested {
  const _Nested(this.element, [this.child]);

  final Element element;
  final _Nested? child;

  @override
  String toString() {
    final buffer = StringBuffer()..write('.${element.name!}');
    if (element is ConstructorElement) {
      buffer.write('(');
    }
    if (child != null) {
      buffer.write(child);
    }
    if (element is ConstructorElement) {
      buffer.write(')');
    }
    return buffer.toString();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Nested &&
          runtimeType == other.runtimeType &&
          element == other.element &&
          child == other.child;

  @override
  int get hashCode => Object.hash(
    element.name,
    element.runtimeType,
    element.enclosingElement?.name,
    child,
  );
}

/// Recursively builds all possible combinations by following factory
/// constructors. Returns a set of _Nested objects representing the
/// combinations.
Set<_Nested> _buildAllCombinations(
  Map<String, InterfaceElement> classElements, {
  InterfaceElement? currentElement,
  Set<InterfaceElement> visited = const {},
}) {
  final results = <_Nested>{};

  // Find the starting class or continue from current element
  final elementToExplore = currentElement ?? classElements['SortDeclaration'];
  if (elementToExplore == null) return results;

  // Check if we've already visited this element in the current path
  // (but only if we have a current element - don't block the root)
  if (currentElement != null && visited.contains(elementToExplore)) {
    return results;
  }
  final newVisited = currentElement != null
      ? {...visited, elementToExplore}
      : visited;

  // Explore static fields (terminal nodes) - only for non-root elements
  // All static fields in modifier classes are terminal nodes
  // Skip static fields for Symbol class
  if (currentElement != null && elementToExplore.name != 'Symbol') {
    for (final field in elementToExplore.fields) {
      if (field.isStatic && field.isPublic) {
        final fieldName = field.name;
        if (fieldName == null) continue;

        // This is a terminal node - just the field without wrapping
        final newNested = _Nested(field);
        results.add(newNested);
      }
    }
  }

  // Explore factory constructors (intermediate nodes)
  for (final constructor in elementToExplore.constructors) {
    if (!constructor.isFactory) continue;

    // Get the first parameter's type
    if (constructor.formalParameters.isEmpty) continue;
    final param = constructor.formalParameters.first;
    final paramType = param.type.element;

    if (paramType is! InterfaceElement) continue;

    // Recursively explore this parameter type
    final subResults = _buildAllCombinations(
      classElements,
      currentElement: paramType,
      visited: newVisited,
    );

    // Wrap each sub-result with the current constructor
    // This creates .constructor(.subResult) instead of .subResult.constructor()
    for (final subResult in subResults) {
      results.add(_Nested(constructor.baseElement, subResult));
    }
  }

  return results;
}

/// Visitor that extracts _Nested structures from test method calls.
class _TestCombinationVisitor extends RecursiveAstVisitor<void> {
  final Set<_Nested> combinations = {};

  @override
  void visitMethodInvocation(MethodInvocation node) {
    // Look for calls to expectSortDeclaration
    if (node.methodName.name == 'expectSortDeclaration') {
      final args = node.argumentList.arguments;
      if (args.isNotEmpty) {
        final firstArg = args.first;
        // Process the first argument (should be a const expression)
        final visitor = _NestedExpressionVisitor();
        firstArg.accept(visitor);
        if (visitor.result != null) {
          combinations.add(visitor.result!);
        }
      }
    }
    super.visitMethodInvocation(node);
  }
}

/// Visitor that builds a _Nested structure from an expression.
class _NestedExpressionVisitor extends SimpleAstVisitor<_Nested?> {
  _Nested? result;

  @override
  _Nested? visitDotShorthandPropertyAccess(DotShorthandPropertyAccess node) {
    var element = node.propertyName.element;
    if (element == null) return null;

    // If this is a getter for a static field, get the field itself
    if (element is PropertyAccessorElement) {
      element = element.variable;
    }

    return result = _Nested(element);
  }

  @override
  _Nested? visitDotShorthandConstructorInvocation(
    DotShorthandConstructorInvocation node,
  ) {
    final element = node.constructorName.element;
    if (element == null) return null;

    // Visit the first argument to get the child (if any)
    _Nested? child;
    final args = node.argumentList.arguments;
    if (args.isNotEmpty) {
      final childVisitor = _NestedExpressionVisitor();
      args.first.accept(childVisitor);
      child = childVisitor.result;
    }

    // The current node is the parent, so wrap the child (if any)
    var current = _Nested(element, child);
    return result = current;
  }
}

/// Extracts all tested combinations from test files by analyzing the AST.
Set<_Nested> _extractTestedCombinations(
  List<ResolvedLibraryResult> testResults,
) {
  final allCombinations = <_Nested>{};

  for (final result in testResults) {
    for (final unit in result.units) {
      final visitor = _TestCombinationVisitor();
      unit.unit.visitChildren(visitor);
      allCombinations.addAll(visitor.combinations);
    }
  }

  return allCombinations;
}

void main() {
  late AnalysisContextCollection collection;
  late ResolvedLibraryResult sortDeclarationsResult;
  late List<ResolvedLibraryResult> testResults;
  late Set<_Nested> allCombinations;
  late Set<_Nested> testedCombinations;

  setUpAll(() async {
    final currentPackageDir = await currentPackage();
    final sortDeclarationsPath = path.normalize(
      path.join(
        currentPackageDir.path,
        'lib',
        'src',
        'sorting_members',
        'sort_declarations.dart',
      ),
    );
    final testDirPath = path.normalize(
      path.join(
        currentPackageDir.path,
        'test',
        'sorting_declarations',
      ),
    );

    // Analyze sort_declarations.dart
    collection = AnalysisContextCollection(
      includedPaths: [sortDeclarationsPath, testDirPath],
    );

    final context = collection.contextFor(sortDeclarationsPath);
    final result = await context.currentSession.getResolvedLibrary(
      sortDeclarationsPath,
    );

    if (result is! ResolvedLibraryResult) {
      throw StateError('Failed to resolve sort_declarations library: $result');
    }
    sortDeclarationsResult = result;

    // Build class elements map
    final classElements = <String, InterfaceElement>{};
    for (final classElement in sortDeclarationsResult.element.classes) {
      final name = classElement.name;
      if (name != null) {
        classElements[name] = classElement;
      }
    }

    // Generate all possible combinations
    allCombinations = _buildAllCombinations(classElements);

    // Analyze all test files
    testResults = [];

    // List all .dart files in the testDirPath
    final testDir = Directory(testDirPath);
    final testFiles = [
      ...await testDir
          .list()
          .where(
            (entity) => entity is File && entity.path.endsWith('_test.dart'),
          )
          .map((entity) => path.normalize(entity.path))
          .toList(),
    ];

    for (final testFile in testFiles) {
      final testPath = path.join(testDirPath, testFile);
      final testResult = await context.currentSession.getResolvedLibrary(
        testPath,
      );
      if (testResult is ResolvedLibraryResult) {
        testResults.add(testResult);
      }
    }

    // Extract tested combinations
    testedCombinations = _extractTestedCombinations(testResults);
  });

  tearDownAll(() async {
    await collection.dispose();
  });

  group('Comprehensive combination coverage', () {
    test('All possible combinations should be tested', () {
      // Find untested combinations
      final untested = allCombinations.difference(testedCombinations);

      if (untested.isNotEmpty) {
        print('\n${'=' * 70}');
        print('UNTESTED COMBINATIONS (${untested.length}):');
        print('=' * 70);
        final sorted = untested.map((n) => n.toString()).toList()..sort();
        for (final combo in sorted) {
          print('  $combo');
        }
        print('=' * 70);
        print('\nTotal combinations: ${allCombinations.length}');
        print('Tested combinations: ${testedCombinations.length}');
        print('Untested combinations: ${untested.length}');
        print('=' * 70 + '\n');
      }

      // Fail if there are untested combinations
      expect(
        untested,
        isEmpty,
        reason:
            'Found ${untested.length} untested combinations. '
            'See output above for details.',
      );
    });
  });
}
