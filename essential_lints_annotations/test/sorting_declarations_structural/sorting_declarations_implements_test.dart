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
  });
}
