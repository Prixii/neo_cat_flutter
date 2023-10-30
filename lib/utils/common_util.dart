import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:logger/logger.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 10
final logger = Logger();

String getNodeIdByName(String name) {
  return name;
}

Future<String?> pickFileAndGetPath(List<String> fileExtension) async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: FileType.custom, allowedExtensions: fileExtension);
  if (result != null) {
    String? filePath = result.files.single.path;
    return filePath;
  }
  return null;
}

Future<String?> pickFolderPath() async {
  String? result = await FilePicker.platform.getDirectoryPath();
  return result;
}

Future<String?> readFile(String filePath) async {
  try {
    File file = File(filePath);
    if (file.existsSync()) {
      String content = file.readAsStringSync();
      return content;
    } else {
      throw FileSystemException('文件不存在', filePath);
    }
  } catch (e) {
    throw FileSystemException('读取文件错误$e', filePath);
  }
}

Future<bool> writeFile(
    {required String filePath, required String content}) async {
  try {
    File file = File(filePath);
    if (file.existsSync()) {
      file.writeAsStringSync(content);
    } else {
      file.writeAsStringSync(content);
    }
    return true;
  } catch (e) {
    return false;
  }
}

void customDisplayInfoBar({
  required BuildContext context,
  required String title,
  String? content,
  InfoBarSeverity? severity,
}) {
  displayInfoBar(
    context,
    builder: ((context, close) {
      return InfoBar(
        title: Text(title),
        content: Text(content ?? ''),
        action: IconButton(
          icon: const Icon(FluentIcons.clear),
          onPressed: close,
        ),
        severity: severity ?? InfoBarSeverity.info,
      );
    }),
  );
}

/// 通过 [hexString] 转化成color
///
/// hexString形如：#112233

extension StringExtension on String {
  Color toColor() {
    return Color(int.parse(padLeft(8, 'f'), radix: 16));
  }
}

extension ColorExtension on Color {
  String toHex() {
    return value.toRadixString(16).padLeft(8, 'f');
  }

  double toGrey() => (red * 30 + green * 59 + green * 11 + 50) / 100;
}

TextStyle calculateTextColor(Color color) {
  if (color.toGrey() > 127) {
    return defaultTextBlack;
  }
  return defaultText;
}
