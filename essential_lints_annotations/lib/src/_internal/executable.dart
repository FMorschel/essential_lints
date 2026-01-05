import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';

/// {@template get_example}
/// A class that encapsulates the functionality of the get_example executable.
/// {@endtemplate}
class GetExample {
  /// {@macro get_example}
  GetExample({
    required this.defaultOutputDir,
    required this.defaultSourcePath,
  });

  /// The default output directory for the get_example executable.
  final String defaultOutputDir;
  /// The default source path in the repository to extract.
  final String defaultSourcePath;

  /// The argument parser for the get_example executable.
  late final ArgParser parser = ArgParser()
    ..addOption(
      'tag',
      abbr: 't',
      help: 'Git version tag to extract the example from (defaults to main '
          'branch if not provided). Example: v1.0.0',
    )
    ..addOption(
      'output',
      abbr: 'o',
      help: 'Output directory for the extracted example',
      defaultsTo: defaultOutputDir,
    )
    ..addOption(
      'source',
      abbr: 's',
      help: 'Source path in the repository to extract',
      defaultsTo: defaultSourcePath,
      hide: true,
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      help: 'Enable verbose logging',
      negatable: false,
    )
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Show usage information',
      negatable: false,
    );

  /// Runs a command with the given arguments.
  Future<void> runCommand(
    String command,
    List<String> args, {
    String? workingDirectory,
    bool quiet = false,
    bool verbose = false,
  }) async {
    if (verbose) {
      stdout.writeln('[VERBOSE] Running: $command ${args.join(' ')}');
    }
    await runZonedGuarded(
      () async {
        var result = await Process.run(
          command,
          args,
          workingDirectory: workingDirectory,
          runInShell: true,
        );

        if (!quiet) {
          stdout.write(result.stdout);
        }
        stderr.write(result.stderr);

        if (result.exitCode != 0) {
          throw Exception('Command failed: $command ${args.join(' ')}');
        }
      },
      (e, _) {
        // ignore: only_throw_errors internal
        throw e;
      },
    );
  }

  /// Runs the get_example executable.
  Future<void> run(List<String> args) async {
    var results = parser.parse(args);
    if (results['help'] as bool) {
      stdout
        ..writeln(
          'Extracts an example folder from a remote git repository.\n',
        )
        ..writeln('Usage: dart get_example.dart [options]\n')
        ..writeln(parser.usage);
      exit(0);
    }
    var tag = results['tag'] as String?;
    var targetDir = results['output'] as String;
    var sourcePath = results['source'] as String;
    var verbose = results['verbose'] as bool;

    const repoUrl = 'https://github.com/FMorschel/essential_lints.git';
    const tempDirName = '.tmp';
    var tempDir = '$targetDir/$tempDirName';

    if (verbose) {
      stdout
        ..writeln('[VERBOSE] Target directory: $targetDir')
        ..writeln('[VERBOSE] Repository URL: $repoUrl')
        ..writeln('[VERBOSE] Tag: ${tag ?? 'main (default)'}');
    }

    if (Directory(targetDir).existsSync()) {
      stderr.writeln(
        'Directory "$targetDir" already exists. Aborting to avoid overwrite.',
      );
      exit(1);
    }

    // Create target directory and clone inside it
    await Directory(targetDir).create(recursive: true);
    if (verbose) {
      stdout.writeln('[VERBOSE] Created target directory: $targetDir');
    }

    // Clone repository metadata only, without checking out files
    if (verbose) {
      stdout.writeln('[VERBOSE] Cloning repository (no checkout)...');
    }
    await runCommand(
      'git',
      [
        'clone',
        '--quiet',
        '--no-checkout',
        repoUrl,
        tempDir,
      ],
      verbose: verbose,
    );

    // Suppress "detached HEAD" advice
    if (verbose) {
      stdout.writeln('[VERBOSE] Configuring git...');
    }
    await runCommand(
      'git',
      ['config', 'advice.detachedHead', 'false'],
      workingDirectory: tempDir,
      verbose: verbose,
    );

    // Ensure tags are available
    if (tag != null) {
      if (verbose) {
        stdout.writeln('[VERBOSE] Fetching tags...');
      }
      await runCommand(
        'git',
        ['fetch', '--tags'],
        workingDirectory: tempDir,
        verbose: verbose,
      );
    }

    // Checkout the requested tag or main branch
    var checkoutRef = tag != null ? 'tags/$tag' : 'main';
    if (verbose) {
      stdout.writeln('[VERBOSE] Checking out $checkoutRef...');
    }
    await runCommand(
      'git',
      ['checkout', checkoutRef, '--quiet'],
      workingDirectory: tempDir,
      quiet: true,
      verbose: verbose,
    );

    // Enable sparse checkout
    if (verbose) {
      stdout.writeln('[VERBOSE] Enabling sparse checkout...');
    }
    await runCommand(
      'git',
      [
        'sparse-checkout',
        'init',
        '--cone',
      ],
      workingDirectory: tempDir,
      verbose: verbose,
    );

    // Select only the example folder
    if (verbose) {
      stdout.writeln('[VERBOSE] Selecting source path: $sourcePath');
    }
    await runCommand(
      'git',
      [
        'sparse-checkout',
        'set',
        sourcePath,
      ],
      workingDirectory: tempDir,
      verbose: verbose,
    );

    // Populate working tree with the selected files
    if (verbose) {
      stdout.writeln('[VERBOSE] Populating working tree...');
    }
    await runCommand(
      'git',
      ['checkout', '--quiet'],
      workingDirectory: tempDir,
      quiet: true,
      verbose: verbose,
    );

    // Move the example folder contents to final destination
    if (verbose) {
      stdout.writeln('[VERBOSE] Moving example folder contents...');
    }
    var sourceDir = Directory('$tempDir/$sourcePath');
    var entities = await sourceDir.list().toList();
    for (var entity in entities) {
      var name = entity.uri.pathSegments.lastWhere((s) => s.isNotEmpty);
      if (verbose) {
        stdout.writeln('[VERBOSE] Moving $name to $targetDir');
      }
      await _moveWithRetry(entity, '$targetDir/$name', verbose: verbose);
    }

    // Retry deletion to handle Windows file lock issues
    if (verbose) {
      stdout.writeln('[VERBOSE] Cleaning up temporary directory...');
    }
    await _deleteWithRetry(tempDir, verbose: verbose);

    stdout.writeln(
      '✔ Example extracted from '
      '${tag != null ? 'tag "$tag"' : '"main" (default)'} into "$targetDir"',
    );
  }

  /// Moves a file or directory with retry logic and copy fallback.
  ///
  /// On Windows, files may be temporarily locked by processes like VS Code's
  /// file watcher, Windows Defender, or lingering git handles.
  Future<void> _moveWithRetry(
    FileSystemEntity entity,
    String destination, {
    int maxRetries = 5,
    bool verbose = false,
  }) async {
    for (var i = 0; i < maxRetries; i++) {
      try {
        if (i > 0) {
          if (verbose) {
            stdout.writeln(
              '[VERBOSE] Retry attempt ${i + 1}/$maxRetries for $destination',
            );
          }
          await Future<void>.delayed(Duration(milliseconds: 300 * i));
        }
        await entity.rename(destination);
        if (verbose) {
          stdout.writeln('[VERBOSE] Successfully moved to $destination');
        }
        return;
      } on FileSystemException catch (e) {
        if (i == maxRetries - 1) {
          if (verbose) {
            stdout.writeln(
              '[VERBOSE] Using copy+delete fallback for $destination',
            );
          }
          // Last resort: try copy + delete instead of rename
          await _copyAndDelete(entity, destination, verbose: verbose);
          return;
        }
        if (e.osError?.errorCode != 32) {
          // Not a "file in use" error, rethrow immediately
          rethrow;
        }
      }
    }
  }

  /// Copies a file or directory and then deletes the original.
  Future<void> _copyAndDelete(
    FileSystemEntity entity,
    String destination, {
    bool verbose = false,
  }) async {
    if (entity is File) {
      if (verbose) {
        stdout.writeln('[VERBOSE] Copying file to $destination');
      }
      await entity.copy(destination);
      await entity.delete();
    } else if (entity is Directory) {
      if (verbose) {
        stdout.writeln('[VERBOSE] Copying directory to $destination');
      }
      await _copyDirectory(entity, Directory(destination), verbose: verbose);
      await entity.delete(recursive: true);
    }
  }

  /// Recursively copies a directory.
  Future<void> _copyDirectory(
    Directory source,
    Directory destination, {
    bool verbose = false,
  }) async {
    await destination.create(recursive: true);
    await for (var entity in source.list()) {
      var name = entity.uri.pathSegments.lastWhere((s) => s.isNotEmpty);
      var newPath = '${destination.path}/$name';
      if (entity is File) {
        if (verbose) {
          stdout.writeln('[VERBOSE] Copying file: $name');
        }
        await entity.copy(newPath);
      } else if (entity is Directory) {
        if (verbose) {
          stdout.writeln('[VERBOSE] Copying directory: $name');
        }
        await _copyDirectory(entity, Directory(newPath), verbose: verbose);
      }
    }
  }

  /// Deletes a directory with retry logic for Windows file lock issues.
  Future<void> _deleteWithRetry(
    String path, {
    int maxRetries = 5,
    bool verbose = false,
  }) async {
    for (var i = 0; i < maxRetries; i++) {
      try {
        await Future<void>.delayed(Duration(milliseconds: 500 * (i + 1)));
        if (verbose && i > 0) {
          stdout
            ..writeln('Trying to delete $path')
            ..writeln('[VERBOSE] Deletion retry attempt ${i + 1}/$maxRetries');
        }
        await Directory(path).delete(recursive: true);
        if (verbose) {
          stdout.writeln('[VERBOSE] Successfully deleted: $path');
        }
        break;
      } catch (e) {
        if (i == maxRetries - 1) {
          stderr.writeln(
            'Failed to delete temp directory after $maxRetries '
            'attempts: $e',
          );
          rethrow;
        }
      }
    }
  }
}
