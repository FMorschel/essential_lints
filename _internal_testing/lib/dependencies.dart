import 'dart:isolate';

import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:analyzer_testing/src/analysis_rule/pub_package_resolution.dart';

mixin AnnotationsDependencyMixin on AnalysisRuleTest {
  late Folder annotationLibSource;

  Future<PackageBuilder> addAnnotationsDependency() async {
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
    annotationLibSource = resourceProvider
        .getFile(resourceProvider.pathContext.normalize(fileUri.toFilePath()))
        .parent;

    var annotationFolder = newFolder('/package/essential_lints_annotations');
    annotationLibSource.copyTo(annotationFolder);

    return newPackage('essential_lints_annotations');
  }
}
