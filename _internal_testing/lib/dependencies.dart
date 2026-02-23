import 'package:_essential_lints_annotations_test/current_package_path.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';

mixin AnnotationsDependencyMixin on AnalysisRuleTest {
  late Folder annotationLibSource;

  Future<PackageBuilder> addAnnotationsDependency() async {
    var directory = await essentialLintsAnnotationsPackage();
    var resourceProvider = PhysicalResourceProvider.INSTANCE;
    annotationLibSource = resourceProvider.getFolder(
      resourceProvider.pathContext.normalize(
        join(directory.uri.toFilePath(), 'lib'),
      ),
    );

    var annotationFolder = newFolder('/package/essential_lints_annotations');
    annotationLibSource.copyTo(annotationFolder);

    return newPackage('essential_lints_annotations');
  }
}
