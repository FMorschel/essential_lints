// This file provides a mixin to create a mock Flutter SDK for testing purposes.
// The Flutter SDK is licensed under a BSD 3-Clause license that can be found at
// https://github.com/flutter/flutter/blob/483505b8257e0ee417ce10de96a3b283b44c986f/LICENSE.
//
// ```
// Copyright 2014 The Flutter Authors. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
//     * Neither the name of Google Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.
// ```

import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';

mixin FlutterDependencyMixin on AnalysisRuleTest {
  void createFlutterMock() {
    newPackage('flutter')
      ..addFile(
        join('lib', 'src', 'widgets', 'framework.dart'),
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
  void setState(VoidCallback fn) {}
  void initState() {}
  void didChangeDependencies() {}
  void didUpdateWidget(covariant T oldWidget) {}
  void dispose() {}
  Widget build(BuildContext context);
}
''',
      )
      ..addFile(
        join('lib', 'src', 'widgets', 'container.dart'),
        '''
import 'framework.dart';
import '../painting/edge_insets.dart';

class Container extends Widget {
  Container({Widget? child, EdgeInsets? padding});
}
''',
      )
      ..addFile(
        join('lib', 'src', 'widgets', 'basic.dart'),
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
      )
      ..addFile(
        join(
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
      )
      ..addFile(
        join(
          'lib',
          'foundation.dart',
        ),
        '''
export 'src/foundation/change_notifier.dart';
''',
      )
      ..addFile(
        join('lib', 'src', 'painting', 'edge_insets.dart'),
        '''
class EdgeInsets {
  const EdgeInsets.all(double value);
}
''',
      )
      ..addFile(
        join('lib', 'src', 'painting', 'border_radius.dart'),
        '''
import 'basic_types.dart';

class BorderRadius {
  const BorderRadius.all(Radius radius);
  BorderRadius.circular(double radius);
}
''',
      )
      ..addFile(
        join('lib', 'src', 'painting', 'basic_types.dart'),
        '''
class Radius {
  const Radius.circular(double radius);
}
''',
      )
      ..addFile(
        join('lib', 'src', 'painting', 'borders.dart'),
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
      )
      ..addFile(
        join('lib', 'src', 'painting', 'box_border.dart'),
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
      )
      ..addFile(
        join('lib', 'painting.dart'),
        '''
export 'src/painting/basic_types.dart';
export 'src/painting/border_radius.dart';
export 'src/painting/borders.dart';
export 'src/painting/box_border.dart';
export 'src/painting/edge_insets.dart';
''',
      )
      ..addFile(join('lib', 'widgets.dart'), '''
export 'src/widgets/framework.dart';
export 'src/widgets/container.dart';
export 'src/widgets/basic.dart';
''');
  }
}
