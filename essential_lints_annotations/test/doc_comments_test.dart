import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:test/test.dart';

void main() {
  test('all exposed declarations have non-empty doc comments', () async {
    final packageRoot = _findPackageRoot();
    final libPath = '$packageRoot${Platform.pathSeparator}lib';
    final mainLibraryPath =
        '$libPath${Platform.pathSeparator}essential_lints_annotations.dart';

    final collection = AnalysisContextCollection(
      includedPaths: [libPath],
      resourceProvider: PhysicalResourceProvider.INSTANCE,
    );

    final context = collection.contextFor(mainLibraryPath);

    // Get the main library to find all exported declarations
    final mainResult = await context.currentSession.getResolvedLibrary(
      mainLibraryPath,
    );
    if (mainResult is! ResolvedLibraryResult) {
      fail('Failed to resolve main library');
    }

    // Get all exported element names
    final exportedNames = mainResult.element.exportNamespace.definedNames2;

    final missingDocComments = <Element>[];

    // Check each exported element and its members for doc comments
    for (final entry in exportedNames.entries) {
      final element = entry.value;

      // Check the element itself
      _checkElementDocumentation(element, context, missingDocComments);

      // Check members of the element if it's a container
      _checkMembersRecursively(element, context, missingDocComments);
    }

    expect(
      missingDocComments,
      isEmpty,
      reason:
          'The following exposed declarations are missing non-empty '
          'doc comments:\n'
          '${missingDocComments.map(
            (e) => _elementDisplay(e, context),
          ).join('\n')}',
    );
  });
}

String _elementDisplay(Element element, AnalysisContext context) {
  final library = element.library;
  final uri = library?.uri;
  final location = uri != null
      ? (context.currentSession.uriConverter.uriToPath(uri) ?? uri.toString())
      : 'unknown';
  final name = element.name;
  return '$name (in $location)';
}

/// Checks if an element has proper documentation.
void _checkElementDocumentation(
  Element element,
  AnalysisContext context,
  List<Element> missingDocComments,
) {
  // Skip private elements
  if (element.isPrivate ||
      element is ConstructorElement &&
          element.isGenerative &&
          element.enclosingElement is EnumElement) {
    return;
  }

  final docComment = element.documentationComment;

  // Check if doc comment is missing or empty when trimmed
  if (docComment == null || docComment.trim().isEmpty) {
    missingDocComments.add(element);
  }
}

/// Recursively checks all public members of an element.
void _checkMembersRecursively(
  Element element,
  AnalysisContext context,
  List<Element> missingDocComments,
) {
  // Check class and mixin members
  if (element is InterfaceElement) {
    // Fields (includes getters/setters)
    for (final field in element.fields) {
      if (field.isPublic && !field.isSynthetic) {
        _checkElementDocumentation(field, context, missingDocComments);
      }
    }

    // Methods
    for (final method in element.methods) {
      if (method.isPublic) {
        _checkElementDocumentation(method, context, missingDocComments);
      }
    }

    // Constructors
    for (final constructor in element.constructors) {
      if (constructor.isPublic) {
        _checkElementDocumentation(constructor, context, missingDocComments);
      }
    }
  }
}

/// Finds the package root directory by looking for pubspec.yaml.
String _findPackageRoot() {
  var current = Directory.current;

  // If we're running from the test directory, go up
  while (!File(
        '${current.path}${Platform.pathSeparator}pubspec.yaml',
      ).existsSync() ||
      !current.path.endsWith('essential_lints_annotations')) {
    final parent = current.parent;
    if (parent.path == current.path) {
      // Reached filesystem root
      throw StateError(
        'Could not find essential_lints_annotations package root',
      );
    }
    current = parent;
  }

  // Check if we're in the annotations package
  if (current.path.endsWith('essential_lints_annotations')) {
    return current.path;
  }

  // Try to find it as a subdirectory
  final annotationsDir = Directory(
    '${current.path}${Platform.pathSeparator}essential_lints_annotations',
  );
  if (annotationsDir.existsSync()) {
    return annotationsDir.path;
  }

  throw StateError('Could not find essential_lints_annotations package root');
}
