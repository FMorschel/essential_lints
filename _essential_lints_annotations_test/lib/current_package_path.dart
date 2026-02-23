import 'dart:io';
import 'dart:isolate';

final _regExp = RegExp('/');

/// Utility functions to get the file system paths of the given package.
Future<Directory> packageDir(String packageName, String fileUnderLib) async {
  var packageUri = Uri.parse('package:$packageName/$fileUnderLib');
  var uri = await Isolate.resolvePackageUri(packageUri);

  if (uri == null) {
    throw StateError(
      'Could not resolve package URI for $packageName.',
    );
  }
  var dir = Directory(uri.toFilePath());
  for (var _ in _regExp.allMatches(fileUnderLib)) {
    dir = dir.parent;
  }
  //          <lib>.<root>
  return dir.parent.parent;
}

/// Utility functions to get the file system paths of the
/// essential_lints_annotations.
Future<Directory> essentialLintsAnnotationsPackage() async {
  return await packageDir(
    'essential_lints_annotations',
    'essential_lints_annotations.dart',
  );
}

/// Utility functions to get the file system paths of the
/// _essential_lints_annotations_test package.
Future<Directory> essentialLintsAnnotationsTestPackage() async {
  return await packageDir(
    '_essential_lints_annotations_test',
    'current_package_path.dart',
  );
}

/// Utility functions to get the file system paths of the analyzer package.
Future<Directory> analyzerPackage() async {
  return await packageDir(
    'analyzer',
    'file_system/file_system.dart.dart',
  );
}

/// Utility functions to get the file system paths of the meta package.
Future<Directory> metaPackage() async {
  return await packageDir(
    'meta',
    'meta.dart',
  );
}
