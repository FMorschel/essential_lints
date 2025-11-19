import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';

mixin FlutterDependencyMixin on AnalysisRuleTest {
  late final flutterFolder = newFolder('/packages/flutter');

  void createFlutterMock() {
    newFile(
      join(flutterFolder.path, 'lib', 'src', 'widgets', 'framework.dart'),
      '''
abstract class BuildContext {}
abstract class Widget {}
abstract class StatelessWidget extends Widget {
  Widget build(BuildContext context);
}
abstract class StatefulWidget extends Widget {}
abstract class State<T extends StatefulWidget> {
  Widget build(BuildContext context);
}
''',
    );
    newFile(
      join(flutterFolder.path, 'lib', 'src', 'widgets', 'framework.dart'),
      '''
abstract class BuildContext {}
abstract class Widget {
  const Widget();
}
abstract class StatelessWidget extends Widget {
  const StatelessWidget();
  Widget build(BuildContext context);
}
abstract class StatefulWidget extends Widget {
  const StatefulWidget();
}
abstract class State<T extends StatefulWidget> {
  void setState(VoidCallback fn);
  void initState() {}
  void didChangeDependencies() {}
  void didUpdateWidget(covariant T oldWidget) {}
  void dispose() {}
  Widget build(BuildContext context);
}
''',
    );
    newFile(
      join(flutterFolder.path, 'lib', 'src', 'widgets', 'container.dart'),
      '''
import 'framework.dart';
import '../painting/edge_insets.dart';

class Container extends Widget {
  Container({Widget? child, EdgeInsets? padding});
}
''',
    );
    newFile(
      join(flutterFolder.path, 'lib', 'src', 'widgets', 'basic.dart'),
      '''
import 'framework.dart';
import '../painting/edge_insets.dart';

export '../../painting.dart';
export '../../foundation.dart' show Listenable;

class Padding extends Widget {
  const Padding({required EdgeInsets padding, Widget? child});
}

class SizedBox extends Widget {
  const SizedBox.shrink();
}
''',
    );
    newFile(
      join(
        flutterFolder.path,
        'lib',
        'src',
        'foundation',
        'change_notifier.dart',
      ),
      '''
typedef VoidCallback = void Function();

abstract class Listenable {
  const Listenable();
  void addListener(VoidCallback listener);
  void removeListener(VoidCallback listener);
}

mixin class ChangeNotifier implements Listenable {
  void dispose() {}
}
''',
    );
    newFile(
      join(
        flutterFolder.path,
        'lib',
        'foundation.dart',
      ),
      '''
export 'src/foundation/change_notifier.dart';
''',
    );
    newFile(
      join(flutterFolder.path, 'lib', 'src', 'painting', 'edge_insets.dart'),
      '''
class EdgeInsets {
  const EdgeInsets.all(double value);
}
''',
    );
    newFile(
      join(flutterFolder.path, 'lib', 'src', 'painting', 'borders.dart'),
      '''
enum BorderStyle { none, solid, }

class BorderSide {
  const BorderSide({
    Color color = const Color(0xFF000000),
    double width = 1.0,
    BorderStyle style = BorderStyle.solid,
    double strokeAlign = strokeAlignInside,
  });

  static const double strokeAlignInside = -1.0;
}
''',
    );
    newFile(
      join(flutterFolder.path, 'lib', 'src', 'painting', 'box_border.dart'),
      '''
import 'borders.dart';

class Border {
  const Border();

  factory Border.all({
    Color color = const Color(0xFF000000),
    double width = 1.0,
    BorderStyle style = BorderStyle.solid,
    double strokeAlign = BorderSide.strokeAlignInside,
  }) => Border();

  const Border.fromBorderSide(BorderSide side);
}
''',
    );
    newFile(
      join(flutterFolder.path, 'lib', 'painting.dart'),
      '''
export 'src/painting/borders.dart';
export 'src/painting/box_border.dart';
export 'src/painting/edge_insets.dart';
''',
    );
    newFile(join(flutterFolder.path, 'lib', 'widgets.dart'), '''
export 'src/widgets/framework.dart';
export 'src/widgets/container.dart';
export 'src/widgets/basic.dart';
''');
  }
}
