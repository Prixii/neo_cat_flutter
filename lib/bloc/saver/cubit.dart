import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

import '../../utils/bloc_util.dart';
import 'state.dart';

class SaverCubit extends Cubit<SaverState> {
  SaverCubit() : super(SaverState.initial());

  Future<void> save({
    required String folderPath,
    required String fileName,
    required BuildContext context,
  }) async {
    // 路径空判定
    if (folderPath.isEmpty || fileName.isEmpty) {
      customDisplayInfoBar(context: context, title: "不行！", content: "你丫的路径是空的");
      return;
    }

    // 文件冲突判定
    var path = '$folderPath\\$fileName.json';
    var file = File(path);
    if (file.existsSync()) {
      showDialog(
        context: context,
        builder: (context) => ContentDialog(
          title: Text(
            '警告!',
            style: defaultTextBlack,
          ),
          content: const Text('文件名冲突！是否要覆盖原有的文件'),
          actions: [
            Button(
                child: const Text('算了'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Button(
                child: const Text('覆盖'),
                onPressed: () {
                  _doWrite(file, context);
                  Navigator.pop(context);
                }),
          ],
        ),
      );
      return;
    }

    // 保存
    _doWrite(file, context);
  }

  Future<void> _doWrite(File file, BuildContext context) async {
    if (!file.existsSync()) {
      file.createSync();
    }
    file
        .writeAsString(await relationChartDataBloc(context).getRawData())
        .then((value) {
      customDisplayInfoBar(
        context: context,
        title: '保存成功',
        content: '文件路径: ${file.path}',
        severity: InfoBarSeverity.success,
      );
    }).catchError((error) {
      customDisplayInfoBar(
        context: context,
        title: '保存失败',
        content: error.toString(),
        severity: InfoBarSeverity.error,
      );
    });
  }
}
