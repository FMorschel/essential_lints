// ignore_for_file: lines_longer_than_80_chars, unused_element just examples

// Base class for redirecting constructors
class Base {
  const Base();
  const Base.named();
  const Base._();
}

// ============================================================================
// Unnamed Constructors (18 patterns)
// ============================================================================

// 1. A(); - unnamed + constructors
class Constructor1 {
  Constructor1();
}

// 2. A(); - (public) + constructors
class Constructor2 {
  Constructor2();
}

// 3. const A(); - const + unnamed + constructors
class Constructor3 {
  const Constructor3();
}

// 4. const A(); - const + (public) + constructors
class Constructor4 {
  const Constructor4();
}

// 5. external A(); - external + unnamed + constructors
class Constructor5 {
  external Constructor5();
}

// 6. external A(); - external + (public) + constructors
class Constructor6 {
  external Constructor6();
}

// 7. external const A(); - external + const + unnamed + constructors
class Constructor7 {
  external const Constructor7();
}

// 8. external const A(); - external + const + (public) + constructors
class Constructor8 {
  external const Constructor8();
}

// 9. factory A() { ... } - factory + unnamed + constructors
class Constructor9 {
  factory Constructor9() => Constructor9._();
  Constructor9._();
}

// 10. factory A() { ... } - factory + (public) + constructors
class Constructor10 {
  factory Constructor10() => Constructor10._();
  Constructor10._();
}

// 11. external factory A(); - external + factory + unnamed + constructors
class Constructor11 {
  external factory Constructor11();
}

// 12. external factory A(); - external + factory + (public) + constructors
class Constructor12 {
  external factory Constructor12();
}

// 13. factory A() = B; - factory + redirecting + unnamed + constructors
class Constructor13 extends Base {
  factory Constructor13() = Constructor13._;
  Constructor13._() : super();
}

// 14. factory A() = B; - factory + redirecting + (public) + constructors
class Constructor14 extends Base {
  factory Constructor14() = Constructor14._;
  Constructor14._() : super();
}

// 15. const factory A() = B; - const + factory + redirecting + unnamed + constructors
class Constructor15 extends Base {
  const factory Constructor15() = Constructor15._;
  const Constructor15._() : super();
}

// 16. const factory A() = B; - const + factory + redirecting + (public) + constructors
class Constructor16 extends Base {
  const factory Constructor16() = Constructor16._;
  const Constructor16._() : super();
}

// 17. external const factory A(); - external + const + factory + unnamed + constructors
class Constructor17 {
  external const factory Constructor17();
}

// 18. external const factory A(); - external + const + factory + (public) + constructors
class Constructor18 {
  external const factory Constructor18();
}

// ============================================================================
// Named Constructors - Public (18 patterns)
// ============================================================================

// 19. A.named(); - named + constructors
class Constructor19 {
  Constructor19.named();
}

// 20. A.named(); - (public) + constructors
class Constructor20 {
  Constructor20.named();
}

// 21. const A.named(); - const + named + constructors
class Constructor21 {
  const Constructor21.named();
}

// 22. const A.named(); - const + (public) + constructors
class Constructor22 {
  const Constructor22.named();
}

// 23. external A.named(); - external + named + constructors
class Constructor23 {
  external Constructor23.named();
}

// 24. external A.named(); - external + (public) + constructors
class Constructor24 {
  external Constructor24.named();
}

// 25. external const A.named(); - external + const + named + constructors
class Constructor25 {
  external const Constructor25.named();
}

// 26. external const A.named(); - external + const + (public) + constructors
class Constructor26 {
  external const Constructor26.named();
}

// 27. factory A.named() { ... } - factory + named + constructors
class Constructor27 {
  factory Constructor27.named() => Constructor27._();
  Constructor27._();
}

// 28. factory A.named() { ... } - factory + (public) + constructors
class Constructor28 {
  factory Constructor28.named() => Constructor28._();
  Constructor28._();
}

// 29. external factory A.named(); - external + factory + named + constructors
class Constructor29 {
  external factory Constructor29.named();
}

// 30. external factory A.named(); - external + factory + (public) + constructors
class Constructor30 {
  external factory Constructor30.named();
}

// 31. factory A.named() = B; - factory + redirecting + named + constructors
class Constructor31 extends Base {
  factory Constructor31.named() = Constructor31._;
  Constructor31._() : super();
}

// 32. factory A.named() = B; - factory + redirecting + (public) + constructors
class Constructor32 extends Base {
  factory Constructor32.named() = Constructor32._;
  Constructor32._() : super();
}

// 33. const factory A.named() = B; - const + factory + redirecting + named + constructors
class Constructor33 extends Base {
  const factory Constructor33.named() = Constructor33._;
  const Constructor33._() : super();
}

// 34. const factory A.named() = B; - const + factory + redirecting + (public) + constructors
class Constructor34 extends Base {
  const factory Constructor34.named() = Constructor34._;
  const Constructor34._() : super();
}

// 35. external const factory A.named(); - external + const + factory + named + constructors
class Constructor35 {
  external const factory Constructor35.named();
}

// 36. external const factory A.named(); - external + const + factory + (public) + constructors
class Constructor36 {
  external const factory Constructor36.named();
}

// ============================================================================
// Named Constructors - Private (27 patterns)
// ============================================================================

// 37. A._(); - named + constructors
class Constructor37 {
  Constructor37._();
}

// 38. A._(); - private + constructors
class Constructor38 {
  Constructor38._();
}

// 39. A._(); - named + private + constructors
class Constructor39 {
  Constructor39._();
}

// 40. const A._(); - const + named + constructors
class Constructor40 {
  const Constructor40._();
}

// 41. const A._(); - const + private + constructors
class Constructor41 {
  const Constructor41._();
}

// 42. const A._(); - const + named + private + constructors
class Constructor42 {
  const Constructor42._();
}

// 43. external A._(); - external + named + constructors
class Constructor43 {
  external Constructor43._();
}

// 44. external A._(); - external + private + constructors
class Constructor44 {
  external Constructor44._();
}

// 45. external A._(); - external + named + private + constructors
class Constructor45 {
  external Constructor45._();
}

// 46. external const A._(); - external + const + named + constructors
class Constructor46 {
  external const Constructor46._();
}

// 47. external const A._(); - external + const + private + constructors
class Constructor47 {
  external const Constructor47._();
}

// 48. external const A._(); - external + const + named + private + constructors
class Constructor48 {
  external const Constructor48._();
}

// 49. factory A._() { ... } - factory + named + constructors
class Constructor49 {
  factory Constructor49._() => Constructor49._internal();
  Constructor49._internal();
}

// 50. factory A._() { ... } - factory + private + constructors
class Constructor50 {
  factory Constructor50._() => Constructor50._internal();
  Constructor50._internal();
}

// 51. factory A._() { ... } - factory + named + private + constructors
class Constructor51 {
  factory Constructor51._() => Constructor51._internal();
  Constructor51._internal();
}

// 52. external factory A._(); - external + factory + named + constructors
class Constructor52 {
  external factory Constructor52._();
}

// 53. external factory A._(); - external + factory + private + constructors
class Constructor53 {
  external factory Constructor53._();
}

// 54. external factory A._(); - external + factory + named + private + constructors
class Constructor54 {
  external factory Constructor54._();
}

// 55. factory A._() = B; - factory + redirecting + named + constructors
class Constructor55 extends Base {
  factory Constructor55._() = Constructor55._internal;
  Constructor55._internal() : super();
}

// 56. factory A._() = B; - factory + redirecting + private + constructors
class Constructor56 extends Base {
  factory Constructor56._() = Constructor56._internal;
  Constructor56._internal() : super();
}

// 57. factory A._() = B; - factory + redirecting + named + private + constructors
class Constructor57 extends Base {
  factory Constructor57._() = Constructor57._internal;
  Constructor57._internal() : super();
}

// 58. const factory A._() = B; - const + factory + redirecting + named + constructors
class Constructor58 extends Base {
  const factory Constructor58._() = Constructor58._internal;
  const Constructor58._internal() : super();
}

// 59. const factory A._() = B; - const + factory + redirecting + private + constructors
class Constructor59 extends Base {
  const factory Constructor59._() = Constructor59._internal;
  const Constructor59._internal() : super();
}

// 60. const factory A._() = B; - const + factory + redirecting + named + private + constructors
class Constructor60 extends Base {
  const factory Constructor60._() = Constructor60._internal;
  const Constructor60._internal() : super();
}

// 61. external const factory A._(); - external + const + factory + named + constructors
class Constructor61 {
  external const factory Constructor61._();
}

// 62. external const factory A._(); - external + const + factory + private + constructors
class Constructor62 {
  external const factory Constructor62._();
}

// 63. external const factory A._(); - external + const + factory + named + private + constructors
class Constructor63 {
  external const factory Constructor63._();
}
