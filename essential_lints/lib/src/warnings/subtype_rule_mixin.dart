import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';

/// {@template supertype_annotations_result}
/// Result of collecting annotations from supertypes.
/// {@endtemplate}
class SuperTypeAnnotationsResult<T extends Matching<O>, O extends Matching<T>> {
  /// {@macro supertype_annotations_result}
  const SuperTypeAnnotationsResult(this.annotations, this.unmatchedOpposites);

  /// Collected annotations from supertypes, mapped to the declaring element.
  final List<MapEntry<T, InterfaceElement>> annotations;

  /// Opposite annotations that didn't match any collected annotation, mapped to
  /// the declaring element.
  final List<MapEntry<O, InterfaceElement>> unmatchedOpposites;
}

/// Mixin providing shared logic for subtype-related rules and warnings.
mixin SubtypeRuleMixin {
  /// Collects annotations from all supertypes of [element], mapping each found
  /// annotation to the corresponding declaring [InterfaceElement]. When
  /// `isOppositeAnnotation`/`mapperOpposite` are provided, opposite
  /// annotations that match previously collected annotations will remove
  /// those matches; any opposite annotations that don't match anything are
  /// returned in `unmatchedOpposites` so callers can act on leftovers.
  SuperTypeAnnotationsResult<T, O>
  collectSuperTypeAnnotations<T extends Matching<O>, O extends Matching<T>>(
    InterfaceElement element,
    bool Function(ElementAnnotation?) isAnnotation,
    T Function(ElementAnnotation?) mapper, {
    bool Function(ElementAnnotation?)? isOppositeAnnotation,
    O Function(ElementAnnotation?)? mapperOpposite,
  }) {
    var results = <MapEntry<T, InterfaceElement>>[];
    var unmatchedOpposites = <MapEntry<O, InterfaceElement>>[];
    var visitedElements = <InterfaceElement>{element};
    for (var interface in element.allSupertypes.reversed) {
      var current = interface.element;
      if (!visitedElements.add(current)) continue;
      if (isOppositeAnnotation != null && mapperOpposite != null) {
        var oppositeAnnotations = current.metadata.annotations.where(
          isOppositeAnnotation,
        );
        for (var oppAnn in oppositeAnnotations) {
          var opposite = mapperOpposite(oppAnn);
          var removedCount = 0;
          results.removeWhere((entry) {
            if (opposite.matches(entry.key)) {
              removedCount++;
              return true;
            }
            return false;
          });
          if (removedCount == 0) {
            unmatchedOpposites.add(MapEntry(opposite, current));
          }
        }
      }
      var currentAnnotations = current.metadata.annotations
          .where(isAnnotation)
          .map(mapper)
          .toList();
      results.addAll(currentAnnotations.map((a) => MapEntry(a, current)));
    }
    if (isOppositeAnnotation != null && mapperOpposite != null) {
      var oppositeAnnotations = element.metadata.annotations.where(
        isOppositeAnnotation,
      );
      for (var oppAnn in oppositeAnnotations) {
        var opposite = mapperOpposite(oppAnn);
        var removedCount = 0;
        results.removeWhere((entry) {
          if (opposite.matches(entry.key)) {
            removedCount++;
            return true;
          }
          return false;
        });
        if (removedCount == 0) {
          unmatchedOpposites.add(MapEntry(opposite, element));
        }
      }
    }
    return SuperTypeAnnotationsResult(results, unmatchedOpposites);
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
abstract class SubtypeAnnotation<T extends Matching> implements Matching<T> {
  /// {@macro subtype_annotation}
  const SubtypeAnnotation({required this.option, required this.packageOption});

  /// Option specifying the class types to which the annotation applies.
  final DartObject? option;

  /// Option specifying the package "visibility" for the annotation.
  final DartObject? packageOption;
}

/// {@template matching}
/// Interface for subtype annotation mapping results, providing a method to
/// check whether two annotations match, which is used to determine if an
/// "unnaming" annotation cancels a "naming" annotation.
/// {@endtemplate}
// ignore: one_member_abstracts
abstract class Matching<T extends Matching<dynamic>> {
  /// Returns true if this annotation matches the provided [other] annotation.
  bool matches(T other);
}
