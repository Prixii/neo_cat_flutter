import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/bloc_util.dart';
import 'state.dart';

class SaverCubit extends Cubit<SaverState> {
  SaverCubit() : super(SaverState.initial());

  Future<void> onSave({
    required String folderPath,
    required String fileName,
    required BuildContext context,
  }) async {
    // 路径空判定
    if (folderPath.isEmpty || fileName.isEmpty) {
      emit(state.copyWith(isAlertVisible: false, alertMessage: '路径为空'));
      return;
    }

    // 文件冲突判定
    var path = '$folderPath\\$fileName.json';
    var file = File(path);
    if (file.existsSync()) {
      emit(state.copyWith(isNameConflict: true));
      return;
    }

    // 保存
    doWrite(file, context);
  }

  Future<void> forceWrite({
    required String folderPath,
    required String fileName,
    required BuildContext context,
  }) async {
    var path = '$folderPath\\$fileName.json';
    var file = File(path);
    doWrite(file, context);
  }

  Future<void> doWrite(File file, BuildContext context) async {
    file.createSync();
    file
        .writeAsString(await relationChartDataBloc(context).getRawData())
        .then((value) => true)
        .catchError((error) => false);
  }
}
