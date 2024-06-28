// ignore_for_file: avoid_print

import 'dart:io';

void main(List<String> arguments) {
  print(arguments);
  if (arguments.length != 3 ||
      arguments[0] != 'create' ||
      arguments[1] != 'page') {
    print('Usage: create page PageName');
    return;
  }

  const appPath = 'lib/ui/pages';

  final pageName = arguments[2];
  final formattedPageName = _formatPageName(pageName);

  final folderName = '$appPath/$formattedPageName';

  // Create the folder
  final folder = Directory(folderName);
  if (!folder.existsSync()) {
    folder.createSync(recursive: true);
  }

  // Define the names
  final viewName = '${pageName}View';
  final controllerName = '${pageName}ViewController';
  final bindingName = '${pageName}ViewBinding';

  // Define the file names
  final viewFileName = '$folderName/${formattedPageName}_view.dart';
  final controllerFileName =
      '$folderName/${formattedPageName}_view_controller.dart';
  final bindingFileName = '$folderName/${formattedPageName}_view_binding.dart';

  // Generate the files
  _generateFile(
    filePath: viewFileName,
    templatePath: 'examples/view.example',
    replacements: {
      '{{PageName}}': viewName,
      '{{ControllerName}}': controllerName,
      '{{ControllerPath}}': '${formattedPageName}_view_controller.dart',
    },
  );
  _generateFile(
    filePath: controllerFileName,
    templatePath: 'examples/controller.example',
    replacements: {
      '{{PageName}}': viewName,
      '{{ControllerName}}': controllerName,
    },
  );
  _generateFile(
    filePath: bindingFileName,
    templatePath: 'examples/binding.example',
    replacements: {
      '{{BindingName}}': bindingName,
      '{{ControllerName}}': controllerName,
      '{{ControllerPath}}': '${formattedPageName}_view_controller.dart',
    },
  );

  print('Page $pageName created successfully.');
}

String _formatPageName(String pageName) {
  return pageName.replaceAllMapped(RegExp(r'[A-Z]'), (Match match) {
    return '_${match.group(0)!.toLowerCase()}';
  }).substring(1);
}

void _generateFile({
  required String filePath,
  required String templatePath,
  required Map<String, String> replacements,
}) {
  final templateFile = File(templatePath);
  if (!templateFile.existsSync()) {
    print('Template file $templatePath not found.');
    return;
  }

  final content = templateFile.readAsStringSync();

  final newContent = replacements.entries.fold(content, (acc, entry) {
    return acc.replaceAll(entry.key, entry.value);
  });

  final newFile = File(filePath);
  newFile.writeAsStringSync(newContent);
}
