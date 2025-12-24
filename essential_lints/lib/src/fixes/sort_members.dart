import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:logging/logging.dart';

import '../warnings/sorting_members.dart';
import 'essential_lint_fixes.dart';
import 'fix.dart';

final _logger = Logger('SortMembersFix');

/// A member that needs to be moved, along with where to insert it.
class _MemberToMove {
  _MemberToMove({
    required this.member,
    required this.insertOffset,
    required this.requiredLinesBefore,
    required this.requiredLinesAfter,
  });

  /// The member to move.
  final MemberResult member;

  /// The offset where this member should be inserted.
  final int insertOffset;

  final int? requiredLinesBefore;

  final int? requiredLinesAfter;
}

/// {@template sort_members_fix}
/// A fix that sorts the members of a class, mixin, enum, extension or extension
/// type according to the defined sorting rules.
/// {@endtemplate}
class SortMembersFix extends ResolvedCorrectionProducer with WarningFix {
  /// {@macro sort_members_fix}
  SortMembersFix({required super.context});

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintWarningFixes get fix => .sortMembers;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    if (diagnostic == null) {
      return;
    }
    var node = this.node;
    var enclosingInstanceDeclaration = node.enclosingInstanceDeclaration;
    if (enclosingInstanceDeclaration == null) {
      assert(
        false,
        'How did we get a diagnostic for sorting members without being inside '
        'an instance declaration?',
      );
      return;
    }

    // Find the @SortingMembers annotation
    var annotatedNode = enclosingInstanceDeclaration as AnnotatedNode;
    ElementAnnotation? sortingMembersAnnotation;
    for (var annotation in annotatedNode.metadata) {
      var element = annotation.elementAnnotation;
      if (element == null) continue;
      var object = element.computeConstantValue();
      if (object?.type?.element?.name == 'SortingMembers' &&
          object?.type?.element?.library?.uri ==
              Uri.parse(
                'package:essential_lints_annotations/src/sorting_members.dart',
              )) {
        sortingMembersAnnotation = element;
        break;
      }
    }

    if (sortingMembersAnnotation == null) {
      return;
    }

    // Get the validator configuration from the annotation
    var validatorFromAnnotation = ValidatorFromAnnotation.fromAnnotation(
      sortingMembersAnnotation,
    );

    // Create a tracking visitor to collect and sort all members
    var trackingVisitor = TrackingMemberVisitor(unit, validatorFromAnnotation);
    enclosingInstanceDeclaration.visitChildren(trackingVisitor);

    // Get the sorted members
    var sortedMembers = trackingVisitor.sortedMembers;
    var originalMembers = trackingVisitor.members;

    // Check if already sorted
    var needsSorting = false;
    for (var i = 0; i < originalMembers.length; i++) {
      if (originalMembers[i] != sortedMembers[i]) {
        needsSorting = true;
        break;
      }
    }

    if (!needsSorting) {
      return;
    }

    // Collect all edits first
    var edits = <({int start, int end, String replacement})>[];

    // Find which members need to be moved
    var membersToMove = _findMembersToMove(
      originalMembers,
      sortedMembers,
      enclosingInstanceDeclaration,
      validatorFromAnnotation,
    );

    // Build a set of nodes being moved for quick lookup
    var nodesBeingMoved = membersToMove.map((m) => m.member.node).toSet();

    // Add deletions for members that will be moved
    for (var moveInfo in membersToMove) {
      var node = moveInfo.member.node;

      // Deletion should normally start at the node's line start. Only extend
      // the start offset to include blank lines if the previous member is
      // ALSO being moved — otherwise we risk deleting content that should stay.
      var idx = originalMembers.indexWhere((m) => m.node == node);
      int deleteStart;
      // Use the start of the node's first line rather than the raw node
      // offset. This ensures we consider blank lines that precede the
      // visible start of the member.
      var nodeStartLine = unit.lineInfo.getLocation(node.offset).lineNumber;
      var nodeFirstLineStart = unit.lineInfo.getOffsetOfLine(nodeStartLine - 1);

      if (idx > 0) {
        var prevMember = originalMembers[idx - 1];
        var prevEnd = prevMember.node.end;
        var prevEndLine = unit.lineInfo.getLocation(prevEnd).lineNumber;
        var blankLinesBetween = nodeStartLine - prevEndLine - 1;
        if (blankLinesBetween > 0) {
          // There are blank lines between prev and this node.
          // Whether prev is moving or not, we should clean up these blanks
          // since this member is being moved away.
          deleteStart = prevEnd;
        } else {
          deleteStart = nodeFirstLineStart;
        }
      } else {
        // First member - check against the left bracket
        var leftBracket = enclosingInstanceDeclaration.leftBracket;
        var candidate = leftBracket?.end ?? nodeFirstLineStart;
        var candidateLine = unit.lineInfo.getLocation(candidate).lineNumber;
        var blankLinesBetween = nodeStartLine - candidateLine - 1;
        if (blankLinesBetween > 0) {
          deleteStart = candidate;
        } else {
          deleteStart = nodeFirstLineStart;
        }
      }

      var deleteEnd = node.end;

      // Include trailing newline if present
      var nodeEndLine = unit.lineInfo.getLocation(deleteEnd).lineNumber;
      var nextLineStart = unit.lineInfo.getOffsetOfLine(nodeEndLine);
      deleteEnd = nextLineStart;

      if (idx == 0) {
        // If the next member is staying, we should clean empty lines between
        // this and that member
        var nextMember = originalMembers[idx + 1];
        var nextStart = nextMember.node.offset;
        var nextStartLine = unit.lineInfo.getLocation(nextStart);
        var blankLinesBetween = nextStartLine.lineNumber - nodeEndLine;
        if (blankLinesBetween > 0) {
          deleteEnd = unit.lineInfo.getOffsetOfLine(
            nextStartLine.lineNumber - 1,
          );
        }
      }

      edits.add((start: deleteStart, end: deleteEnd, replacement: ''));
    }

    // Add insertions for members that were moved
    // Group members by their insert offset to handle spacing correctly
    var membersByOffset = <int, List<_MemberToMove>>{};
    for (var moveInfo in membersToMove) {
      membersByOffset
          .putIfAbsent(moveInfo.insertOffset, () => [])
          .add(moveInfo);
    }

    for (var entry in membersByOffset.entries) {
      var offset = entry.key;
      var members = entry.value;

      // Build a single insertion for all members at this offset
      var buffer = StringBuffer();
      for (var i = 0; i < members.length; i++) {
        var moveInfo = members[i];
        var requiredLinesBefore = moveInfo.requiredLinesBefore ?? 0;

        // Add the line break and any required blank lines before this member
        buffer.write(builder.defaultEol);
        for (var j = 0; j < requiredLinesBefore; j++) {
          buffer.write(builder.defaultEol);
        }

        // Add the member itself with proper indentation
        buffer
          ..write(utils.oneIndent)
          ..write(utils.getNodeText(moveInfo.member.node));
      }

      // Add spacing after the last member in this insertion if needed
      // Find the last member that was inserted at this offset in sorted order
      var lastMember = members.last;
      var lastMemberIndexInSorted = sortedMembers.indexWhere(
        (m) => m.node == lastMember.member.node,
      );

      // Check if there's a next member in sorted order that was NOT moved
      if (lastMemberIndexInSorted < sortedMembers.length - 1) {
        var nextMember = sortedMembers[lastMemberIndexInSorted + 1];
        var nextWasMoved = membersToMove.any(
          (m) => m.member.node == nextMember.node,
        );

        // If next member was not moved and has spacing requirements,
        // add that spacing after this insertion
        if (!nextWasMoved && nextMember.requiredLinesBefore != null) {
          for (var j = 0; j < nextMember.requiredLinesBefore!; j++) {
            buffer.write(builder.defaultEol);
          }
        }
      }

      edits.add((
        start: offset,
        end: offset,
        replacement: buffer.toString(),
      ));
    }

    // Fix spacing for members that weren't moved but need spacing adjustments
    for (var i = 1; i < sortedMembers.length; i++) {
      var currentMember = sortedMembers[i];
      var previousMember = sortedMembers[i - 1];
      var requiredLines = currentMember.requiredLinesBefore;

      // Skip if spacing is not specified
      if (requiredLines == null) continue;

      // Check if this member was moved - if so, we already handled its spacing
      var wasMoved = membersToMove.any(
        (m) => m.member.node == currentMember.node,
      );
      if (wasMoved) continue;

      // Check if the previous member was moved - if so, spacing will be handled
      // by the insertion
      var prevWasMoved = membersToMove.any(
        (m) => m.member.node == previousMember.node,
      );
      if (prevWasMoved) continue;

      // Both members stayed in place - check if they were originally adjacent
      // or if there were members deleted between them
      var prevIndexInOriginal = originalMembers.indexWhere(
        (m) => m.node == previousMember.node,
      );
      var currIndexInOriginal = originalMembers.indexWhere(
        (m) => m.node == currentMember.node,
      );

      // Check if they were originally adjacent
      var wereOriginallyAdjacent =
          currIndexInOriginal == prevIndexInOriginal + 1;

      int actualBlankLines;
      if (wereOriginallyAdjacent) {
        // They were adjacent in original, calculate actual spacing
        var prevEndLine = unit.lineInfo
            .getLocation(previousMember.node.end)
            .lineNumber;
        var currStartLine = unit.lineInfo
            .getLocation(currentMember.node.offset)
            .lineNumber;
        actualBlankLines = currStartLine - prevEndLine - 1;
      } else {
        // They were NOT adjacent in original, which means members were deleted
        // between them. We need to add spacing regardless of original spacing.
        // Set actualBlankLines to a value that will trigger the spacing fix
        actualBlankLines = -1; // Force spacing adjustment
      }

      if (actualBlankLines != requiredLines) {
        // Need to adjust spacing
        var prevEnd = previousMember.node.end;

        // Find the start of the line containing the current member
        var currStartLine = unit.lineInfo
            .getLocation(currentMember.node.offset)
            .lineNumber;
        var currStartLineOffset = unit.lineInfo.getOffsetOfLine(
          currStartLine - 1,
        );

        // Replace everything from end of previous member to start of current
        // line with the correct number of blank lines
        var newSpacing =
            builder.defaultEol + (builder.defaultEol * requiredLines);
        edits.add((
          start: prevEnd,
          end: currStartLineOffset,
          replacement: newSpacing,
        ));
      }
    }

    // Clean up trailing blank lines
    // Find the last member that is staying in place (not being moved)
    // We need to use the original position of the last stationary member
    MemberResult? lastStationaryMember;
    for (var i = originalMembers.length - 1; i >= 0; i--) {
      var member = originalMembers[i];
      if (!nodesBeingMoved.contains(member.node)) {
        lastStationaryMember = member;
        break;
      }
    }

    // Replace everything between the last stationary member and the right
    // bracket with a single newline (this handles trailing blank lines)
    // Note: If all members were moved, we don't need to clean up here since
    // insertions will handle the spacing.
    if (lastStationaryMember != null) {
      var rightBracket = enclosingInstanceDeclaration.rightBracket;
      if (rightBracket != null) {
        var lastMemberEnd = lastStationaryMember.node.end;
        var rightBracketLine = unit.lineInfo
            .getLocation(rightBracket.offset)
            .lineNumber;
        var lineBeforeRightBracketEnd = unit.lineInfo.getOffsetOfLine(
          rightBracketLine - 1,
        );

        // Replace with single newline from end of last member to right bracket
        // line
        if (lineBeforeRightBracketEnd > lastMemberEnd) {
          edits.add((
            start: lastMemberEnd,
            end: lineBeforeRightBracketEnd,
            replacement: builder.defaultEol,
          ));
        }
      }
    }

    // Merge overlapping edits
    edits.sort((a, b) => a.start.compareTo(b.start));
    var mergedEdits = <({int start, int end, String replacement})>[];
    for (var edit in edits) {
      if (mergedEdits.isEmpty) {
        mergedEdits.add(edit);
      } else {
        var last = mergedEdits.last;
        if (edit.start <= last.end) {
          // Overlapping or adjacent - merge them
          // Determine how to combine replacements based on edit types
          String mergedReplacement;
          if (last.start == last.end && edit.start == edit.end) {
            // Both are pure insertions at the same point - concatenate
            mergedReplacement = last.replacement + edit.replacement;
          } else if (last.start == last.end) {
            // Last was a pure insertion, current is a deletion/replacement
            // Prepend the insertion content to the current replacement
            mergedReplacement = last.replacement + edit.replacement;
          } else if (edit.start == edit.end) {
            // Current is a pure insertion at a point within last's range
            // Append the insertion content to the last replacement
            mergedReplacement = last.replacement + edit.replacement;
          } else if (edit.replacement.isNotEmpty) {
            mergedReplacement = edit.replacement;
          } else {
            mergedReplacement = last.replacement;
          }
          mergedEdits[mergedEdits.length - 1] = (
            start: last.start,
            end: edit.end > last.end ? edit.end : last.end,
            replacement: mergedReplacement,
          );
        } else {
          mergedEdits.add(edit);
        }
      }
    }

    // Apply edits to builder
    await builder.addDartFileEdit(file, (builder) {
      if (sortedMembers.isEmpty) return;

      // Apply deletions and replacements
      for (var edit in mergedEdits) {
        if (edit.replacement.isEmpty) {
          builder.addDeletion(range.startOffsetEndOffset(edit.start, edit.end));
        } else {
          builder.addSimpleReplacement(
            range.startOffsetEndOffset(edit.start, edit.end),
            edit.replacement,
          );
        }
      }
    });
  }

  /// Finds members that need to be moved by identifying members that are
  /// out of order. Members that are already in correct relative order
  /// are left in place.
  List<_MemberToMove> _findMembersToMove(
    List<MemberResult> original,
    List<MemberResult> sorted,
    CompilationUnitMember enclosingDeclaration,
    ValidatorFromAnnotation validatorFromAnnotation,
  ) {
    _logger
      ..info('=== Finding members to move ===')
      ..info(
        'Original order: '
        '${original.map((m) => m.node.toString().split('\n').first).toList()}',
      )
      ..info(
        'Sorted order: '
        '${sorted.map((m) => m.node.toString().split('\n').first).toList()}',
      );

    // Map each original member to its target position in sorted list
    var targetPositions = <int>[];
    for (var member in original) {
      var targetPos = sorted.indexWhere((m) => m.node == member.node);
      targetPositions.add(targetPos);
    }

    _logger.info('Target positions: $targetPositions');

    // Find longest increasing subsequence - these members don't need to move
    var lis = _longestIncreasingSubsequence(targetPositions);
    _logger.info('LIS indices: $lis');
    var keepIndices = lis.toSet();
    _logger.info('Keeping members at indices: $keepIndices');

    // Build a set of target indices for members that will be moved
    var movedTargetIndices = <int>{};
    for (var i = 0; i < original.length; i++) {
      if (!keepIndices.contains(i)) {
        movedTargetIndices.add(targetPositions[i]);
      }
    }

    // Calculate insert offsets for members that need to move
    // We need to find the correct anchor point for each member.
    // The anchor is the previous member in sorted order that is NOT being moved
    // OR is the first in a sequence of moved members.
    var membersToMove = <_MemberToMove>[];
    for (var i = 0; i < original.length; i++) {
      if (!keepIndices.contains(i)) {
        var memberToMove = original[i];
        var targetIndex = targetPositions[i];

        // Find the insert offset by looking for the first non-moved member
        // before this position in sorted order, or the first in a sequence
        // of moved members that share the same anchor.
        int insertOffset;
        if (targetIndex == 0) {
          // Insert at the beginning - find the opening brace
          var leftBracket = enclosingDeclaration.leftBracket;
          if (leftBracket != null) {
            insertOffset = leftBracket.end;
          } else {
            continue; // Skip if we can't find the body
          }
        } else {
          // Find the anchor: walk backwards in sorted order to find either:
          // 1. A member that is NOT being moved (use its node.end)
          // 2. The beginning of the class (use leftBracket.end)
          var anchorIndex = targetIndex - 1;
          while (anchorIndex >= 0 && movedTargetIndices.contains(anchorIndex)) {
            anchorIndex--;
          }

          if (anchorIndex >= 0) {
            // Found a stationary member as anchor
            var anchorMember = sorted[anchorIndex];
            insertOffset = anchorMember.node.end;
          } else {
            // All previous members are being moved, insert at beginning
            var leftBracket = enclosingDeclaration.leftBracket;
            if (leftBracket != null) {
              insertOffset = leftBracket.end;
            } else {
              continue; // Skip if we can't find the body
            }
          }
        }

        // Get spacing requirements from the sorted list
        var sortedMemberInfo = sorted[targetIndex];

        membersToMove.add(
          _MemberToMove(
            member: memberToMove,
            insertOffset: insertOffset,
            requiredLinesBefore: sortedMemberInfo.requiredLinesBefore,
            requiredLinesAfter: sortedMemberInfo.requiredLinesAfter,
          ),
        );
      }
    }

    // Sort membersToMove by their target index in sorted order
    // so that they are inserted in the correct sequence
    membersToMove.sort((a, b) {
      var aTargetIndex = sorted.indexWhere((m) => m.node == a.member.node);
      var bTargetIndex = sorted.indexWhere((m) => m.node == b.member.node);
      return aTargetIndex.compareTo(bTargetIndex);
    });

    return membersToMove;
  }

  /// Finds the longest increasing subsequence and returns the indices
  /// of elements in the original list that form this subsequence.
  List<int> _longestIncreasingSubsequence(List<int> nums) {
    if (nums.isEmpty) return [];

    var n = nums.length;
    var dp = List.filled(n, 1);
    var prev = List.filled(n, -1);

    for (var i = 1; i < n; i++) {
      for (var j = 0; j < i; j++) {
        if (nums[j] < nums[i] && dp[j] + 1 > dp[i]) {
          dp[i] = dp[j] + 1;
          prev[i] = j;
        }
      }
    }

    // Find the index with maximum length
    var maxLength = 0;
    var maxIndex = 0;
    for (var i = 0; i < n; i++) {
      if (dp[i] > maxLength) {
        maxLength = dp[i];
        maxIndex = i;
      }
    }

    // Backtrack to find the indices
    var result = <int>[];
    var current = maxIndex;
    while (current != -1) {
      result.add(current);
      current = prev[current];
    }

    return result.reversed.toList();
  }
}

extension on CompilationUnitMember {
  Token? get leftBracket {
    var self = this;
    if (self is ClassDeclaration) {
      return self.leftBracket;
    } else if (self is MixinDeclaration) {
      return self.leftBracket;
    } else if (self is EnumDeclaration) {
      return self.leftBracket;
    } else if (self is ExtensionDeclaration) {
      return self.leftBracket;
    } else if (self is ExtensionTypeDeclaration) {
      return self.leftBracket;
    }
    return null;
  }

  Token? get rightBracket {
    var self = this;
    if (self is ClassDeclaration) {
      return self.rightBracket;
    } else if (self is MixinDeclaration) {
      return self.rightBracket;
    } else if (self is EnumDeclaration) {
      return self.rightBracket;
    } else if (self is ExtensionDeclaration) {
      return self.rightBracket;
    } else if (self is ExtensionTypeDeclaration) {
      return self.rightBracket;
    }
    return null;
  }
}

extension on AstNode {
  CompilationUnitMember? get enclosingInstanceDeclaration {
    AstNode? current = this;
    while (current != null) {
      if ((current is ClassDeclaration ||
              current is MixinDeclaration ||
              current is EnumDeclaration ||
              current is ExtensionDeclaration ||
              current is ExtensionTypeDeclaration) &&
          current is CompilationUnitMember) {
        return current;
      }
      current = current.parent;
    }
    return null;
  }
}
