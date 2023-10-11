import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:logger/logger.dart';

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
