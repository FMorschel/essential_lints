import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import '../src/current_package_path.dart';

@immutable
final class _Nested implements Comparable<_Nested> {
  const _Nested(this.element, [this.child]);

  final Element element;
  final _Nested? child;

  int get length => 1 + (child?.length ?? 0);

  String get name => element.name ?? 'unknown';

  @override
  String toString() {
    var buffer = StringBuffer()..write('.${element.name!}');
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

  @override
  int compareTo(_Nested other) {
    if (name != other.name) {
      return name.compareTo(other.name);
    }
    if (other.child case var otherChild?) {
      return child?.compareTo(otherChild) ?? 1;
    }
    if (length != other.length) {
      return length.compareTo(other.length);
    }
    return child == null ? 0 : -1;
  }
}

/// Recursively builds all possible combinations by following factory
/// constructors. Returns a set of _Nested objects representing the
/// combinations.
Set<_Nested> _buildAllCombinations(
  Map<String, InterfaceElement> classElements, {
  InterfaceElement? currentElement,
  Set<InterfaceElement> visited = const {},
}) {
  var results = <_Nested>{};

  // Find the starting class or continue from current element
  var elementToExplore = currentElement ?? classElements['SortDeclaration'];
  if (elementToExplore == null) return results;

  // Check if we've already visited this element in the current path
  // (but only if we have a current element - don't block the root)
  if (currentElement != null && visited.contains(elementToExplore)) {
    return results;
  }
  var newVisited = currentElement != null
      ? {...visited, elementToExplore}
      : visited;

  // Explore static fields (terminal nodes) - only for non-root elements
  // All static fields in modifier classes are terminal nodes
  // Skip static fields for Symbol class
  if (currentElement != null && elementToExplore.name != 'Symbol') {
    for (var field in elementToExplore.fields) {
      if (field.isStatic && field.isPublic) {
        var fieldName = field.name;
        if (fieldName == null) continue;

        // This is a terminal node - just the field without wrapping
        var newNested = _Nested(field);
        results.add(newNested);
      }
    }
  }

  // Explore factory constructors (intermediate nodes)
  for (var constructor in elementToExplore.constructors) {
    if (!constructor.isFactory) continue;

    // Get the first parameter's type
    if (constructor.formalParameters.isEmpty) continue;
    var param = constructor.formalParameters.first;
    var paramType = param.type.element;

    if (paramType is! InterfaceElement) continue;

    // Recursively explore this parameter type
    var subResults = _buildAllCombinations(
      classElements,
      currentElement: paramType,
      visited: newVisited,
    );

    // Wrap each sub-result with the current constructor
    // This creates .constructor(.subResult) instead of .subResult.constructor()
    for (var subResult in subResults) {
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
      var args = node.argumentList.arguments;
      if (args.isNotEmpty) {
        var firstArg = args.first;
        // Process the first argument (should be a const expression)
        var visitor = _NestedExpressionVisitor();
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
    var element = node.constructorName.element;
    if (element == null) return null;

    // Visit the first argument to get the child (if any)
    _Nested? child;
    var args = node.argumentList.arguments;
    if (args.isNotEmpty) {
      var childVisitor = _NestedExpressionVisitor();
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
  var allCombinations = <_Nested>{};

  for (var result in testResults) {
    for (var unit in result.units) {
      var visitor = _TestCombinationVisitor();
      unit.unit.visitChildren(visitor);
      allCombinations.addAll(visitor.combinations);
    }
  }

  return allCombinations;
}

Future<void> main() async {
  // Load all the data upfront
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
  var testDirPath = path.normalize(
    path.join(
      currentPackageDir.path,
      'test',
      'sorting_declarations',
    ),
  );

  // Analyze sort_declarations.dart
  var collection = AnalysisContextCollection(
    includedPaths: [sortDeclarationsPath, testDirPath],
  );

  var context = collection.contextFor(sortDeclarationsPath);
  var result = await context.currentSession.getResolvedLibrary(
    sortDeclarationsPath,
  );

  if (result is! ResolvedLibraryResult) {
    throw StateError('Failed to resolve sort_declarations library: $result');
  }
  var sortDeclarationsResult = result;

  // Build class elements map
  var classElements = <String, InterfaceElement>{};
  for (var classElement in sortDeclarationsResult.element.classes) {
    var name = classElement.name;
    if (name != null) {
      classElements[name] = classElement;
    }
  }

  // Generate all possible combinations
  var allCombinations = _buildAllCombinations(classElements);

  // Analyze all test files
  var testResults = <ResolvedLibraryResult>[];

  // List all .dart files in the testDirPath
  var testDir = Directory(testDirPath);
  var testFiles = [
    ...await testDir
        .list()
        .where(
          (entity) => entity is File && entity.path.endsWith('_test.dart'),
        )
        .map((entity) => path.normalize(entity.path))
        .toList(),
  ];

  for (var testFile in testFiles) {
    var testPath = path.join(testDirPath, testFile);
    var testResult = await context.currentSession.getResolvedLibrary(
      testPath,
    );
    if (testResult is ResolvedLibraryResult) {
      testResults.add(testResult);
    }
  }

  // Extract tested combinations
  var testedCombinations = _extractTestedCombinations(testResults);

  // Group untested combinations by top-level element
  var untested = allCombinations.difference(testedCombinations);
  var topLevelGroups = <String>{};
  var untestedGroupedByTopLevel = <String, List<_Nested>>{};

  for (var nested in allCombinations) {
    var topLevelName = nested.name;
    topLevelGroups.add(topLevelName);
  }
  var topLevelNames = topLevelGroups.toList()..sort();

  for (var nested in untested) {
    var topLevelName = nested.name;
    untestedGroupedByTopLevel.putIfAbsent(topLevelName, () => []).add(nested);
  }

  // Now register the tests
  tearDownAll(() async {
    await collection.dispose();
  });

  test('Summary', () {
    print('\n${'=' * 70}');
    print('COMBINATION COVERAGE SUMMARY:');
    print('=' * 70);
    print('Total combinations: ${allCombinations.length}');
    print('Tested combinations: ${testedCombinations.length}');
    print('Untested combinations: ${untested.length}');
    print('=' * 70 + '\n');
    expect(untested, hasLength(0));
  });

  // Create a separate test for each top-level element that has untested combos
  for (var topLevelName in topLevelNames) {
    test('.$topLevelName combinations should be tested', () {
      var combinations =
          (untestedGroupedByTopLevel[topLevelName]?..sort()) ?? const [];

      if (combinations.isNotEmpty) {
        print(
          '\nUntested .$topLevelName combinations '
          '(${combinations.length}):',
        );
        for (var combo in combinations) {
          print('  $combo');
        }
        print('');
      }

      expect(
        combinations,
        isEmpty,
        reason:
            'Found ${combinations.length} untested '
            '.$topLevelName combinations.',
      );
    });
  }
}
