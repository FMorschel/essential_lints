// ignore_for_file: public_member_api_docs only used for testing

part of 'sort_declarations.dart';

/// {@template wrapper}
/// Represents a wrapper modifier that can contain other modifiers.
/// This is used to test nested modifier detection.
/// This wrapper does NOT restrict Test, to demonstrate the nesting issue.
/// {@endtemplate}
@InvalidMembers({})
@InvalidModifiers({th<_TestWrapper>()})
@Deprecated('Only used for testing')
/*final*/ class _TestWrapper extends Modifier<Testable> implements Testable {
  @Deprecated('Only used for testing')

  /// {@macro wrapper}
  const _TestWrapper._(super.modifiable) : super._();
}

/// Testable modifiable member.
@visibleForTesting
@_gettersInMemberList
@Deprecated('Only used for testing')
/*sealed*/ abstract class Testable extends _StaticalContext {
  /// {@macro test}
  @Deprecated('Only used for testing')
  const factory Testable.test(Testable modifiable) = _Test._;

  /// {@macro wrapper}
  @Deprecated('Only used for testing')
  const factory Testable.wrapper(Testable modifiable) = _TestWrapper._;

  /// {@macro tests}
  @Deprecated('Only used for testing')
  static const Tests tests = Tests._tests;

  @Deprecated('Only used for testing')
  // ignore: unused_element member list
  static List<Testable> get _members => [tests];
}

/// {@template tests}
/// Represents all test members.
/// {@endtemplate}
@visibleForTesting
@Deprecated('Only used for testing')
/*final*/ class Tests extends Group implements Testable {
  @Deprecated('Only used for testing')

  /// {@macro tests}
  const Tests._() : super._();

  /// {@macro tests}
  static const Tests _tests = Tests._();
}

@InvalidMembers({th<Tests>()})
@InvalidModifiers({th<_Test>()})
@Deprecated('Only used for testing')
/*final*/ class _Test extends Modifier<Testable> implements Testable {
  @Deprecated('Only used for testing')
  const _Test._(super.modifiable) : super._();
}

/// Helper enum for sort declarations.
// ignore: library_private_types_in_public_api internal use
enum HelperEnum<T extends _StaticalContext> {
  abstract(SortDeclaration.abstract),
  const_(SortDeclaration.const_),
  constructor._named(SortDeclaration.constructor),
  dynamic(SortDeclaration.dynamic),
  external(SortDeclaration.external),
  factory_(SortDeclaration.factory_),
  field._named(SortDeclaration.field),
  final_(SortDeclaration.final_),
  getter(SortDeclaration.getter),
  initialized(SortDeclaration.initialized),
  instance(SortDeclaration.instance),
  late(SortDeclaration.late),
  method._named(SortDeclaration.method),
  named(SortDeclaration.named),
  new_(SortDeclaration.new_),
  nullable(SortDeclaration.nullable),
  operator(SortDeclaration.operator),
  overridden(SortDeclaration.overridden),
  private(SortDeclaration.private),
  public(SortDeclaration.public),
  redirecting(SortDeclaration.redirecting),
  setter._named(SortDeclaration.setter),
  static(SortDeclaration.static),
  typed(SortDeclaration.typed),
  unnamed(SortDeclaration.unnamed),
  var_(SortDeclaration.var_),
  constructors._group(SortDeclaration.constructors),
  fields._group(SortDeclaration.fields),
  fieldsGettersSetters._group(SortDeclaration.fieldsGettersSetters),
  getters._group(SortDeclaration.getters),
  gettersSetters._group(SortDeclaration.gettersSetters),
  methods._group(SortDeclaration.methods),
  setters._group(SortDeclaration.setters),
  ;

  const HelperEnum(SortDeclaration Function(T _) _);
  const HelperEnum._named(SortDeclaration Function(Symbol _) _);
  const HelperEnum._group(Group _);
}
