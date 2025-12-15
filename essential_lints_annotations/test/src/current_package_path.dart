import 'dart:io';
import 'dart:isolate';

Future<Directory> currentPackage() async {
  var uri = Uri.parse(
    'package:essential_lints_annotations/essential_lints_annotations.dart',
  );
  var fileUri = await Isolate.resolvePackageUri(uri);

  if (fileUri == null) {
    throw StateError(
      'Could not resolve package URI for essential_lints_annotations.',
    );
  }
  return Directory(fileUri.toFilePath()).parent.parent;
}
