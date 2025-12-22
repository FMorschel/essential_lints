import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import '../src/current_package_path.dart';

void main() {
  late AnalysisContextCollection collection;
  late ResolvedLibraryResult sortDeclarationsResult;

  setUpAll(() async {
    var currentPackageDir = await currentPackage();
    final sortDeclarationsPath = path.normalize(
      path.join(
        currentPackageDir.path,
        'lib',
        'src',
        'sorting_members',
        'sort_declarations.dart',
      ),
    );

    collection = AnalysisContextCollection(
      includedPaths: [sortDeclarationsPath],
    );

    // Resolve the sort_declarations.dart library
    final context = collection.contextFor(sortDeclarationsPath);
    final result = await context.currentSession.getResolvedLibrary(
      sortDeclarationsPath,
    );

    if (result is! ResolvedLibraryResult) {
      throw StateError('Failed to resolve sort_declarations library: $result');
    }
    sortDeclarationsResult = result;
  });

  tearDownAll(() async {
    await collection.dispose();
  });

  group('Code quality checks', () {
    test('All implements should have corresponding factory redirects', () {
      final classElements = sortDeclarationsResult.element.classes;

      expect(classElements, isNotEmpty, reason: 'No classes found in library');

      final rogueImplements = <String>[];

      for (final classElement in classElements) {
        // Only check classes that extend Modifier
        final extendsModifier = classElement.allSupertypes.any(
          (type) => type.element.name == 'Modifier',
        );

        if (!extendsModifier) continue;

        // Get all interfaces this class implements
        for (final interface in classElement.interfaces) {
          final implementedElement = interface.element;

          // Check if the implemented interface has a factory constructor
          // that redirects to this class
          var hasFactoryRedirect = false;

          for (final constructor in implementedElement.constructors) {
            if (constructor.isFactory) {
              final redirectedElement = constructor.redirectedConstructor;
              if (redirectedElement != null) {
                final redirectedClass = redirectedElement.enclosingElement;
                // Check if it redirects to our implementing class
                if (redirectedClass == classElement) {
                  hasFactoryRedirect = true;
                  break;
                }
              }
            }
          }

          if (!hasFactoryRedirect) {
            rogueImplements.add(
              '`${classElement.displayName}` implements '
              '`${implementedElement.displayName}`',
            );
          }
        }
      }

      expect(
        rogueImplements,
        isEmpty,
        reason:
            'The following classes implement interfaces without '
            'factory redirects:\n  - ${rogueImplements.join('\n  - ')}',
      );
    });

    test('All public classes should have at least one public member', () {
      final classElements = sortDeclarationsResult.element.classes;

      expect(classElements, isNotEmpty, reason: 'No classes found in library');

      final classesWithoutPublicMembers = <String>[];

      for (final classElement in classElements) {
        // Skip classes that extend Group
        final extendsGroup = classElement.allSupertypes.any(
          (type) => type.element.name == 'Group',
        );
        if (extendsGroup || classElement.name == 'Group') continue;

        // Only check public classes
        if (!classElement.isPublic) continue;

        // Check if the class has at least one public member
        final hasPublicConstructor = classElement.constructors.any(
          (constructor) => constructor.isPublic,
        );
        final hasPublicField = classElement.fields.any(
          (field) => field.isPublic,
        );
        final hasPublicMethod = classElement.methods.any(
          (method) => method.isPublic,
        );

        if (!hasPublicConstructor && !hasPublicField && !hasPublicMethod) {
          classesWithoutPublicMembers.add(classElement.displayName);
        }
      }

      expect(
        classesWithoutPublicMembers,
        isEmpty,
        reason:
            'The following public classes have no public members:\n  - '
            '${classesWithoutPublicMembers.join('\n  - ')}',
      );
    });

    test(
      'All public classes (except Group and SortDeclaration) should be used '
      'as factory constructor parameters',
      () {
        final classElements = sortDeclarationsResult.element.classes;

        expect(
          classElements,
          isNotEmpty,
          reason: 'No classes found in library',
        );

        // Collect all public classes except Group and SortDeclaration
        final publicClasses = classElements.where((c) => c.isPublic).toSet();

        // Collect all types used as factory constructor parameters
        final typesUsedInFactories = <String>{};

        for (final classElement in classElements) {
          for (final constructor in classElement.constructors) {
            if (constructor.isFactory) {
              for (final parameter in constructor.formalParameters) {
                final paramType = parameter.type;
                final paramTypeName = paramType.element?.name;
                if (paramTypeName != null) {
                  typesUsedInFactories.add(paramTypeName);
                }
              }
            }
          }
        }

        // Find classes not used in factory constructors
        final unusedClasses = <String>[];

        for (final classElement in publicClasses) {
          final className = classElement.name;
          if (className == null) continue;

          // Skip Group classes and SortDeclaration
          if (className == 'SortDeclaration') continue;

          // Skip classes that extend Group
          final extendsGroup = classElement.allSupertypes.any(
            (type) => type.element.name == 'Group',
          );
          if (extendsGroup || className == 'Group') continue;

          if (className == 'Modifier') continue;

          if (!typesUsedInFactories.contains(className)) {
            unusedClasses.add(className);
          }
        }

        expect(
          unusedClasses,
          isEmpty,
          reason:
              'The following public classes are not used as factory '
              'constructor parameters:\n  - ${unusedClasses.join('\n  - ')}',
        );
      },
    );
  });
}
