import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:test/test.dart';

import 'src/current_package_path.dart';

void main() {
  test('all public declarations in src are exported', () async {
    final packageRoot = await currentPackage();
    final libPath = '${packageRoot.path}${Platform.pathSeparator}lib';
    final srcPath = '$libPath${Platform.pathSeparator}src';
    final mainLibraryPath =
        '$libPath${Platform.pathSeparator}essential_lints_annotations.dart';

    final collection = AnalysisContextCollection(
      includedPaths: [libPath],
      resourceProvider: PhysicalResourceProvider.INSTANCE,
    );

    final context = collection.contextFor(mainLibraryPath);

    // Get all public declarations from src files
    final srcDeclarations = <String>{};
    final srcDir = Directory(srcPath);
    for (final file in srcDir.listSync().whereType<File>()) {
      if (!file.path.endsWith('.dart')) continue;

      final result = await context.currentSession.getResolvedLibrary(file.path);
      if (result is! ResolvedLibraryResult) {
        fail('Failed to resolve ${file.path}');
      }

      final library = result.element;
      srcDeclarations.addAll(_getPublicDeclarations(library));
    }

    // Get all exported declarations from the main library
    final mainResult = await context.currentSession.getResolvedLibrary(
      mainLibraryPath,
    );
    if (mainResult is! ResolvedLibraryResult) {
      fail('Failed to resolve main library');
    }

    final exportedDeclarations = <String>{};
    mainResult.element.exportNamespace.definedNames2.keys.forEach(
      exportedDeclarations.add,
    );

    // Verify all src declarations are exported
    final notExported = srcDeclarations.difference(exportedDeclarations);

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
  final declarations = <String>{};

  // Top-level classes
  for (final classElement in library.classes) {
    if (classElement.isPublic) {
      declarations.add(classElement.displayName);
    }
  }

  // Top-level enums
  for (final enumElement in library.enums) {
    if (enumElement.isPublic) {
      declarations.add(enumElement.displayName);
    }
  }

  // Top-level functions
  for (final functionElement in library.topLevelFunctions) {
    if (functionElement.isPublic) {
      declarations.add(functionElement.displayName);
    }
  }

  // Top-level type aliases
  for (final typeAlias in library.typeAliases) {
    if (typeAlias.isPublic) {
      declarations.add(typeAlias.displayName);
    }
  }

  // Top-level variables/constants
  for (final variable in library.topLevelVariables) {
    if (variable.isPublic) {
      declarations.add(variable.displayName);
    }
  }

  // Extensions
  for (final extension in library.extensions) {
    if (extension.isPublic) {
      declarations.add(extension.displayName);
    }
  }

  // Mixins
  for (final mixin in library.mixins) {
    if (mixin.isPublic) {
      declarations.add(mixin.displayName);
    }
  }

  // Extension types
  for (final extensionType in library.extensionTypes) {
    if (extensionType.isPublic) {
      declarations.add(extensionType.displayName);
    }
  }

  return declarations;
}
