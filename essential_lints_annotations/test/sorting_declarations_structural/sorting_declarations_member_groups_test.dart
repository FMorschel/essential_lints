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

  group('MemberGroup constraints', () {
    test('All member groups have at least two participants', () {
      final classElements = sortDeclarationsResult.element.classes;

      expect(classElements, isNotEmpty, reason: 'No classes found in library');

      // Build a map of member groups and their participants
      final memberGroups = <String, Set<String>>{};
      final nonParticipants = <String, Set<String>>{};

      for (final classElement in classElements) {
        for (final metadata in classElement.metadata.annotations) {
          final element = metadata.element;
          if (element is! ConstructorElement) continue;

          final enclosingElement = element.enclosingElement;
          if (enclosingElement.name != 'MemberGroup') continue;

          final constantValue = metadata.computeConstantValue();
          if (constantValue == null) continue;

          final nameField = constantValue.getField('name');
          if (nameField == null) continue;

          final symbolValue = nameField.toSymbolValue();
          if (symbolValue == null) continue;

          final participantField = constantValue.getField('participant');
          final isParticipant = participantField?.toBoolValue() ?? true;

          final className = classElement.name;
          if (className != null) {
            if (isParticipant) {
              memberGroups.putIfAbsent(symbolValue, () => {}).add(className);
            } else {
              nonParticipants
                  .putIfAbsent(symbolValue, () => {})
                  .add(className);
            }
          }
        }
      }

      // Find groups with less than two participants
      final insufficientGroups = <String>[];

      for (final entry in memberGroups.entries) {
        final groupId = entry.key;
        final participants = entry.value;

        if (participants.length < 2) {
          insufficientGroups.add(
            '#$groupId has only ${participants.length} participant(s): '
            '${participants.join(', ')}',
          );
        }
      }

      expect(
        insufficientGroups,
        isEmpty,
        reason:
            'Member groups must have at least 2 participants:\n'
            '  - ${insufficientGroups.join('\n  - ')}',
      );
    });

    test('No member group collection is missing its non-participant', () {
      final classElements = sortDeclarationsResult.element.classes;

      expect(classElements, isNotEmpty, reason: 'No classes found in library');

      // Build a map of member groups and their participants
      final memberGroups = <String, Set<String>>{};
      final nonParticipants = <String, String>{};

      for (final classElement in classElements) {
        for (final metadata in classElement.metadata.annotations) {
          final element = metadata.element;
          if (element is! ConstructorElement) continue;

          final enclosingElement = element.enclosingElement;
          if (enclosingElement.name != 'MemberGroup') continue;

          final constantValue = metadata.computeConstantValue();
          if (constantValue == null) continue;

          final nameField = constantValue.getField('name');
          if (nameField == null) continue;

          final symbolValue = nameField.toSymbolValue();
          if (symbolValue == null) continue;

          final participantField = constantValue.getField('participant');
          final isParticipant = participantField?.toBoolValue() ?? true;

          final className = classElement.name;
          if (className != null) {
            if (isParticipant) {
              memberGroups.putIfAbsent(symbolValue, () => {}).add(className);
            } else {
              nonParticipants[symbolValue] = className;
            }
          }
        }
      }

      // Find groups that have participants but no non-participant
      final missingNonParticipants = <String>[];

      for (final entry in memberGroups.entries) {
        final groupId = entry.key;
        final participants = entry.value;

        if (!nonParticipants.containsKey(groupId)) {
          missingNonParticipants.add(
            '#$groupId has participants (${participants.join(', ')}) '
            'but no non-participant',
          );
        }
      }

      expect(
        missingNonParticipants,
        isEmpty,
        reason:
            'Member groups with participants must have a non-participant:\n'
            '  - ${missingNonParticipants.join('\n  - ')}',
      );
    });

    test(
      'When a class references a member group member as static field, '
      'all group members must be present',
      () {
        final classElements = sortDeclarationsResult.element.classes;

        expect(
          classElements,
          isNotEmpty,
          reason: 'No classes found in library',
        );

        // Build a map of member groups and their members
        final memberGroups = <String, Set<String>>{};
        final nonParticipants = <String, String>{};
        final classNameToElement = <String, InterfaceElement>{};

        // First pass: collect all member group relationships
        for (final classElement in classElements) {
          final className = classElement.name;
          if (className == null) continue;

          classNameToElement[className] = classElement;

          for (final metadata in classElement.metadata.annotations) {
            final element = metadata.element;
            if (element is! ConstructorElement) continue;

            final enclosingElement = element.enclosingElement;
            if (enclosingElement.name != 'MemberGroup') continue;

            final constantValue = metadata.computeConstantValue();
            if (constantValue == null) continue;

            final nameField = constantValue.getField('name');
            if (nameField == null) continue;

            final symbolValue = nameField.toSymbolValue();
            if (symbolValue == null) continue;

            final participantField = constantValue.getField('participant');
            final isParticipant = participantField?.toBoolValue() ?? true;

            if (isParticipant) {
              memberGroups.putIfAbsent(symbolValue, () => {}).add(className);
            } else {
              nonParticipants[symbolValue] = className;
            }
          }
        }

        // Create reverse lookup: class name -> groups it belongs to
        final classToGroups = <String, Set<String>>{};
        for (final entry in memberGroups.entries) {
          for (final className in entry.value) {
            classToGroups.putIfAbsent(className, () => {}).add(entry.key);
          }
        }
        for (final entry in nonParticipants.entries) {
          classToGroups
              .putIfAbsent(entry.value, () => {})
              .add(entry.key);
        }

        // Second pass: For each StaticalContext class, check static fields
        final violations = <String>[];

        for (final classElement in classElements) {
          final className = classElement.name;
          if (className == null) continue;

          // Check if this class directly extends StaticalContext
          final extendsStaticalContext = classElement.supertype != null &&
              classElement.supertype!.element.name == 'StaticalContext';

          if (!extendsStaticalContext) continue;

          // Collect all static const fields that reference member group members
          final referencedGroupMembers = <String, Set<String>>{};

          for (final field in classElement.fields) {
            if (!field.isStatic || !field.isConst) continue;

            final fieldType = field.type.element;
            if (fieldType is! InterfaceElement) continue;

            final fieldTypeName = fieldType.name;
            if (fieldTypeName == null) continue;

            // Check if this field references a member group member
            final groups = classToGroups[fieldTypeName];
            if (groups != null) {
              for (final groupId in groups) {
                referencedGroupMembers
                    .putIfAbsent(groupId, () => {})
                    .add(fieldTypeName);
              }
            }
          }

          // For each group that has at least one referenced member,
          // verify all members are referenced
          for (final entry in referencedGroupMembers.entries) {
            final groupId = entry.key;
            final referencedMembers = entry.value;

            // Get participants and non-participant for this group
            final participants = memberGroups[groupId] ?? {};
            final nonParticipant = nonParticipants[groupId];

            // Check which participants are referenced
            final referencedParticipants =
                participants.intersection(referencedMembers);
            final missingParticipants =
                participants.difference(referencedMembers);

            // Check if non-participant is referenced
            final hasNonParticipant = nonParticipant != null &&
                referencedMembers.contains(nonParticipant);

            // Rule 1: All participants present but non-participant missing
            if (referencedParticipants.length == participants.length &&
                !hasNonParticipant) {
              violations.add(
                '$className has all participants of #$groupId but is missing '
                'the non-participant:\n'
                '  - Has participants: ${referencedParticipants.join(', ')}\n'
                '  - Missing non-participant: $nonParticipant',
              );
            }

            // Rule 2: Non-participant present but no participants
            if (hasNonParticipant && referencedParticipants.isEmpty) {
              violations.add(
                '$className has the non-participant of #$groupId but no '
                'participants:\n'
                '  - Has non-participant: $nonParticipant\n'
                '  - Missing participants: ${participants.join(', ')}',
              );
            }

            // Rule 3: Some participants missing (info only, not a violation)
            if (referencedParticipants.isNotEmpty &&
                missingParticipants.isNotEmpty) {
              // Info only - some participants missing but not all
              // This is allowed and won't cause the test to fail
              print(
                'INFO: $className has some participants of #$groupId '
                'but not all:\n'
                '  - Has: ${referencedParticipants.join(', ')}\n'
                '  - Missing: ${missingParticipants.join(', ')}',
              );
            }
          }
        }

        expect(
          violations,
          isEmpty,
          reason:
              'Member group consistency violations found:\n\n'
              '${violations.join('\n\n')}',
        );
      },
    );
  });
}
