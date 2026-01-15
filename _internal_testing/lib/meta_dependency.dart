import 'dart:isolate';

import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';

mixin MetaDependencyMixin on AnalysisRuleTest {
  late Folder metaLibSource;

  Future<PackageBuilder> addMetaDependency() async {
    var uri = Uri.parse(
      'package:meta/meta.dart',
    );
    var fileUri = await Isolate.resolvePackageUri(uri);

    if (fileUri == null) {
      throw StateError(
        'Could not resolve package URI for meta.',
      );
    }
    var resourceProvider = PhysicalResourceProvider.INSTANCE;
    metaLibSource = resourceProvider
        .getFile(resourceProvider.pathContext.normalize(fileUri.toFilePath()))
        .parent;

    var metaFolder = newFolder('/package/meta');
    metaLibSource.copyTo(metaFolder);

    return newPackage('meta');
  }
}
