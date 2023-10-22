import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/event.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/relation_chart_data_model.dart';
import 'package:neo_cat_flutter/types/label_data.dart';
import 'package:neo_cat_flutter/types/typdef.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 14

abstract class LabelEvent extends RelationChartDataEvent {
  LabelEvent();
}

/// 使用RelationChartData中的 [model] 来初始化
class InitClassBrowserState extends LabelEvent {
  final RelationChartDataModel model;

  InitClassBrowserState({required this.model});
}

/// 设置 [className] 的可见性
class SetClassVisibility extends LabelEvent {
  final LabelName className;

  SetClassVisibility({required this.className});
}

/// 更新某个类的数据到 [classData]
class UpdateClassData extends LabelEvent {
  final LabelData classData;
  final LabelName oldName;

  UpdateClassData({required this.classData, required this.oldName});
}

/// 删除名为 [className] 的类
class DeleteClassData extends LabelEvent {
  final LabelName className;

  DeleteClassData({required this.className});
}

class CreateLabel extends LabelEvent {
  final LabelData classData;

  CreateLabel({required this.classData});
}
