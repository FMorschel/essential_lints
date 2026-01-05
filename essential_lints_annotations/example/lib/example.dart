import 'package:essential_lints_annotations/essential_lints_annotations.dart' as ela;

@ela.SubtypeNaming(prefix: 'Foo')
mixin class Foo {}

class BarFoo extends Foo {}

class Baz extends Foo {}

class Qux implements Foo {}

class Other with Foo {}

