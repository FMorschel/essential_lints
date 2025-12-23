import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import '../src/current_package_path.dart';

/// Represents a static member (field, getter, or method) of a class.
class StaticMember {
  StaticMember(this.element, [this.relatedElements = const []]);

  /// The main element (field, getter, setter, method or constructor).
  final Element element;

  /// Related elements to check for references (e.g., a field's getter or
  /// setter).
  final List<Element> relatedElements;

  String get displayName => element is ConstructorElement
      ? element.name ?? ''
      : element.displayName + (element is SetterElement ? '=' : '');

  @override
  String toString() => displayName;
}

/// Gets all static members (fields, getters, methods) from a class element.
List<StaticMember> getStaticMembers(InterfaceElement element) {
  if (element.isPrivate) {
    return [];
  }

  var members = <StaticMember>[];
  var fieldGetters = <Element>{};

  // Collect static fields and track their getters/setters
  for (var field in element.fields) {
    if (field.isStatic && !field.isSynthetic && field.isPublic) {
      members.add(StaticMember(field, [?field.getter, ?field.setter]));
      if (field.getter != null) {
        fieldGetters.add(field.getter!);
      }
    }
  }

  // Collect static getters (that are not synthetic, i.e., not from fields)
  for (var getter in element.getters) {
    if (getter.isStatic &&
        !getter.isSynthetic &&
        !fieldGetters.contains(getter) &&
        getter.isPublic) {
      members.add(StaticMember(getter));
    }
  }

  // Collect static setters (that are not synthetic, i.e., not from fields)
  for (var setter in element.setters) {
    if (setter.isStatic &&
        !setter.isSynthetic &&
        !fieldGetters.contains(setter) &&
        setter.isPublic) {
      members.add(StaticMember(setter));
    }
  }

  // Collect static methods
  for (var method in element.methods) {
    if (method.isStatic && method.isPublic) {
      members.add(StaticMember(method));
    }
  }

  for (var constructor in element.constructors) {
    if (constructor.isPublic) {
      members.add(StaticMember(constructor));
    }
  }

  return members;
}

/// Visitor that collects all referenced elements in an AST.
class ElementCollector extends RecursiveAstVisitor<void> {
  final Set<Element> elements = {};

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    var element = node.element;
    if (element != null) {
      elements.add(element);
    }
    super.visitSimpleIdentifier(node);
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    var element = node.element;
    if (element != null) {
      elements.add(element);
    }
    super.visitPrefixedIdentifier(node);
  }

  @override
  void visitPropertyAccess(PropertyAccess node) {
    var element = node.propertyName.element;
    if (element != null) {
      elements.add(element);
    }
    super.visitPropertyAccess(node);
  }
}

/// Expands a set of elements to include all elements they reference.
///
/// This is used to find indirect usage - if element A is tested and A
/// references element B in its initialization, then B is also considered
/// tested.
Set<Element> expandWithReferences(
  Set<Element> directElements,
  ResolvedLibraryResult sortDeclarationsResult,
) {
  var expanded = <Element>{...directElements};
  var toProcess = [...directElements];
  var processed = <Element>{};

  while (toProcess.isNotEmpty) {
    var element = toProcess.removeLast();
    if (processed.contains(element)) continue;
    processed.add(element);

    // Find the AST node for this element in sort_declarations.dart
    for (var unit in sortDeclarationsResult.units) {
      var collector = ElementCollector();

      // Check if this element is defined in this compilation unit
      var elementLibrary = element.library;
      if (elementLibrary == null || elementLibrary != unit.libraryElement) {
        continue;
      }

      // Visit the unit to collect all referenced elements
      unit.unit.accept(collector);

      for (var referenced in collector.elements) {
        if (!expanded.contains(referenced)) {
          expanded.add(referenced);
          toProcess.add(referenced);
        }
      }
    }
  }

  return expanded;
}

void main() {
  late AnalysisContextCollection collection;
  late ResolvedLibraryResult sortDeclarationsResult;
  late Set<Element> allTestFileElements;
  late Set<Element> directlyTestedElements;

  setUpAll(() async {
    var packageDirectory = await essentialLintsAnnotationsPackage();
    var sortDeclarationsPath = path.normalize(
      path.join(
        packageDirectory.path,
        'lib',
        'src',
        'sorting_members',
        'sort_declarations.dart',
      ),
    );

    // Find all test files in the sorting_declarations folder
    var testDirPath = path.normalize(
      path.join(
        (await packageDir(
          'package:_essential_lints_annotations_test/placehoder.dart',
        )).path,
        'test',
        'sorting_declarations',
      ),
    );

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

    collection = AnalysisContextCollection(
      includedPaths: [sortDeclarationsPath, ...testFiles],
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

    // Parse all test files and collect all elements used
    directlyTestedElements = {};
    for (var testFilePath in testFiles) {
      var testResult = await context.currentSession.getResolvedLibrary(
        testFilePath,
      );

      if (testResult is! ResolvedLibraryResult) {
        throw StateError('Failed to resolve test file: $testResult');
      }

      var collector = ElementCollector();
      for (var unit in testResult.units) {
        unit.unit.accept(collector);
      }
      directlyTestedElements.addAll(collector.elements);
    }

    // Expand test elements to include indirect references for backwards
    // compatibility
    allTestFileElements = expandWithReferences(
      directlyTestedElements,
      sortDeclarationsResult,
    );
  });

  tearDownAll(() async {
    await collection.dispose();
  });

  group('All static members are tested', () {
    test('All classes have their static members tested', () {
      var classElements = sortDeclarationsResult.element.classes;

      expect(classElements, isNotEmpty, reason: 'No classes found in library');

      var missingMembers = <String>[];

      for (var classElement in classElements) {
        // Ignore static members under the Group class
        if (classElement.displayName == 'Group') {
          continue;
        }
        var staticMembers = getStaticMembers(classElement);

        for (var member in staticMembers) {
          var isCovered = [
            member.element,
            ...member.relatedElements,
          ].any(allTestFileElements.contains);

          if (!isCovered) {
            missingMembers.add(
              '${classElement.displayName}.${member.displayName}',
            );
          }
        }
      }

      expect(
        missingMembers,
        isEmpty,
        reason:
            'The following ${missingMembers.length} static members are not '
            'tested in any sorting_declarations/*.dart test file:\n'
            '  - ${missingMembers.join('\n  - ')}',
      );
    });
  });
}
