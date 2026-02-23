import 'package:_essential_lints_annotations_test/current_package_path.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';

mixin MetaDependencyMixin on AnalysisRuleTest {
  Future<PackageBuilder> addMetaDependency() async {
    var directory = await metaPackage();
    var resourceProvider = PhysicalResourceProvider.INSTANCE;
    var metaLibSource = resourceProvider.getFolder(
      resourceProvider.pathContext.normalize(
        join(directory.uri.toFilePath(), 'lib'),
      ),
    );

    var metaFolder = newFolder('/package/meta');
    metaLibSource.copyTo(metaFolder);

    return newPackage('meta');
  }
}
