// Copyright (c) 2025, the Dart project authors.
//
// All rights reserved. Use of this source code is governed by a BSD-style
// license:
//
// https://github.com/dart-lang/sdk/blob/d92eb2f301676acb24b2dc157ebb4fbe77ccc17c/pkg/_fe_analyzer_shared/LICENSE
//
// ```
// Copyright 2019, the Dart project authors.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
//     * Neither the name of Google LLC nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// ```

import 'package:analyzer/diagnostic/diagnostic.dart';

/// A concrete implementation of a diagnostic message.
class DiagnosticMessageImpl implements DiagnosticMessage {
  /// Initialize a newly created message to represent a [message] reported in
  /// the file at the given [filePath] at the given [offset] and with the given
  /// [length].
  DiagnosticMessageImpl({
    required this.filePath,
    required this.length,
    required String message,
    required this.offset,
    required this.url,
  }) : _message = message;

  @override
  final String filePath;

  @override
  final int length;

  final String _message;

  @override
  final int offset;

  @override
  final String? url;

  @override
  String messageText({required bool includeUrl}) {
    if (includeUrl && url != null) {
      var result = StringBuffer(_message);
      if (!_message.endsWith('.')) {
        result.write('.');
      }
      result.write('  See $url');
      return result.toString();
    }
    return _message;
  }
}
