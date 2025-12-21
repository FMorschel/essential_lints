// ignore_for_file: avoid_print

import 'dart:isolate';

import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:dartdoc/dartdoc.dart';
import 'package:dartdoc/src/model/package.dart';
import 'package:test/test.dart';

Future<void> main() async {
  final packageRoot = await _findPackageRoot();
  Package? defaultPackage;

  setUpAll(() async {
    // Find the package root directory
    final packageRootPath = packageRoot.path;

    // Parse dartdoc options with the package root as input directory
    var config = parseOptions(
      pubPackageMetaProvider,
      ['--input', packageRootPath],
    );

    if (config == null) {
      fail('Failed to parse dartdoc options');
    }

    // Create package builder
    final packageConfigProvider = PhysicalPackageConfigProvider();
    final packageBuilder = PubPackageBuilder(
      config,
      pubPackageMetaProvider,
      packageConfigProvider,
    );

    // Build package graph without generating documentation
    var packageGraph = await packageBuilder.buildPackageGraph();

    defaultPackage = packageGraph.defaultPackage;
    print('Built package graph for: ${defaultPackage?.name}');
  });

  test('all exposed declarations have non-empty doc comments', () {
    if (defaultPackage == null) {
      fail('Package was not initialized');
    }

    final libraries = defaultPackage!.libraries;
    if (libraries.isEmpty) {
      fail('No libraries found in the default package');
    }

    final missingDocs = <String>[];

    for (final library in libraries) {
      if (!library.isPublic) continue;
      // Check classes
      for (final class_ in library.classes) {
        if (!class_.isPublic) continue;

        if (class_.documentation.trim().isEmpty) {
          missingDocs.add('Class ${class_.name}');
        }

        // Check constructors
        for (final constructor in class_.constructors) {
          if (!constructor.isPublic) continue;
          if (constructor.documentation.trim().isEmpty) {
            missingDocs.add(
              'Constructor ${class_.name}.${constructor.name}',
            );
          }
        }

        // Check methods
        for (final method in class_.declaredMethods) {
          if (!method.isPublic) continue;
          if (method.documentation.trim().isEmpty) {
            missingDocs.add('Method ${class_.name}.${method.name}');
          }
        }

        // Check fields
        for (final field in class_.declaredFields) {
          if (!field.isPublic) continue;
          if (field.documentation.trim().isEmpty) {
            missingDocs.add('Field ${class_.name}.${field.name}');
          }
        }
      }
    }

    if (missingDocs.isNotEmpty) {
      fail(
        'The following declarations are missing documentation:\n'
        '${missingDocs.map((e) => '  - $e').join('\n')}',
      );
    }
  });
}

Future<Folder> _findPackageRoot() async {
  var uri = Uri.parse(
    'package:essential_lints_annotations/essential_lints_annotations.dart',
  );
  var fileUri = await Isolate.resolvePackageUri(uri);

  if (fileUri == null) {
    throw StateError(
      'Could not resolve package URI for essential_lints_annotations.',
    );
  }
  var resourceProvider = PhysicalResourceProvider.INSTANCE;

  // Get the lib directory, then go up one level to package root
  var libFile = resourceProvider.getFile(
    resourceProvider.pathContext.normalize(fileUri.toFilePath()),
  );
  return libFile.parent.parent;
}
