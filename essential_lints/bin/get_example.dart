import 'package:essential_lints_annotations/src/_internal/executable.dart';

void main(List<String> arguments) async {
  var getExample = GetExample(
    defaultOutputDir: 'essential_lints_example',
    defaultSourcePath: 'essential_lints/example',
  );
  await getExample.run(arguments);
}
