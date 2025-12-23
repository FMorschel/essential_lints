import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import '../src/current_package_path.dart';

void main() {
  late AnalysisContextCollection collection;
  late ResolvedLibraryResult sortDeclarationsResult;

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

    collection = AnalysisContextCollection(
      includedPaths: [sortDeclarationsPath],
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
  });

  tearDownAll(() async {
    await collection.dispose();
  });

  group('Mutually exclusive modifiers', () {
    test(
      'Where the constructors are redirected all from the same group exist',
      () {
        var classElements = sortDeclarationsResult.element.classes;

        expect(
          classElements,
          isNotEmpty,
          reason: 'No classes found in library',
        );

        // Build a map of mutually exclusive groups
        var mutuallyExclusiveGroups = <String, Set<InterfaceElement>>{};
        var optionalMembers = <String, Set<InterfaceElement>>{};

        for (var classElement in classElements) {
          for (var metadata in classElement.metadata.annotations) {
            var element = metadata.element;
            if (element is! ConstructorElement) continue;

            var enclosingElement = element.enclosingElement;
            if (enclosingElement.name != 'MutuallyExclusive') continue;

            var constantValue = metadata.computeConstantValue();
            if (constantValue == null) continue;

            var idField = constantValue.getField('id');
            if (idField == null) continue;

            var symbolValue = idField.toSymbolValue();
            if (symbolValue == null) continue;

            mutuallyExclusiveGroups
                .putIfAbsent(symbolValue, () => {})
                .add(classElement);

            // Check if this member is optional
            var optionalField = constantValue.getField('optional');
            var isOptional = optionalField?.toBoolValue() ?? false;
            if (isOptional) {
              optionalMembers
                  .putIfAbsent(symbolValue, () => {})
                  .add(classElement);
            }

            break;
          }
        }

        // For each class, collect all classes it redirects to via constructors
        var violations = <String>[];

        for (var classElement in classElements) {
          // Map of redirect targets by their mutually exclusive group
          var redirectsByGroup = <String, Set<InterfaceElement>>{};

          for (var constructor in classElement.constructors) {
            var redirectedConstructor = constructor.redirectedConstructor;
            if (redirectedConstructor == null) continue;

            var redirectedClass = redirectedConstructor.enclosingElement;

            // Check if redirected class is part of a mutually exclusive group
            for (var entry in mutuallyExclusiveGroups.entries) {
              var groupId = entry.key;
              var groupMembers = entry.value;

              if (groupMembers.contains(redirectedClass)) {
                redirectsByGroup
                    .putIfAbsent(groupId, () => {})
                    .add(redirectedClass);
                break;
              }
            }
          }

          // For each group that has redirects, verify all members are
          // redirected to
          for (var entry in redirectsByGroup.entries) {
            var groupId = entry.key;
            var redirectedMembers = entry.value;
            var allGroupMembers = mutuallyExclusiveGroups[groupId]!;
            var optionalInGroup = optionalMembers[groupId] ?? {};

            if (redirectedMembers.length < allGroupMembers.length) {
              var redirectedNames = redirectedMembers
                  .map((e) => e.name)
                  .toSet();

              // Get required members (all non-optional members)
              var requiredMembers = allGroupMembers.difference(
                optionalInGroup,
              );
              var requiredNames = requiredMembers.map((e) => e.name).toSet();

              // Check if any optional member is present
              var hasOptional = redirectedMembers.any(
                optionalInGroup.contains,
              );

              if (hasOptional) {
                // If optional member(s) are present, all required members
                // must also be present
                var missingRequired = requiredNames.difference(
                  redirectedNames,
                );

                if (missingRequired.isNotEmpty) {
                  var optionalNames = optionalInGroup
                      .map((e) => e.name)
                      .toSet();
                  var presentOptional = redirectedNames.intersection(
                    optionalNames,
                  );

                  violations.add(
                    '${classElement.name} has optional member(s) but is '
                    'missing required members in #$groupId group:\n'
                    '  - Has redirects to: ${redirectedNames.join(', ')}\n'
                    '  - Optional present: ${presentOptional.join(', ')}\n'
                    '  - Missing required: ${missingRequired.join(', ')}',
                  );
                }
              } else {
                // No optional members present
                // Check if all present members are required
                var missingRequired = requiredNames.difference(
                  redirectedNames,
                );

                if (missingRequired.isNotEmpty) {
                  // Some required members are missing
                  violations.add(
                    '${classElement.name} has redirecting constructors to '
                    'partial mutually exclusive group #$groupId:\n'
                    '  - Has redirects to: ${redirectedNames.join(', ')}\n'
                    '  - Missing required: ${missingRequired.join(', ')}',
                  );
                }
              }
            }
          }
        }

        expect(
          violations,
          isEmpty,
          reason:
              'Found ${violations.length} classes with incomplete redirecting '
              'constructors:\n\n${violations.join('\n\n')}',
        );
      },
    );

    test('All mutually exclusive group members are Modifiers', () {
      var classElements = sortDeclarationsResult.element.classes;

      expect(classElements, isNotEmpty, reason: 'No classes found in library');

      var nonModifierClasses = <String>[];

      for (var classElement in classElements) {
        // Check if this class has @MutuallyExclusive annotation
        var hasMutuallyExclusive = false;
        for (var metadata in classElement.metadata.annotations) {
          var element = metadata.element;
          if (element is! ConstructorElement) continue;

          var enclosingElement = element.enclosingElement;
          if (enclosingElement.name == 'MutuallyExclusive') {
            hasMutuallyExclusive = true;
            break;
          }
        }

        if (!hasMutuallyExclusive) continue;

        // Check if this class extends Modifier
        var extendsModifier = classElement.allSupertypes.any(
          (type) => type.element.name == 'Modifier',
        );

        if (!extendsModifier) {
          var className = classElement.name;
          if (className != null) {
            nonModifierClasses.add(className);
          }
        }
      }

      expect(
        nonModifierClasses,
        isEmpty,
        reason:
            'Classes with @MutuallyExclusive must extend Modifier:\n'
            '  - ${nonModifierClasses.join('\n  - ')}',
      );
    });

    test('No mutually exclusive group should contain a single member', () {
      var classElements = sortDeclarationsResult.element.classes;

      expect(classElements, isNotEmpty, reason: 'No classes found in library');

      // Build a map of mutually exclusive groups
      var mutuallyExclusiveGroups = <String, Set<String>>{};

      for (var classElement in classElements) {
        for (var metadata in classElement.metadata.annotations) {
          var element = metadata.element;
          if (element is! ConstructorElement) continue;

          var enclosingElement = element.enclosingElement;
          if (enclosingElement.name != 'MutuallyExclusive') continue;

          var constantValue = metadata.computeConstantValue();
          if (constantValue == null) continue;

          var idField = constantValue.getField('id');
          if (idField == null) continue;

          var symbolValue = idField.toSymbolValue();
          if (symbolValue == null) continue;

          var className = classElement.name;
          if (className != null) {
            mutuallyExclusiveGroups
                .putIfAbsent(symbolValue, () => {})
                .add(className);
          }

          break;
        }
      }

      // Find groups with only one member
      var singleMemberGroups = <String>[];

      for (var entry in mutuallyExclusiveGroups.entries) {
        var groupId = entry.key;
        var members = entry.value;

        if (members.length == 1) {
          singleMemberGroups.add(
            '#$groupId has only 1 member: ${members.first}',
          );
        }
      }

      expect(
        singleMemberGroups,
        isEmpty,
        reason:
            'Mutually exclusive groups must have at least 2 members:\n'
            '  - ${singleMemberGroups.join('\n  - ')}',
      );
    });
  });
}
