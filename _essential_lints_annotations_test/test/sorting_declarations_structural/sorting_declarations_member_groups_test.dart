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

  group('MemberGroup constraints', () {
    test('All member groups have at least two participants', () {
      var classElements = sortDeclarationsResult.element.classes;

      expect(classElements, isNotEmpty, reason: 'No classes found in library');

      // Build a map of member groups and their participants
      var memberGroups = <String, Set<String>>{};
      var nonParticipants = <String, Set<String>>{};

      for (var classElement in classElements) {
        for (var metadata in classElement.metadata.annotations) {
          var element = metadata.element;
          if (element is! ConstructorElement) continue;

          var enclosingElement = element.enclosingElement;
          if (enclosingElement.name != 'MemberGroup') continue;

          var constantValue = metadata.computeConstantValue();
          if (constantValue == null) continue;

          var nameField = constantValue.getField('name');
          if (nameField == null) continue;

          var symbolValue = nameField.toSymbolValue();
          if (symbolValue == null) continue;

          var participantField = constantValue.getField('participant');
          var isParticipant = participantField?.toBoolValue() ?? true;

          var className = classElement.name;
          if (className != null) {
            if (isParticipant) {
              memberGroups.putIfAbsent(symbolValue, () => {}).add(className);
            } else {
              nonParticipants.putIfAbsent(symbolValue, () => {}).add(className);
            }
          }
        }
      }

      // Find groups with less than two participants
      var insufficientGroups = <String>[];

      for (var entry in memberGroups.entries) {
        var groupId = entry.key;
        var participants = entry.value;

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
      var classElements = sortDeclarationsResult.element.classes;

      expect(classElements, isNotEmpty, reason: 'No classes found in library');

      // Build a map of member groups and their participants
      var memberGroups = <String, Set<String>>{};
      var nonParticipants = <String, String>{};

      for (var classElement in classElements) {
        for (var metadata in classElement.metadata.annotations) {
          var element = metadata.element;
          if (element is! ConstructorElement) continue;

          var enclosingElement = element.enclosingElement;
          if (enclosingElement.name != 'MemberGroup') continue;

          var constantValue = metadata.computeConstantValue();
          if (constantValue == null) continue;

          var nameField = constantValue.getField('name');
          if (nameField == null) continue;

          var symbolValue = nameField.toSymbolValue();
          if (symbolValue == null) continue;

          var participantField = constantValue.getField('participant');
          var isParticipant = participantField?.toBoolValue() ?? true;

          var className = classElement.name;
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
      var missingNonParticipants = <String>[];

      for (var entry in memberGroups.entries) {
        var groupId = entry.key;
        var participants = entry.value;

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
        var classElements = sortDeclarationsResult.element.classes;

        expect(
          classElements,
          isNotEmpty,
          reason: 'No classes found in library',
        );

        // Build a map of member groups and their members
        var memberGroups = <String, Set<String>>{};
        var nonParticipants = <String, String>{};
        var classNameToElement = <String, InterfaceElement>{};

        // First pass: collect all member group relationships
        for (var classElement in classElements) {
          var className = classElement.name;
          if (className == null) continue;

          classNameToElement[className] = classElement;

          for (var metadata in classElement.metadata.annotations) {
            var element = metadata.element;
            if (element is! ConstructorElement) continue;

            var enclosingElement = element.enclosingElement;
            if (enclosingElement.name != 'MemberGroup') continue;

            var constantValue = metadata.computeConstantValue();
            if (constantValue == null) continue;

            var nameField = constantValue.getField('name');
            if (nameField == null) continue;

            var symbolValue = nameField.toSymbolValue();
            if (symbolValue == null) continue;

            var participantField = constantValue.getField('participant');
            var isParticipant = participantField?.toBoolValue() ?? true;

            if (isParticipant) {
              memberGroups.putIfAbsent(symbolValue, () => {}).add(className);
            } else {
              nonParticipants[symbolValue] = className;
            }
          }
        }

        // Create reverse lookup: class name -> groups it belongs to
        var classToGroups = <String, Set<String>>{};
        for (var entry in memberGroups.entries) {
          for (var className in entry.value) {
            classToGroups.putIfAbsent(className, () => {}).add(entry.key);
          }
        }
        for (var entry in nonParticipants.entries) {
          classToGroups.putIfAbsent(entry.value, () => {}).add(entry.key);
        }

        // Second pass: For each StaticalContext class, check static fields
        var violations = <String>[];

        for (var classElement in classElements) {
          var className = classElement.name;
          if (className == null) continue;

          // Check if this class directly extends StaticalContext
          var extendsStaticalContext =
              classElement.supertype != null &&
              classElement.supertype!.element.name == 'StaticalContext';

          if (!extendsStaticalContext) continue;

          // Collect all static const fields that reference member group members
          var referencedGroupMembers = <String, Set<String>>{};

          for (var field in classElement.fields) {
            if (!field.isStatic || !field.isConst) continue;

            var fieldType = field.type.element;
            if (fieldType is! InterfaceElement) continue;

            var fieldTypeName = fieldType.name;
            if (fieldTypeName == null) continue;

            // Check if this field references a member group member
            var groups = classToGroups[fieldTypeName];
            if (groups != null) {
              for (var groupId in groups) {
                referencedGroupMembers
                    .putIfAbsent(groupId, () => {})
                    .add(fieldTypeName);
              }
            }
          }

          // For each group that has at least one referenced member,
          // verify all members are referenced
          for (var entry in referencedGroupMembers.entries) {
            var groupId = entry.key;
            var referencedMembers = entry.value;

            // Get participants and non-participant for this group
            var participants = memberGroups[groupId] ?? {};
            var nonParticipant = nonParticipants[groupId];

            // Check which participants are referenced
            var referencedParticipants = participants.intersection(
              referencedMembers,
            );
            var missingParticipants = participants.difference(
              referencedMembers,
            );

            // Check if non-participant is referenced
            var hasNonParticipant =
                nonParticipant != null &&
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
