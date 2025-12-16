part of 'sort_declarations.dart';

/// Class representing modifiable sort declarations.
sealed class Modifiable extends SortDeclaration {
  const Modifiable._() : super._();
}

/// Class representing statical context for [Modifier]s.
@SubtypeAnnotating(
  annotations: [AnnotateMembersWith(Consider, onlyPublic: true)],
  option: .onlyAbstract,
)
sealed class StaticalContext extends Modifiable {
  const StaticalContext._() : super._();
}

/// Class representing modifiers for sort declarations.
@SubtypeAnnotating(annotations: [InvalidMembers, InvalidModifiers])
final class Modifier<M extends StaticalContext> extends StaticalContext {
  const Modifier._(this.modifiable) : super._();

  /// The modifiable that
  final M modifiable;
}
