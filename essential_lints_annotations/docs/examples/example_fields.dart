// Base class for override examples
// ignore_for_file: strict_top_level_inference, prefer_typing_uninitialized_variables, type_annotate_public_apis, specify_nonobvious_property_types, inference_failure_on_uninitialized_variable, unnecessary_late, prefer_const_declarations, prefer_final_fields, avoid_init_to_null, use_late_for_private_fields_and_variables, lines_longer_than_80_chars, unused_field

abstract class Base {
  abstract int foo;
  abstract int? fooNullable;
  abstract int _privateFoo;
  abstract int? _privateFooNullable;
}

// ============================================================================
// Instance Fields - Regular (9 patterns)
// ============================================================================

// 1. int foo = 0; - initialized + public + fields
class Field1 {
  int foo = 0;
}

// 2. int foo = 0; - initialized + fields
class Field2 {
  int foo = 0;
}

// 3. int _foo = 0; - initialized + private + fields
class Field3 {
  int _foo = 0;
}

// 4. int? foo; - nullable + public + fields
class Field4 {
  int? foo;
}

// 5. int? foo; - nullable + fields
class Field5 {
  int? foo;
}

// 6. int? _foo; - nullable + private + fields
class Field6 {
  int? _foo;
}

// 7. int? foo = null; - nullable + initialized + public + fields
class Field7 {
  int? foo = null;
}

// 8. int? foo = null; - nullable + initialized + fields
class Field8 {
  int? foo = null;
}

// 9. int? _foo = null; - nullable + initialized + private + fields
class Field9 {
  int? _foo = null;
}

// ============================================================================
// Instance Fields - Final (12 patterns)
// ============================================================================

// 10. final int foo = 0; - final + initialized + public + fields
class Field10 {
  final int foo = 0;
}

// 11. final int foo = 0; - final + initialized + fields
class Field11 {
  final int foo = 0;
}

// 12. final int _foo = 0; - final + initialized + private + fields
class Field12 {
  final int _foo = 0;
}

// 13. final int foo; - final + public + fields
class Field13 {
  Field13(this.foo);
  final int foo;
}

// 14. final int foo; - final + fields
class Field14 {
  Field14(this.foo);
  final int foo;
}

// 15. final int _foo; - final + private + fields
class Field15 {
  Field15(this._foo);
  final int _foo;
}

// 16. final int? foo; - final + nullable + public + fields
class Field16 {
  Field16(this.foo);
  final int? foo;
}

// 17. final int? foo; - final + nullable + fields
class Field17 {
  Field17(this.foo);
  final int? foo;
}

// 18. final int? _foo; - final + nullable + private + fields
class Field18 {
  Field18(this._foo);
  final int? _foo;
}

// 19. final int? foo = null; - final + nullable + initialized + public + fields
class Field19 {
  final int? foo = null;
}

// 20. final int? foo = null; - final + nullable + initialized + fields
class Field20 {
  final int? foo = null;
}

// 21. final int? _foo = null; - final + nullable + initialized + private + fields
class Field21 {
  final int? _foo = null;
}

// ============================================================================
// Instance Fields - Late (12 patterns)
// ============================================================================

// 22. late int foo; - late + public + fields
class Field22 {
  late int foo;
}

// 23. late int foo; - late + fields
class Field23 {
  late int foo;
}

// 24. late int _foo; - late + private + fields
class Field24 {
  late int _foo;
}

// 25. late int foo = 0; - late + initialized + public + fields
class Field25 {
  late int foo = 0;
}

// 26. late int foo = 0; - late + initialized + fields
class Field26 {
  late int foo = 0;
}

// 27. late int _foo = 0; - late + initialized + private + fields
class Field27 {
  late int _foo = 0;
}

// 28. late int? foo; - late + nullable + public + fields
class Field28 {
  late int? foo;
}

// 29. late int? foo; - late + nullable + fields
class Field29 {
  late int? foo;
}

// 30. late int? _foo; - late + nullable + private + fields
class Field30 {
  late int? _foo;
}

// 31. late int? foo = null; - late + nullable + initialized + public + fields
class Field31 {
  late int? foo = null;
}

// 32. late int? foo = null; - late + nullable + initialized + fields
class Field32 {
  late int? foo = null;
}

// 33. late int? _foo = null; - late + nullable + initialized + private + fields
class Field33 {
  late int? _foo = null;
}

// ============================================================================
// Instance Fields - Late Final (12 patterns)
// ============================================================================

// 34. late final int foo; - late + final + public + fields
class Field34 {
  late final int foo;
}

// 35. late final int foo; - late + final + fields
class Field35 {
  late final int foo;
}

// 36. late final int _foo; - late + final + private + fields
class Field36 {
  late final int _foo;
}

// 37. late final int foo = 0; - late + final + initialized + public + fields
class Field37 {
  late final int foo = 0;
}

// 38. late final int foo = 0; - late + final + initialized + fields
class Field38 {
  late final int foo = 0;
}

// 39. late final int _foo = 0; - late + final + initialized + private + fields
class Field39 {
  late final int _foo = 0;
}

// 40. late final int? foo; - late + final + nullable + public + fields
class Field40 {
  late final int? foo;
}

// 41. late final int? foo; - late + final + nullable + fields
class Field41 {
  late final int? foo;
}

// 42. late final int? _foo; - late + final + nullable + private + fields
class Field42 {
  late final int? _foo;
}

// 43. late final int? foo = null; - late + final + nullable + initialized + public + fields
class Field43 {
  late final int? foo = null;
}

// 44. late final int? foo = null; - late + final + nullable + initialized + fields
class Field44 {
  late final int? foo = null;
}

// 45. late final int? _foo = null; - late + final + nullable + initialized + private + fields
class Field45 {
  late final int? _foo = null;
}

// ============================================================================
// Instance Fields - Abstract (12 patterns)
// ============================================================================

// 46. abstract int foo; - abstract + public + fields
abstract class Field46 {
  abstract int foo;
}

// 47. abstract int foo; - abstract + fields
abstract class Field47 {
  abstract int foo;
}

// 48. abstract int _foo; - abstract + private + fields
abstract class Field48 {
  abstract int _foo;
}

// 49. abstract int? foo; - abstract + nullable + public + fields
abstract class Field49 {
  abstract int? foo;
}

// 50. abstract int? foo; - abstract + nullable + fields
abstract class Field50 {
  abstract int? foo;
}

// 51. abstract int? _foo; - abstract + nullable + private + fields
abstract class Field51 {
  abstract int? _foo;
}

// 52. abstract final int foo; - abstract + final + public + fields
abstract class Field52 {
  abstract final int foo;
}

// 53. abstract final int foo; - abstract + final + fields
abstract class Field53 {
  abstract final int foo;
}

// 54. abstract final int _foo; - abstract + final + private + fields
abstract class Field54 {
  abstract final int _foo;
}

// 55. abstract final int? foo; - abstract + final + nullable + public + fields
abstract class Field55 {
  abstract final int? foo;
}

// 56. abstract final int? foo; - abstract + final + nullable + fields
abstract class Field56 {
  abstract final int? foo;
}

// 57. abstract final int? _foo; - abstract + final + nullable + private + fields
abstract class Field57 {
  abstract final int? _foo;
}

// ============================================================================
// Instance Fields - External (12 patterns)
// ============================================================================

// 58. external int foo; - external + public + fields
class Field58 {
  external int foo;
}

// 59. external int foo; - external + fields
class Field59 {
  external int foo;
}

// 60. external int _foo; - external + private + fields
class Field60 {
  external int _foo;
}

// 61. external int? foo; - external + nullable + public + fields
class Field61 {
  external int? foo;
}

// 62. external int? foo; - external + nullable + fields
class Field62 {
  external int? foo;
}

// 63. external int? _foo; - external + nullable + private + fields
class Field63 {
  external int? _foo;
}

// 64. external final int foo; - external + final + public + fields
class Field64 {
  external final int foo;
}

// 65. external final int foo; - external + final + fields
class Field65 {
  external final int foo;
}

// 66. external final int _foo; - external + final + private + fields
class Field66 {
  external final int _foo;
}

// 67. external final int? foo; - external + final + nullable + public + fields
class Field67 {
  external final int? foo;
}

// 68. external final int? foo; - external + final + nullable + fields
class Field68 {
  external final int? foo;
}

// 69. external final int? _foo; - external + final + nullable + private + fields
class Field69 {
  external final int? _foo;
}

// ============================================================================
// Instance Fields - Overridden (18 patterns)
// ============================================================================

// 70. @override int foo = 0; - overridden + initialized + public + fields
abstract class Field70 extends Base {
  @override
  int foo = 0;
}

// 71. @override int foo = 0; - overridden + initialized + fields
abstract class Field71 extends Base {
  @override
  int foo = 0;
}

// 72. @override int _foo = 0; - overridden + initialized + private + fields
abstract class Field72 extends Base {
  @override
  int _privateFoo = 0;
}

// 73. @override int? foo; - overridden + nullable + public + fields
abstract class Field73 extends Base {
  @override
  int? fooNullable;
}

// 74. @override int? foo; - overridden + nullable + fields
abstract class Field74 extends Base {
  @override
  int? fooNullable;
}

// 75. @override int? _foo; - overridden + nullable + private + fields
abstract class Field75 extends Base {
  @override
  int? _privateFooNullable;
}

// 76. @override final int foo = 0; - overridden + final + initialized + public + fields
abstract class Field76 extends Base {
  @override
  final int foo = 0;
}

// 77. @override final int foo = 0; - overridden + final + initialized + fields
abstract class Field77 extends Base {
  @override
  final int foo = 0;
}

// 78. @override final int _foo = 0; - overridden + final + initialized + private + fields
abstract class Field78 extends Base {
  @override
  final int _privateFoo = 0;
}

// 79. @override final int? foo; - overridden + final + nullable + public + fields
abstract class Field79 extends Base {
  Field79(this.fooNullable);
  @override
  final int? fooNullable;
}

// 80. @override final int? foo; - overridden + final + nullable + fields
abstract class Field80 extends Base {
  Field80(this.fooNullable);
  @override
  final int? fooNullable;
}

// 81. @override final int? _foo; - overridden + final + nullable + private + fields
abstract class Field81 extends Base {
  Field81(this._privateFooNullable);
  @override
  final int? _privateFooNullable;
}

// 82. @override late int foo; - overridden + late + public + fields
abstract class Field82 extends Base {
  @override
  late int foo;
}

// 83. @override late int foo; - overridden + late + fields
abstract class Field83 extends Base {
  @override
  late int foo;
}

// 84. @override late int _foo; - overridden + late + private + fields
abstract class Field84 extends Base {
  @override
  late int _privateFoo;
}

// 85. @override late final int foo; - overridden + late + final + public + fields
abstract class Field85 extends Base {
  @override
  late final int foo;
}

// 86. @override late final int foo; - overridden + late + final + fields
abstract class Field86 extends Base {
  @override
  late final int foo;
}

// 87. @override late final int _foo; - overridden + late + final + private + fields
abstract class Field87 extends Base {
  @override
  late final int _privateFoo;
}

// ============================================================================
// Instance Fields - Var (18 patterns)
// ============================================================================

// 88. var foo = 0; - var + initialized + public + fields
class Field88 {
  var foo = 0;
}

// 89. var foo = 0; - var + initialized + fields
class Field89 {
  var foo = 0;
}

// 90. var _foo = 0; - var + initialized + private + fields
class Field90 {
  var _foo = 0;
}

// 91. late var foo; - var + late + public + fields
class Field91 {
  late var foo;
}

// 92. late var foo; - var + late + fields
class Field92 {
  late var foo;
}

// 93. late var _foo; - var + late + private + fields
class Field93 {
  late var _foo;
}

// 94. late var foo = 0; - var + late + initialized + public + fields
class Field94 {
  late var foo = 0;
}

// 95. late var foo = 0; - var + late + initialized + fields
class Field95 {
  late var foo = 0;
}

// 96. late var _foo = 0; - var + late + initialized + private + fields
class Field96 {
  late var _foo = 0;
}

// NOTE: Patterns 97-102 in documentation use invalid Dart syntax (late final var)
// These are commented out as Dart does not allow both 'final' and 'var' together
// The actual valid patterns would use 'late final' without 'var'

// 97. late final var foo; - var + late + final + public + fields (INVALID SYNTAX)
// class Field97 {
//   late final var foo;
// }

// 98. late final var foo; - var + late + final + fields (INVALID SYNTAX)
// class Field98 {
//   late final var foo;
// }

// 99. late final var _foo; - var + late + final + private + fields (INVALID SYNTAX)
// class Field99 {
//   late final var _foo;
// }

// 100. late final var foo = 0; - var + late + final + initialized + public + fields (INVALID SYNTAX)
// class Field100 {
//   late final var foo = 0;
// }

// 101. late final var foo = 0; - var + late + final + initialized + fields (INVALID SYNTAX)
// class Field101 {
//   late final var foo = 0;
// }

// 102. late final var _foo = 0; - var + late + final + initialized + private + fields (INVALID SYNTAX)
// class Field102 {
//   late final var _foo = 0;
// }

// 103. @override var foo = 0; - var + overridden + initialized + public + fields
abstract class Field103 extends Base {
  @override
  var foo = 0;
}

// 104. @override var foo = 0; - var + overridden + initialized + fields
abstract class Field104 extends Base {
  @override
  var foo = 0;
}

// 105. @override var _foo = 0; - var + overridden + initialized + private + fields
abstract class Field105 extends Base {
  @override
  var _privateFoo = 0;
}

// NOTE: Patterns 106-108 are missing from the documentation
// There is a gap in numbering between pattern 105 and 109

// ============================================================================
// Static Fields - Regular (15 patterns)
// ============================================================================

// 109. static int foo = 0; - static + initialized + public + fields
class Field109 {
  static int foo = 0;
}

// 110. static int foo = 0; - static + initialized + fields
class Field110 {
  static int foo = 0;
}

// 111. static int _foo = 0; - static + initialized + private + fields
class Field111 {
  static int _foo = 0;
}

// 112. static int? foo; - static + nullable + public + fields
class Field112 {
  static int? foo;
}

// 113. static int? foo; - static + nullable + fields
class Field113 {
  static int? foo;
}

// 114. static int? _foo; - static + nullable + private + fields
class Field114 {
  static int? _foo;
}

// 115. static int? foo = null; - static + nullable + initialized + public + fields
class Field115 {
  static int? foo = null;
}

// 116. static int? foo = null; - static + nullable + initialized + fields
class Field116 {
  static int? foo = null;
}

// 117. static int? _foo = null; - static + nullable + initialized + private + fields
class Field117 {
  static int? _foo = null;
}

// 118. static final int foo = 0; - static + final + initialized + public + fields
class Field118 {
  static final int foo = 0;
}

// 119. static final int foo = 0; - static + final + initialized + fields
class Field119 {
  static final int foo = 0;
}

// 120. static final int _foo = 0; - static + final + initialized + private + fields
class Field120 {
  static final int _foo = 0;
}

// 121. static final int? foo = null; - static + final + nullable + initialized + public + fields
class Field121 {
  static final int? foo = null;
}

// 122. static final int? foo = null; - static + final + nullable + initialized + fields
class Field122 {
  static final int? foo = null;
}

// 123. static final int? _foo = null; - static + final + nullable + initialized + private + fields
class Field123 {
  static final int? _foo = null;
}

// ============================================================================
// Static Fields - Const (6 patterns)
// ============================================================================

// 124. static const int foo = 0; - static + const + initialized + public + fields
class Field124 {
  static const int foo = 0;
}

// 125. static const int foo = 0; - static + const + initialized + fields
class Field125 {
  static const int foo = 0;
}

// 126. static const int _foo = 0; - static + const + initialized + private + fields
class Field126 {
  static const int _foo = 0;
}

// 127. static const int? foo = null; - static + const + nullable + initialized + public + fields
class Field127 {
  static const int? foo = null;
}

// 128. static const int? foo = null; - static + const + nullable + initialized + fields
class Field128 {
  static const int? foo = null;
}

// 129. static const int? _foo = null; - static + const + nullable + initialized + private + fields
class Field129 {
  static const int? _foo = null;
}

// ============================================================================
// Static Fields - Late (24 patterns)
// ============================================================================

// 130. static late int foo; - static + late + public + fields
class Field130 {
  static late int foo;
}

// 131. static late int foo; - static + late + fields
class Field131 {
  static late int foo;
}

// 132. static late int _foo; - static + late + private + fields
class Field132 {
  static late int _foo;
}

// 133. static late int foo = 0; - static + late + initialized + public + fields
class Field133 {
  static late int foo = 0;
}

// 134. static late int foo = 0; - static + late + initialized + fields
class Field134 {
  static late int foo = 0;
}

// 135. static late int _foo = 0; - static + late + initialized + private + fields
class Field135 {
  static late int _foo = 0;
}

// 136. static late int? foo; - static + late + nullable + public + fields
class Field136 {
  static late int? foo;
}

// 137. static late int? foo; - static + late + nullable + fields
class Field137 {
  static late int? foo;
}

// 138. static late int? _foo; - static + late + nullable + private + fields
class Field138 {
  static late int? _foo;
}

// 139. static late int? foo = null; - static + late + nullable + initialized + public + fields
class Field139 {
  static late int? foo = null;
}

// 140. static late int? foo = null; - static + late + nullable + initialized + fields
class Field140 {
  static late int? foo = null;
}

// 141. static late int? _foo = null; - static + late + nullable + initialized + private + fields
class Field141 {
  static late int? _foo = null;
}

// 142. static late final int foo; - static + late + final + public + fields
class Field142 {
  static late final int foo;
}

// 143. static late final int foo; - static + late + final + fields
class Field143 {
  static late final int foo;
}

// 144. static late final int _foo; - static + late + final + private + fields
class Field144 {
  static late final int _foo;
}

// 145. static late final int foo = 0; - static + late + final + initialized + public + fields
class Field145 {
  static late final int foo = 0;
}

// 146. static late final int foo = 0; - static + late + final + initialized + fields
class Field146 {
  static late final int foo = 0;
}

// 147. static late final int _foo = 0; - static + late + final + initialized + private + fields
class Field147 {
  static late final int _foo = 0;
}

// 148. static late final int? foo; - static + late + final + nullable + public + fields
class Field148 {
  static late final int? foo;
}

// 149. static late final int? foo; - static + late + final + nullable + fields
class Field149 {
  static late final int? foo;
}

// 150. static late final int? _foo; - static + late + final + nullable + private + fields
class Field150 {
  static late final int? _foo;
}

// 151. static late final int? foo = null; - static + late + final + nullable + initialized + public + fields
class Field151 {
  static late final int? foo = null;
}

// 152. static late final int? foo = null; - static + late + final + nullable + initialized + fields
class Field152 {
  static late final int? foo = null;
}

// 153. static late final int? _foo = null; - static + late + final + nullable + initialized + private + fields
class Field153 {
  static late final int? _foo = null;
}

// ============================================================================
// Static Fields - External (12 patterns)
// ============================================================================

// 154. external static int foo; - external + static + public + fields
class Field154 {
  external static int foo;
}

// 155. external static int foo; - external + static + fields
class Field155 {
  external static int foo;
}

// 156. external static int _foo; - external + static + private + fields
class Field156 {
  external static int _foo;
}

// 157. external static int? foo; - external + static + nullable + public + fields
class Field157 {
  external static int? foo;
}

// 158. external static int? foo; - external + static + nullable + fields
class Field158 {
  external static int? foo;
}

// 159. external static int? _foo; - external + static + nullable + private + fields
class Field159 {
  external static int? _foo;
}

// 160. external static final int foo; - external + static + final + public + fields
class Field160 {
  external static final int foo;
}

// 161. external static final int foo; - external + static + final + fields
class Field161 {
  external static final int foo;
}

// 162. external static final int _foo; - external + static + final + private + fields
class Field162 {
  external static final int _foo;
}

// 163. external static final int? foo; - external + static + final + nullable + public + fields
class Field163 {
  external static final int? foo;
}

// 164. external static final int? foo; - external + static + final + nullable + fields
class Field164 {
  external static final int? foo;
}

// 165. external static final int? _foo; - external + static + final + nullable + private + fields
class Field165 {
  external static final int? _foo;
}
