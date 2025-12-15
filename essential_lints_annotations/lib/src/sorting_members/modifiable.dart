part of 'sort_declarations.dart';

/// Class representing modifiable sort declarations.
sealed class Modifiable extends SortDeclaration {
  const Modifiable._() : super._();
}

/// Class representing modifiers for sort declarations.
sealed class Modifier<M extends Modifiable> extends Modifiable {
  const Modifier._(this.modifiable) : super._();

  /// The modifiable that
  final M modifiable;
}
