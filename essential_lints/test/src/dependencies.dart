import 'dart:isolate';

import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/utilities/package_config_file_builder.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:analyzer_testing/utilities/utilities.dart';

mixin AnnotationsDependencyMixin on AnalysisRuleTest {
  Future<void> addAnnotationsDependency() async {
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
    var annotationLibSource = resourceProvider
        .getFile(resourceProvider.pathContext.normalize(fileUri.toFilePath()))
        .parent;

    var annotationFolder = newFolder('/packages/essential_lints_annotations');
    annotationLibSource.copyTo(annotationFolder);

    newPackageConfigJsonFileFromBuilder(
      testPackageRootPath,
      PackageConfigFileBuilder()..add(
        name: 'essential_lints_annotations',
        rootPath: annotationFolder.toUri().toFilePath(),
      ),
    );
    pubspecYamlContent(
      dependencies: ['essential_lints_annotations'],
    );
  }
}
