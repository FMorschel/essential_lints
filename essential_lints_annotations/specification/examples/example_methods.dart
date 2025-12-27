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

// 1. void foo() {} - instance + typed + public + methods
class Method1 {
  void foo() {}
}

// 2. void foo() {} - instance + typed + methods
class Method2 {
  void foo() {}
}

// 3. void _foo() {} - instance + typed + private + methods
class Method3 {
  void _foo() {}
}

// 4. int? foo() {} - instance + typed + nullable + public + methods
class Method4 {
  int? foo() {
    return null;
  }
}

// 5. int? foo() {} - instance + typed + nullable + methods
class Method5 {
  int? foo() {
    return null;
  }
}

// 6. int? _foo() {} - instance + typed + nullable + private + methods
class Method6 {
  int? _foo() {
    return null;
  }
}

// 7. void foo(); - instance + typed + abstract + public + methods
abstract class Method7 {
  void foo();
}

// 8. void foo(); - instance + typed + abstract + methods
abstract class Method8 {
  void foo();
}

// 9. void _foo(); - instance + typed + abstract + private + methods
abstract class Method9 {
  void _foo();
}

// 10. int? foo(); - instance + typed + abstract + nullable + public + methods
abstract class Method10 {
  int? foo();
}

// 11. int? foo(); - instance + typed + abstract + nullable + methods
abstract class Method11 {
  int? foo();
}

// 12. int? _foo(); - instance + typed + abstract + nullable + private + methods
abstract class Method12 {
  int? _foo();
}

// 13. external void foo(); - external + instance + typed + public + methods
class Method13 {
  external void foo();
}

// 14. external void foo(); - external + instance + typed + methods
class Method14 {
  external void foo();
}

// 15. external void _foo(); - external + instance + typed + private + methods
class Method15 {
  external void _foo();
}

// 16. external int? foo(); - external + instance + typed + nullable + public + methods
class Method16 {
  external int? foo();
}

// 17. external int? foo(); - external + instance + typed + nullable + methods
class Method17 {
  external int? foo();
}

// 18. external int? _foo(); - external + instance + typed + nullable + private + methods
class Method18 {
  external int? _foo();
}

// 19. @override void foo() {} - instance + overridden + typed + public + methods
abstract class Method19 extends Base {
  @override
  void foo() {}
}

// 20. @override void foo() {} - instance + overridden + typed + methods
abstract class Method20 extends Base {
  @override
  void foo() {}
}

// 21. @override void _foo() {} - instance + overridden + typed + private + methods
abstract class Method21 extends Base {
  @override
  void _foo() {}
}

// 22. @override int? foo() {} - instance + overridden + typed + nullable + public + methods
abstract class Method22 extends Base {
  @override
  int? fooNullable() {
    return null;
  }
}

// 23. @override int? foo() {} - instance + overridden + typed + nullable + methods
abstract class Method23 extends Base {
  @override
  int? fooNullable() {
    return null;
  }
}

// 24. @override int? _foo() {} - instance + overridden + typed + nullable + private + methods
abstract class Method24 extends Base {
  @override
  int? _fooNullable() {
    return null;
  }
}

// 25. @override external void foo(); - external + instance + overridden + typed + public + methods
abstract class Method25 extends Base {
  @override
  external void fooExternal();
}

// 26. @override external void foo(); - external + instance + overridden + typed + methods
abstract class Method26 extends Base {
  @override
  external void fooExternal();
}

// 27. @override external void _foo(); - external + instance + overridden + typed + private + methods
abstract class Method27 extends Base {
  @override
  external void _fooExternal();
}

// 28. @override external int? foo(); - external + instance + overridden + typed + nullable + public + methods
abstract class Method28 extends Base {
  @override
  external int? fooExternalNullable();
}

// 29. @override external int? foo(); - external + instance + overridden + typed + nullable + methods
abstract class Method29 extends Base {
  @override
  external int? fooExternalNullable();
}

// 30. @override external int? _foo(); - external + instance + overridden + typed + nullable + private + methods
abstract class Method30 extends Base {
  @override
  external int? _fooExternalNullable();
}

// 31. @override void foo(); - instance + overridden + typed + abstract + public + methods
abstract class Method31 extends Base {
  @override
  void foo();
}

// 32. @override void foo(); - instance + overridden + typed + abstract + methods
abstract class Method32 extends Base {
  @override
  void foo();
}

// 33. @override void _foo(); - instance + overridden + typed + abstract + private + methods
abstract class Method33 extends Base {
  @override
  void _foo();
}

// 34. @override int? foo(); - instance + overridden + typed + abstract + nullable + public + methods
abstract class Method34 extends Base {
  @override
  int? fooNullable();
}

// 35. @override int? foo(); - instance + overridden + typed + abstract + nullable + methods
abstract class Method35 extends Base {
  @override
  int? fooNullable();
}

// 36. @override int? _foo(); - instance + overridden + typed + abstract + nullable + private + methods
abstract class Method36 extends Base {
  @override
  int? _fooNullable();
}

// ============================================================================
// Static Methods (12 patterns)
// ============================================================================

// 37. static void foo() {} - static + typed + public + methods
class Method37 {
  static void foo() {}
}

// 38. static void foo() {} - static + typed + methods
class Method38 {
  static void foo() {}
}

// 39. static void _foo() {} - static + typed + private + methods
class Method39 {
  static void _foo() {}
}

// 40. static int? foo() {} - static + typed + nullable + public + methods
class Method40 {
  static int? foo() {
    return null;
  }
}

// 41. static int? foo() {} - static + typed + nullable + methods
class Method41 {
  static int? foo() {
    return null;
  }
}

// 42. static int? _foo() {} - static + typed + nullable + private + methods
class Method42 {
  static int? _foo() {
    return null;
  }
}

// 43. external static void foo(); - external + static + typed + public + methods
class Method43 {
  external static void foo();
}

// 44. external static void foo(); - external + static + typed + methods
class Method44 {
  external static void foo();
}

// 45. external static void _foo(); - external + static + typed + private + methods
class Method45 {
  external static void _foo();
}

// 46. external static int? foo(); - external + static + typed + nullable + public + methods
class Method46 {
  external static int? foo();
}

// 47. external static int? foo(); - external + static + typed + nullable + methods
class Method47 {
  external static int? foo();
}

// 48. external static int? _foo(); - external + static + typed + nullable + private + methods
class Method48 {
  external static int? _foo();
}

// ============================================================================
// Operators (8 patterns)
// ============================================================================

// 49. T operator +(T other) {} - instance + typed + operator + methods
class Operator49 {
  Operator49 operator +(Operator49 other) => this;
}

// 50. T? operator +(T other) {} - instance + typed + operator + nullable + methods
class Operator50 {
  Operator50? operator +(Operator50 other) => this;
}

// 51. T operator +(T other); - instance + typed + abstract + operator + methods
abstract class Operator51 {
  Operator51 operator +(Operator51 other);
}

// 52. T? operator +(T other); - instance + typed + abstract + operator + nullable + methods
abstract class Operator52 {
  Operator52? operator +(Operator52 other);
}

// 53. external T operator +(T other); - external + instance + typed + operator + methods
class Operator53 {
  external Operator53 operator +(Operator53 other);
}

// 54. external T? operator +(T other); - external + instance + typed + operator + nullable + methods
class Operator54 {
  external Operator54? operator +(Operator54 other);
}

// 55. @override T operator +(T other) {} - instance + overridden + typed + operator + methods
abstract class Operator55 extends Base {
  @override
  Base operator +(Base other) => this;
}

// 56. @override T? operator -(T other) {} - instance + overridden + typed + operator + nullable + methods
abstract class Operator56 extends Base {
  @override
  Base? operator -(Base other) => this;
}
