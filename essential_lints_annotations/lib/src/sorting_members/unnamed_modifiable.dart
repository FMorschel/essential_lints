part of 'sort_declarations.dart';

/// Represents unnamed members.
sealed class UnnamedModifiable extends Modifiable {
  const UnnamedModifiable._() : super._();

  /// {@macro constructors}
  static const UnnamedModifiable constructors = Constructors._constructors;
}

/// {@template unnamed}
/// Represents unnamed members.
/// {@endtemplate}
@InvalidMembers([
  th<Fields>(),
  th<Getters>(),
  th<Setters>(),
  th<GettersSetters>(),
  th<FieldsGettersSetters>(),
  th<Methods>(),
])
@InvalidModifiers([
  th<Private>(),
  th<Public>(),
  th<Named>(),
  th<Unnamed>(),
  th<Factory>(),
  th<Const>(),
  th<External>(),
])
final class Unnamed<M extends UnnamedModifiable> extends Modifier<M>
    implements
        NamedModifiable,
        RedirectingModifiable,
        FactoryModifiable,
        ExternalMembersModifiable,
        Constant {
  /// {@macro unnamed}
  const Unnamed._(super.modifiable) : super._();
}
