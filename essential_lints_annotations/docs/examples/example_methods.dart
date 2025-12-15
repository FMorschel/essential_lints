// Base class for override examples
// ignore_for_file: lines_longer_than_80_chars, one_member_abstracts, unused_element

abstract class Base {
  void foo();
  void _foo();
  int? fooNullable();
  int? _fooNullable();
  external void fooExternal();
  external void _fooExternal();
  external int? fooExternalNullable();
  external int? _fooExternalNullable();
  Base operator +(Base other);
  Base? operator -(Base other);
}

// ============================================================================
// Instance Methods (36 patterns)
// ============================================================================

// 1. void foo() {} - public + methods
class Method1 {
  void foo() {}
}

// 2. void foo() {} - methods
class Method2 {
  void foo() {}
}

// 3. void _foo() {} - private + methods
class Method3 {
  void _foo() {}
}

// 4. int? foo() {} - nullable + public + methods
class Method4 {
  int? foo() {
    return null;
  }
}

// 5. int? foo() {} - nullable + methods
class Method5 {
  int? foo() {
    return null;
  }
}

// 6. int? _foo() {} - nullable + private + methods
class Method6 {
  int? _foo() {
    return null;
  }
}

// 7. void foo(); - abstract + public + methods
abstract class Method7 {
  void foo();
}

// 8. void foo(); - abstract + methods
abstract class Method8 {
  void foo();
}

// 9. void _foo(); - abstract + private + methods
abstract class Method9 {
  void _foo();
}

// 10. int? foo(); - abstract + nullable + public + methods
abstract class Method10 {
  int? foo();
}

// 11. int? foo(); - abstract + nullable + methods
abstract class Method11 {
  int? foo();
}

// 12. int? _foo(); - abstract + nullable + private + methods
abstract class Method12 {
  int? _foo();
}

// 13. external void foo(); - external + public + methods
class Method13 {
  external void foo();
}

// 14. external void foo(); - external + methods
class Method14 {
  external void foo();
}

// 15. external void _foo(); - external + private + methods
class Method15 {
  external void _foo();
}

// 16. external int? foo(); - external + nullable + public + methods
class Method16 {
  external int? foo();
}

// 17. external int? foo(); - external + nullable + methods
class Method17 {
  external int? foo();
}

// 18. external int? _foo(); - external + nullable + private + methods
class Method18 {
  external int? _foo();
}

// 19. @override void foo() {} - overridden + public + methods
abstract class Method19 extends Base {
  @override
  void foo() {}
}

// 20. @override void foo() {} - overridden + methods
abstract class Method20 extends Base {
  @override
  void foo() {}
}

// 21. @override void _foo() {} - overridden + private + methods
abstract class Method21 extends Base {
  @override
  void _foo() {}
}

// 22. @override int? foo() {} - overridden + nullable + public + methods
abstract class Method22 extends Base {
  @override
  int? fooNullable() {
    return null;
  }
}

// 23. @override int? foo() {} - overridden + nullable + methods
abstract class Method23 extends Base {
  @override
  int? fooNullable() {
    return null;
  }
}

// 24. @override int? _foo() {} - overridden + nullable + private + methods
abstract class Method24 extends Base {
  @override
  int? _fooNullable() {
    return null;
  }
}

// 25. @override external void foo(); - overridden + external + public + methods
abstract class Method25 extends Base {
  @override
  external void fooExternal();
}

// 26. @override external void foo(); - overridden + external + methods
abstract class Method26 extends Base {
  @override
  external void fooExternal();
}

// 27. @override external void _foo(); - overridden + external + private + methods
abstract class Method27 extends Base {
  @override
  external void _fooExternal();
}

// 28. @override external int? foo(); - overridden + external + nullable + public + methods
abstract class Method28 extends Base {
  @override
  external int? fooExternalNullable();
}

// 29. @override external int? foo(); - overridden + external + nullable + methods
abstract class Method29 extends Base {
  @override
  external int? fooExternalNullable();
}

// 30. @override external int? _foo(); - overridden + external + nullable + private + methods
abstract class Method30 extends Base {
  @override
  external int? _fooExternalNullable();
}

// 31. @override void foo(); - overridden + abstract + public + methods
abstract class Method31 extends Base {
  @override
  void foo();
}

// 32. @override void foo(); - overridden + abstract + methods
abstract class Method32 extends Base {
  @override
  void foo();
}

// 33. @override void _foo(); - overridden + abstract + private + methods
abstract class Method33 extends Base {
  @override
  void _foo();
}

// 34. @override int? foo(); - overridden + abstract + nullable + public + methods
abstract class Method34 extends Base {
  @override
  int? fooNullable();
}

// 35. @override int? foo(); - overridden + abstract + nullable + methods
abstract class Method35 extends Base {
  @override
  int? fooNullable();
}

// 36. @override int? _foo(); - overridden + abstract + nullable + private + methods
abstract class Method36 extends Base {
  @override
  int? _fooNullable();
}

// ============================================================================
// Static Methods (12 patterns)
// ============================================================================

// 37. static void foo() {} - static + public + methods
class Method37 {
  static void foo() {}
}

// 38. static void foo() {} - static + methods
class Method38 {
  static void foo() {}
}

// 39. static void _foo() {} - static + private + methods
class Method39 {
  static void _foo() {}
}

// 40. static int? foo() {} - static + nullable + public + methods
class Method40 {
  static int? foo() {
    return null;
  }
}

// 41. static int? foo() {} - static + nullable + methods
class Method41 {
  static int? foo() {
    return null;
  }
}

// 42. static int? _foo() {} - static + nullable + private + methods
class Method42 {
  static int? _foo() {
    return null;
  }
}

// 43. external static void foo(); - external + static + public + methods
class Method43 {
  external static void foo();
}

// 44. external static void foo(); - external + static + methods
class Method44 {
  external static void foo();
}

// 45. external static void _foo(); - external + static + private + methods
class Method45 {
  external static void _foo();
}

// 46. external static int? foo(); - external + static + nullable + public + methods
class Method46 {
  external static int? foo();
}

// 47. external static int? foo(); - external + static + nullable + methods
class Method47 {
  external static int? foo();
}

// 48. external static int? _foo(); - external + static + nullable + private + methods
class Method48 {
  external static int? _foo();
}

// ============================================================================
// Operators (8 patterns)
// ============================================================================

// 49. T operator +(T other) {} - operator + methods
class Operator49 {
  Operator49 operator +(Operator49 other) => this;
}

// 50. T? operator +(T other) {} - operator + nullable + methods
class Operator50 {
  Operator50? operator +(Operator50 other) => this;
}

// 51. T operator +(T other); - abstract + operator + methods
abstract class Operator51 {
  Operator51 operator +(Operator51 other);
}

// 52. T? operator +(T other); - abstract + operator + nullable + methods
abstract class Operator52 {
  Operator52? operator +(Operator52 other);
}

// 53. external T operator +(T other); - external + operator + methods
class Operator53 {
  external Operator53 operator +(Operator53 other);
}

// 54. external T? operator +(T other); - external + operator + nullable + methods
class Operator54 {
  external Operator54? operator +(Operator54 other);
}

// 55. @override T operator +(T other) {} - overridden + operator + methods
abstract class Operator55 extends Base {
  @override
  Base operator +(Base other) => this;
}

// 56. @override T? operator -(T other) {} - overridden + operator + nullable + methods
abstract class Operator56 extends Base {
  @override
  Base? operator -(Base other) => this;
}
