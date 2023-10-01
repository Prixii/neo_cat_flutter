import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:logger/logger.dart';
import 'package:neo_cat_flutter/model/graph_data_model.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 10
final logger = Logger();

String getNodeIdByName(String name) {
  return name;
}

Future<String?> openFile(List<String> fileExtension) async {
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
      logger.d('文件不存在');
      throw FileSystemException(filePath);
    }
  } catch (e) {
    logger.d('读取文件错误$e');
  }
  return null;
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
