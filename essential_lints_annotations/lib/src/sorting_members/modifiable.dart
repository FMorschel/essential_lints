part of 'sort_declarations.dart';

/// Class representing modifiable sort declarations.
sealed class Modifiable extends SortDeclaration {
  const Modifiable();
}

/// A helper typedef for generating modifiers.
typedef ModifierGenerator<I extends Modifiable, O extends Modifier<I>> =
    SortDeclarationGenerator<I, O>;

/// Class representing modifiers for sort declarations.
sealed class Modifier<M extends Modifiable> extends Modifiable {
  const Modifier(this.modifiable);

  /// The modifiable that
  final M modifiable;
}
