// Base class for override examples
// ignore_for_file: lines_longer_than_80_chars, unused_element

abstract class Base {
  int get foo;
  int get _foo;
  int? get fooNullable;
  int? get _fooNullable;
  external int get fooExternal;
  external int get _fooExternal;
  external int? get fooExternalNullable;
  external int? get _fooExternalNullable;
}

// ============================================================================
// Instance Getters - Regular (30 patterns)
// ============================================================================

// 1. int get foo => 0; - (public) + getters
class Getter1 {
  int get foo => 0;
}

// 2. int get _foo => 0; - private + getters
class Getter2 {
  int get _foo => 0;
}

// 3. int? get foo => null; - nullable + (public) + getters
class Getter3 {
  int? get foo => null;
}

// 4. int? get _foo => null; - nullable + private + getters
class Getter4 {
  int? get _foo => null;
}

// 5. int get foo; - abstract + (public) + getters
abstract class Getter5 {
  int get foo;
}

// 6. int get _foo; - abstract + private + getters
abstract class Getter6 {
  int get _foo;
}

// 7. int? get foo; - abstract + nullable + (public) + getters
abstract class Getter7 {
  int? get foo;
}

// 8. int? get _foo; - abstract + nullable + private + getters
abstract class Getter8 {
  int? get _foo;
}

// 9. external int get foo; - external + (public) + getters
class Getter9 {
  external int get foo;
}

// 10. external int get _foo; - external + private + getters
class Getter10 {
  external int get _foo;
}

// 11. external int? get foo; - external + nullable + (public) + getters
class Getter11 {
  external int? get foo;
}

// 12. external int? get _foo; - external + nullable + private + getters
class Getter12 {
  external int? get _foo;
}

// 13. @override int get foo => 0; - overridden + (public) + getters
abstract class Getter13 extends Base {
  @override
  int get foo => 0;
}

// 14. @override int get _foo => 0; - overridden + private + getters
abstract class Getter14 extends Base {
  @override
  int get _foo => 0;
}

// 15. @override int? get foo => null; - overridden + nullable + (public) + getters
abstract class Getter15 extends Base {
  @override
  int? get fooNullable => null;
}

// 16. @override int? get _foo => null; - overridden + nullable + private + getters
abstract class Getter16 extends Base {
  @override
  int? get _fooNullable => null;
}

// 17. @override external int get foo; - overridden + external + (public) + getters
abstract class Getter17 extends Base {
  @override
  external int get foo;
}

// 18. @override external int get foo; - overridden + external + getters
abstract class Getter18 extends Base {
  @override
  external int get foo;
}

// 19. @override external int get _foo; - overridden + external + private + getters
abstract class Getter19 extends Base {
  @override
  external int get _foo;
}

// 20. @override external int? get foo; - overridden + external + nullable + (public) + getters
abstract class Getter20 extends Base {
  @override
  external int? get fooNullable;
}

// 21. @override external int? get foo; - overridden + external + nullable + getters
abstract class Getter21 extends Base {
  @override
  external int? get fooNullable;
}

// 22. @override external int? get _foo; - overridden + external + nullable + private + getters
abstract class Getter22 extends Base {
  @override
  external int? get _fooNullable;
}

// ============================================================================
// Static Getters (8 patterns)
// ============================================================================

// 23. static int get foo => 0; - static + (public) + getters
class Getter23 {
  static int get foo => 0;
}

// 24. static int get _foo => 0; - static + private + getters
class Getter24 {
  static int get _foo => 0;
}

// 25. static int? get foo => null; - static + nullable + (public) + getters
class Getter25 {
  static int? get foo => null;
}

// 26. static int? get _foo => null; - static + nullable + private + getters
class Getter26 {
  static int? get _foo => null;
}

// 27. external static int get foo; - external + static + (public) + getters
class Getter27 {
  external static int get foo;
}

// 28. external static int get _foo; - external + static + private + getters
class Getter28 {
  external static int get _foo;
}

// 29. external static int? get foo; - external + static + nullable + (public) + getters
class Getter29 {
  external static int? get foo;
}

// 30. external static int? get _foo; - external + static + nullable + private + getters
class Getter30 {
  external static int? get _foo;
}
