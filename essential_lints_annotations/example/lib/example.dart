import 'package:essential_lints_annotations/essential_lints_annotations.dart' as ela;

/// Example of subtype naming convention.
///
/// To clone this example, run:
///
/// ```sh
/// dart pub global activate essential_lints_annotations
/// dart pub global run essential_lints_annotations:get_example
/// ```
@ela.SubtypeNaming(prefix: 'Foo')
mixin class Foo {}

class BarFoo extends Foo {}

class Baz extends Foo {}

class Qux implements Foo {}

class Other with Foo {}

