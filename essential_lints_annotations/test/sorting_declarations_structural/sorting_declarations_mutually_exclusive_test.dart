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

  group('Mutually exclusive modifiers', () {
    test(
      'Where the constructors are redirected all from the same group exist',
      () {
        final classElements = sortDeclarationsResult.element.classes;

        expect(
          classElements,
          isNotEmpty,
          reason: 'No classes found in library',
        );

        // Build a map of mutually exclusive groups
        final mutuallyExclusiveGroups = <String, Set<InterfaceElement>>{};
        final optionalMembers = <String, Set<InterfaceElement>>{};

        for (final classElement in classElements) {
          for (final metadata in classElement.metadata.annotations) {
            final element = metadata.element;
            if (element is! ConstructorElement) continue;

            final enclosingElement = element.enclosingElement;
            if (enclosingElement.name != 'MutuallyExclusive') continue;

            final constantValue = metadata.computeConstantValue();
            if (constantValue == null) continue;

            final idField = constantValue.getField('id');
            if (idField == null) continue;

            final symbolValue = idField.toSymbolValue();
            if (symbolValue == null) continue;

            mutuallyExclusiveGroups
                .putIfAbsent(symbolValue, () => {})
                .add(classElement);

            // Check if this member is optional
            final optionalField = constantValue.getField('optional');
            final isOptional = optionalField?.toBoolValue() ?? false;
            if (isOptional) {
              optionalMembers
                  .putIfAbsent(symbolValue, () => {})
                  .add(classElement);
            }

            break;
          }
        }

        // For each class, collect all classes it redirects to via constructors
        final violations = <String>[];

        for (final classElement in classElements) {
          // Map of redirect targets by their mutually exclusive group
          final redirectsByGroup = <String, Set<InterfaceElement>>{};

          for (final constructor in classElement.constructors) {
            final redirectedConstructor = constructor.redirectedConstructor;
            if (redirectedConstructor == null) continue;

            final redirectedClass = redirectedConstructor.enclosingElement;

            // Check if redirected class is part of a mutually exclusive group
            for (final entry in mutuallyExclusiveGroups.entries) {
              final groupId = entry.key;
              final groupMembers = entry.value;

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
          for (final entry in redirectsByGroup.entries) {
            final groupId = entry.key;
            final redirectedMembers = entry.value;
            final allGroupMembers = mutuallyExclusiveGroups[groupId]!;
            final optionalInGroup = optionalMembers[groupId] ?? {};

            if (redirectedMembers.length < allGroupMembers.length) {
              final redirectedNames =
                  redirectedMembers.map((e) => e.name).toSet();

              // Get required members (all non-optional members)
              final requiredMembers =
                  allGroupMembers.difference(optionalInGroup);
              final requiredNames = requiredMembers.map((e) => e.name).toSet();

              // Check if any optional member is present
              final hasOptional =
                  redirectedMembers.any(optionalInGroup.contains);

              if (hasOptional) {
                // If optional member(s) are present, all required members
                // must also be present
                final missingRequired =
                    requiredNames.difference(redirectedNames);

                if (missingRequired.isNotEmpty) {
                  final optionalNames =
                      optionalInGroup.map((e) => e.name).toSet();
                  final presentOptional =
                      redirectedNames.intersection(optionalNames);

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
                final missingRequired =
                    requiredNames.difference(redirectedNames);

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
      final classElements = sortDeclarationsResult.element.classes;

      expect(classElements, isNotEmpty, reason: 'No classes found in library');

      final nonModifierClasses = <String>[];

      for (final classElement in classElements) {
        // Check if this class has @MutuallyExclusive annotation
        var hasMutuallyExclusive = false;
        for (final metadata in classElement.metadata.annotations) {
          final element = metadata.element;
          if (element is! ConstructorElement) continue;

          final enclosingElement = element.enclosingElement;
          if (enclosingElement.name == 'MutuallyExclusive') {
            hasMutuallyExclusive = true;
            break;
          }
        }

        if (!hasMutuallyExclusive) continue;

        // Check if this class extends Modifier
        final extendsModifier = classElement.allSupertypes.any(
          (type) => type.element.name == 'Modifier',
        );

        if (!extendsModifier) {
          final className = classElement.name;
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
      final classElements = sortDeclarationsResult.element.classes;

      expect(classElements, isNotEmpty, reason: 'No classes found in library');

      // Build a map of mutually exclusive groups
      final mutuallyExclusiveGroups = <String, Set<String>>{};

      for (final classElement in classElements) {
        for (final metadata in classElement.metadata.annotations) {
          final element = metadata.element;
          if (element is! ConstructorElement) continue;

          final enclosingElement = element.enclosingElement;
          if (enclosingElement.name != 'MutuallyExclusive') continue;

          final constantValue = metadata.computeConstantValue();
          if (constantValue == null) continue;

          final idField = constantValue.getField('id');
          if (idField == null) continue;

          final symbolValue = idField.toSymbolValue();
          if (symbolValue == null) continue;

          final className = classElement.name;
          if (className != null) {
            mutuallyExclusiveGroups
                .putIfAbsent(symbolValue, () => {})
                .add(className);
          }

          break;
        }
      }

      // Find groups with only one member
      final singleMemberGroups = <String>[];

      for (final entry in mutuallyExclusiveGroups.entries) {
        final groupId = entry.key;
        final members = entry.value;

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
