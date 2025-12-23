import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:test/test.dart';

import 'src/current_package_path.dart';

void main() {
  test('all public declarations in src are exported', () async {
    var packageRoot = await essentialLintsAnnotationsPackage();
    var libPath = '${packageRoot.path}${Platform.pathSeparator}lib';
    var srcPath = '$libPath${Platform.pathSeparator}src';
    var mainLibraryPath =
        '$libPath${Platform.pathSeparator}essential_lints_annotations.dart';

    var collection = AnalysisContextCollection(
      includedPaths: [libPath],
      resourceProvider: PhysicalResourceProvider.INSTANCE,
    );

    var context = collection.contextFor(mainLibraryPath);

    // Get all public declarations from src files
    var srcDeclarations = <String>{};
    var srcDir = Directory(srcPath);
    for (var file in srcDir.listSync().whereType<File>()) {
      if (!file.path.endsWith('.dart')) continue;

      var result = await context.currentSession.getResolvedLibrary(file.path);
      if (result is! ResolvedLibraryResult) {
        fail('Failed to resolve ${file.path}');
      }

      var library = result.element;
      srcDeclarations.addAll(_getPublicDeclarations(library));
    }

    // Get all exported declarations from the main library
    var mainResult = await context.currentSession.getResolvedLibrary(
      mainLibraryPath,
    );
    if (mainResult is! ResolvedLibraryResult) {
      fail('Failed to resolve main library');
    }

    var exportedDeclarations = <String>{};
    mainResult.element.exportNamespace.definedNames2.keys.forEach(
      exportedDeclarations.add,
    );

    // Verify all src declarations are exported
    var notExported = srcDeclarations.difference(exportedDeclarations);

    expect(
      notExported,
      isEmpty,
      reason:
          'The following public declarations from src are not exported: '
          '${notExported.join(', ')}',
    );
  });
}

/// Returns all public declaration names from a library element.
Set<String> _getPublicDeclarations(LibraryElement library) {
  var declarations = <String>{};

  // Top-level classes
  for (var classElement in library.classes) {
    if (classElement.isPublic) {
      declarations.add(classElement.displayName);
    }
  }

  // Top-level enums
  for (var enumElement in library.enums) {
    if (enumElement.isPublic) {
      declarations.add(enumElement.displayName);
    }
  }

  // Top-level functions
  for (var functionElement in library.topLevelFunctions) {
    if (functionElement.isPublic) {
      declarations.add(functionElement.displayName);
    }
  }

  // Top-level type aliases
  for (var typeAlias in library.typeAliases) {
    if (typeAlias.isPublic) {
      declarations.add(typeAlias.displayName);
    }
  }

  // Top-level variables/constants
  for (var variable in library.topLevelVariables) {
    if (variable.isPublic) {
      declarations.add(variable.displayName);
    }
  }

  // Extensions
  for (var extension in library.extensions) {
    if (extension.isPublic) {
      declarations.add(extension.displayName);
    }
  }

  // Mixins
  for (var mixin in library.mixins) {
    if (mixin.isPublic) {
      declarations.add(mixin.displayName);
    }
  }

  // Extension types
  for (var extensionType in library.extensionTypes) {
    if (extensionType.isPublic) {
      declarations.add(extensionType.displayName);
    }
  }

  return declarations;
}
