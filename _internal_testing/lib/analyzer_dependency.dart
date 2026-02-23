import 'package:_essential_lints_annotations_test/current_package_path.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';

mixin AnalyzerDependencyMixin on AnalysisRuleTest {
  Future<PackageBuilder> addAnalyzerDependency() async {
    var directory = await analyzerPackage();
    var resourceProvider = PhysicalResourceProvider.INSTANCE;
    var analyzerLibSource = resourceProvider.getFolder(
      resourceProvider.pathContext.normalize(
        join(directory.uri.toFilePath(), 'lib'),
      ),
    );

    var annotationFolder = newFolder('/package/analyzer');
    analyzerLibSource.copyTo(annotationFolder);

    await addFeAnalyzerSharedDependency();

    return newPackage('analyzer');
  }

  Future<PackageBuilder> addFeAnalyzerSharedDependency() async {
    var directory = await packageDir(
      '_fe_analyzer_shared',
      'src/base/syntactic_entity.dart',
    );
    var resourceProvider = PhysicalResourceProvider.INSTANCE;
    var libSource = resourceProvider.getFolder(
      resourceProvider.pathContext.normalize(
        join(directory.uri.toFilePath(), 'lib'),
      ),
    );

    var annotationFolder = newFolder('/package/_fe_analyzer_shared');
    libSource.copyTo(annotationFolder);

    return newPackage('_fe_analyzer_shared');
  }
}
