import 'dart:io';

import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/utilities/package_config_file_builder.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:analyzer_testing/utilities/utilities.dart';

mixin AnnotationsDependencyMixin on AnalysisRuleTest {
  void addAnnotationsDependency() {
    var resourceProvider = PhysicalResourceProvider.INSTANCE;
    var workspace = Directory
        .current // essential_lints
        .parent; // workspace root
    var workspacePath = resourceProvider.pathContext.normalize(workspace.path);
    var annotationLibSource = resourceProvider
        .getFolder(workspacePath)
        .getChildAssumingFolder('essential_lints_annotations')
        .getChildAssumingFolder('lib');

    var annotationFolder = newFolder('/packages/essential_lints_annotations');
    annotationLibSource.copyTo(annotationFolder);

    newPackageConfigJsonFileFromBuilder(
      testPackageRootPath,
      PackageConfigFileBuilder()..add(
        name: 'essential_lints_annotations',
        rootPath: annotationFolder.path,
      ),
    );
    pubspecYamlContent(
      dependencies: ['essential_lints_annotations'],
    );
  }
}
