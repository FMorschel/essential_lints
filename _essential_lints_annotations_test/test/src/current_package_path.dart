import 'dart:io';
import 'dart:isolate';

Future<Directory> packageDir(String libFilePackagePath) async {
  var uri = Uri.parse(libFilePackagePath);
  var fileUri = await Isolate.resolvePackageUri(uri);

  if (fileUri == null) {
    throw StateError(
      'Could not resolve package URI for essential_lints_annotations.',
    );
  }
  return Directory(fileUri.toFilePath()).parent.parent;
}

Future<Directory> essentialLintsAnnotationsPackage() async {
  return await packageDir(
    'package:essential_lints_annotations/essential_lints_annotations.dart',
  );
}
