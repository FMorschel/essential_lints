import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';

/// Mixin providing shared logic for subtype-related rules and warnings.
mixin SubtypeRuleMixin {
  /// Collects annotations from all supertypes of [element], mapping each found
  /// annotation to the corresponding declaring [InterfaceElement].
  List<MapEntry<T, InterfaceElement>> collectSuperTypeAnnotations<T>(
    InterfaceElement element,
    bool Function(ElementAnnotation?) isAnnotation,
    T Function(ElementAnnotation?) mapper,
  ) {
    var results = <MapEntry<T, InterfaceElement>>[];
    var visitedElements = <InterfaceElement>{element};
    for (var interface in element.allSupertypes) {
      var current = interface.element;
      if (!visitedElements.add(current)) continue;
      var currentAnnotations = current.metadata.annotations
          .where(isAnnotation)
          .map(mapper)
          .toList();
      results.addAll(currentAnnotations.map((a) => MapEntry(a, current)));
    }
    return results;
  }

  /// Returns true when both [InterfaceElement]s are from the same package,
  /// false otherwise.
  bool isSamePackage(InterfaceElement first, InterfaceElement second) {
    var firstUri = first.firstFragment.enclosingFragment?.source.uri;
    var secondUri = second.firstFragment.enclosingFragment?.source.uri;
    if (firstUri == null || secondUri == null) return false;
    if (firstUri.scheme == 'package' && secondUri.scheme == 'package') {
      if (firstUri.pathSegments.isNotEmpty &&
          secondUri.pathSegments.isNotEmpty) {
        return firstUri.pathSegments.first == secondUri.pathSegments.first;
      }
    }
    return firstUri == secondUri;
  }

  /// Returns true when the provided [annotation] should be skipped for the
  /// [element] coming from [origin]. This consolidates package/option checks
  /// shared by multiple subtype rules.
  bool shouldSkipAnnotation<T extends SubtypeAnnotation>(
    T annotation,
    InterfaceElement element,
    InterfaceElement origin, {
    bool abstract = false,
    bool isMixin = false,
  }) {
    if (annotation.packageOption?.variable?.name == 'private' &&
        !isSamePackage(element, origin)) {
      return true;
    }
    if (annotation.option?.variable?.name == 'onlyConcrete' && abstract) {
      return true;
    } else if (annotation.option?.variable?.name == 'onlyAbstract' &&
        !abstract) {
      return true;
    } else if (annotation.option?.variable?.name == 'onlyInstantiable' &&
        (abstract || isMixin)) {
      return true;
    }
    return false;
  }
}

/// {@template subtype_annotation}
/// Shared base for subtype annotation mapping results.
/// {@endtemplate}
abstract class SubtypeAnnotation {
  /// {@macro subtype_annotation}
  const SubtypeAnnotation({required this.option, required this.packageOption});

  /// Option specifying the class types to which the annotation applies.
  final DartObject? option;

  /// Option specifying the package "visibility" for the annotation.
  final DartObject? packageOption;
}
