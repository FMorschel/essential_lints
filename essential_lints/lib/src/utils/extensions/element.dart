import 'package:analyzer/dart/element/element.dart';

/// Useful extensions on [Element].
extension ElementExt on Element? {
  static const _widgetName = 'Widget';
  static const _paddingName = 'Padding';
  static const _containerName = 'Container';
  static const _statelessWidgetName = 'StatelessWidget';
  static const _stateName = 'State';
  static final Uri _uriFramework = .parse(
    'package:flutter/src/widgets/framework.dart',
  );
  static final Uri _uriContainer = .parse(
    'package:flutter/src/widgets/container.dart',
  );
  static final Uri _uriBasic = .parse(
    'package:flutter/src/widgets/basic.dart',
  );

  /// Whether this element is a Flutter Container.
  bool get isContainer {
    var self = this;
    if (self is! ClassElement) {
      return false;
    }
    if (_isExactly(_containerName, _uriContainer)) {
      return true;
    }
    return self.allSupertypes.any(
      (type) => type.element._isExactly(_containerName, _uriContainer),
    );
  }

  /// Whether this element is a Flutter Padding.
  bool get isPadding {
    var self = this;
    if (self is! ClassElement) {
      return false;
    }
    if (_isExactly(_paddingName, _uriBasic)) {
      return true;
    }
    return self.allSupertypes.any(
      (type) => type.element._isExactly(_paddingName, _uriBasic),
    );
  }

  /// Whether this element is a Flutter State.
  bool get isState {
    var self = this;
    if (self is! ClassElement) {
      return false;
    }
    return self._isExactly(_stateName, _uriFramework) ||
        self.allSupertypes.any(
          (type) => type.element._isExactly(_stateName, _uriFramework),
        );
  }

  /// Whether this element is a Flutter StatelessWidget.
  bool get isStatelessWidget {
    var self = this;
    if (self is! ClassElement) {
      return false;
    }
    return self._isExactly(_statelessWidgetName, _uriFramework) ||
        self.allSupertypes.any(
          (type) =>
              type.element._isExactly(_statelessWidgetName, _uriFramework),
        );
  }

  /// Whether this element is a Flutter Widget.
  bool get isWidget {
    var self = this;
    if (self is! ClassElement) {
      return false;
    }
    if (_isExactly(_widgetName, _uriFramework)) {
      return true;
    }
    return self.allSupertypes.any(
      (type) => type.element._isExactly(_widgetName, _uriFramework),
    );
  }

  /// Whether this is the exact [type] defined in the file with the given [uri].
  bool _isExactly(String type, Uri uri) {
    var self = this;
    return self is ClassElement && self.name == type && self.library.uri == uri;
  }
}
