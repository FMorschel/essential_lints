// Base class for override examples
// ignore_for_file: lines_longer_than_80_chars, unused_element, avoid_setters_without_getters

abstract class Base {
  set foo(int value);
  set _foo(int value);
  set fooNullable(int? value);
  set _fooNullable(int? value);
  external set fooExternal(int value);
  external set _fooExternal(int value);
  external set fooExternalNullable(int? value);
  external set _fooExternalNullable(int? value);
}

// ============================================================================
// Instance Setters (36 patterns)
// ============================================================================

// 1. set foo(int value) {} - (public) + setters
class Setter1 {
  set foo(int value) {}
}

// 2. set foo(int value) {} - setters
class Setter2 {
  set foo(int value) {}
}

// 3. set _foo(int value) {} - private + setters
class Setter3 {
  set _foo(int value) {}
}

// 4. set foo(int? value) {} - nullable + (public) + setters
class Setter4 {
  set foo(int? value) {}
}

// 5. set foo(int? value) {} - nullable + setters
class Setter5 {
  set foo(int? value) {}
}

// 6. set _foo(int? value) {} - nullable + private + setters
class Setter6 {
  set _foo(int? value) {}
}

// 7. set foo(int value); - abstract + (public) + setters
abstract class Setter7 {
  set foo(int value);
}

// 8. set foo(int value); - abstract + setters
abstract class Setter8 {
  set foo(int value);
}

// 9. set _foo(int value); - abstract + private + setters
abstract class Setter9 {
  set _foo(int value);
}

// 10. set foo(int? value); - abstract + nullable + (public) + setters
abstract class Setter10 {
  set foo(int? value);
}

// 11. set foo(int? value); - abstract + nullable + setters
abstract class Setter11 {
  set foo(int? value);
}

// 12. set _foo(int? value); - abstract + nullable + private + setters
abstract class Setter12 {
  set _foo(int? value);
}

// 13. external set foo(int value); - external + (public) + setters
class Setter13 {
  external set foo(int value);
}

// 14. external set foo(int value); - external + setters
class Setter14 {
  external set foo(int value);
}

// 15. external set _foo(int value); - external + private + setters
class Setter15 {
  external set _foo(int value);
}

// 16. external set foo(int? value); - external + nullable + (public) + setters
class Setter16 {
  external set foo(int? value);
}

// 17. external set foo(int? value); - external + nullable + setters
class Setter17 {
  external set foo(int? value);
}

// 18. external set _foo(int? value); - external + nullable + private + setters
class Setter18 {
  external set _foo(int? value);
}

// 19. @override set foo(int value) {} - overridden + (public) + setters
abstract class Setter19 extends Base {
  @override
  set foo(int value) {}
}

// 20. @override set foo(int value) {} - overridden + setters
abstract class Setter20 extends Base {
  @override
  set foo(int value) {}
}

// 21. @override set _foo(int value) {} - overridden + private + setters
abstract class Setter21 extends Base {
  @override
  set _foo(int value) {}
}

// 22. @override set foo(int? value) {} - overridden + nullable + (public) + setters
abstract class Setter22 extends Base {
  @override
  set fooNullable(int? value) {}
}

// 23. @override set foo(int? value) {} - overridden + nullable + setters
abstract class Setter23 extends Base {
  @override
  set fooNullable(int? value) {}
}

// 24. @override set _foo(int? value) {} - overridden + nullable + private + setters
abstract class Setter24 extends Base {
  @override
  set _fooNullable(int? value) {}
}

// 25. @override external set foo(int value); - overridden + external + (public) + setters
abstract class Setter25 extends Base {
  @override
  external set fooExternal(int value);
}

// 26. @override external set foo(int value); - overridden + external + setters
abstract class Setter26 extends Base {
  @override
  external set fooExternal(int value);
}

// 27. @override external set _foo(int value); - overridden + external + private + setters
abstract class Setter27 extends Base {
  @override
  external set _fooExternal(int value);
}

// 28. @override external set foo(int? value); - overridden + external + nullable + (public) + setters
abstract class Setter28 extends Base {
  @override
  external set fooExternalNullable(int? value);
}

// 29. @override external set foo(int? value); - overridden + external + nullable + setters
abstract class Setter29 extends Base {
  @override
  external set fooExternalNullable(int? value);
}

// 30. @override external set _foo(int? value); - overridden + external + nullable + private + setters
abstract class Setter30 extends Base {
  @override
  external set _fooExternalNullable(int? value);
}

// 31. @override set foo(int value); - overridden + abstract + (public) + setters
abstract class Setter31 extends Base {
  @override
  set foo(int value);
}

// 32. @override set foo(int value); - overridden + abstract + setters
abstract class Setter32 extends Base {
  @override
  set foo(int value);
}

// 33. @override set _foo(int value); - overridden + abstract + private + setters
abstract class Setter33 extends Base {
  @override
  set _foo(int value);
}

// 34. @override set foo(int? value); - overridden + abstract + nullable + (public) + setters
abstract class Setter34 extends Base {
  @override
  set fooNullable(int? value);
}

// 35. @override set foo(int? value); - overridden + abstract + nullable + setters
abstract class Setter35 extends Base {
  @override
  set fooNullable(int? value);
}

// 36. @override set _foo(int? value); - overridden + abstract + nullable + private + setters
abstract class Setter36 extends Base {
  @override
  set _fooNullable(int? value);
}

// ============================================================================
// Static Setters (12 patterns)
// ============================================================================

// 37. static set foo(int value) {} - static + (public) + setters
class Setter37 {
  static set foo(int value) {}
}

// 38. static set foo(int value) {} - static + setters
class Setter38 {
  static set foo(int value) {}
}

// 39. static set _foo(int value) {} - static + private + setters
class Setter39 {
  static set _foo(int value) {}
}

// 40. static set foo(int? value) {} - static + nullable + (public) + setters
class Setter40 {
  static set foo(int? value) {}
}

// 41. static set foo(int? value) {} - static + nullable + setters
class Setter41 {
  static set foo(int? value) {}
}

// 42. static set _foo(int? value) {} - static + nullable + private + setters
class Setter42 {
  static set _foo(int? value) {}
}

// 43. external static set foo(int value); - external + static + (public) + setters
class Setter43 {
  external static set foo(int value);
}

// 44. external static set foo(int value); - external + static + setters
class Setter44 {
  external static set foo(int value);
}

// 45. external static set _foo(int value); - external + static + private + setters
class Setter45 {
  external static set _foo(int value);
}

// 46. external static set foo(int? value); - external + static + nullable + (public) + setters
class Setter46 {
  external static set foo(int? value);
}

// 47. external static set foo(int? value); - external + static + nullable + setters
class Setter47 {
  external static set foo(int? value);
}

// 48. external static set _foo(int? value); - external + static + nullable + private + setters
class Setter48 {
  external static set _foo(int? value);
}
