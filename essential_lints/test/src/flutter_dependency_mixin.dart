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
      join(flutterFolder.path, 'lib', 'src', 'widgets', 'container.dart'),
      '''
import 'framework.dart';
class Container extends Widget {}
''',
    );
    newFile(
      join(flutterFolder.path, 'lib', 'src', 'widgets', 'basic.dart'),
      '''
import 'framework.dart';
import '../painting/edge_insets.dart';

export '../../painting.dart';

class Padding extends Widget {
  Padding({required EdgeInsets padding, Widget? child});
}
''',
    );
    newFile(
      join(flutterFolder.path, 'lib', 'src', 'painting', 'edge_insets.dart'),
      '''
class EdgeInsets {
  EdgeInsets.all(double value);
}
''',
    );
    newFile(
      join(flutterFolder.path, 'lib', 'painting.dart'),
      '''
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
