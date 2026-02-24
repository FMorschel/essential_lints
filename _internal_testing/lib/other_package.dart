import 'package:analyzer/utilities/package_config_file_builder.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';

mixin OtherPackageMixin on AnalysisRuleTest {
  late PackageBuilder otherPackage;

  void createOtherPackage() {
    otherPackage = newPackage('other');
    var path = '/package/other/.dart_tool/package_config.json';
    var builder = PackageConfigFileBuilder();
    for (var packageName in _packagesToAdd) {
      var packagePath = convertPath('/package/$packageName');
      builder.add(name: packageName, rootPath: packagePath);
    }
    writePackageConfig(path, builder);
  }

  final Set<String> _packagesToAdd = {};

  @override
  PackageBuilder newPackage(String name) {
    _packagesToAdd.add(name);
    return super.newPackage(name);
  }
}
