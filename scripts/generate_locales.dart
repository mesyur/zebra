// ignore_for_file: avoid_print

import 'dart:io';

void copyAndRenameFiles(String srcDirectory, String destDirectory) {
  final srcDir = Directory(srcDirectory);
  final destDir = Directory(destDirectory);

  if (!destDir.existsSync()) {
    destDir.createSync(recursive: true);
  }

  srcDir.listSync().forEach((file) {
    if (file is File && file.path.endsWith('.arb')) {
      final destFilePath =
          '$destDirectory/${file.uri.pathSegments.last.replaceAll('app_', '').replaceAll('.arb', '.json')}';

      file.copySync(destFilePath);
      print('Copied and renamed: ${file.path} -> $destFilePath');
    }
  });
}

Future<void> runGenerateLocalesCommand(String command) async {
  try {
    final result = await Process.run('bash', ['-c', command]);
    if (result.exitCode == 0) {
      print('Command output: ${result.stdout}');
      print('Command executed successfully.');
    } else {
      print('Error occurred while executing the command: ${result.stderr}');
    }
  } catch (e) {
    print('Exception occurred: $e');
  }
}

void main() {
  const srcDirectory = 'lib/l10n'; // Replace with the path to your .arb files
  const destDirectory =
      'lib/generated/locales'; // Replace with the destination path for .json files
  const command =
      'get generate locales $destDirectory'; // Replace with the actual command you want to run

  copyAndRenameFiles(srcDirectory, destDirectory);
  runGenerateLocalesCommand(command);
}
