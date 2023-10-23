import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/event.dart';
import 'package:neo_cat_flutter/types/label_data.dart';
import 'package:neo_cat_flutter/types/typdef.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 14

abstract class LabelEvent extends RelationChartDataEvent {
  LabelEvent();
}

/// 设置 [labelName] 的可见性
class SetLabelVisibility extends LabelEvent {
  final LabelName labelName;

  SetLabelVisibility({required this.labelName});
}

/// 更新某个类的数据到 [classData]
class UpdateClassData extends LabelEvent {
  final LabelData classData;
  final LabelName oldName;

  UpdateClassData({required this.classData, required this.oldName});
}

/// 删除名为 [labelName] 的类
class DeleteLabel extends LabelEvent {
  final LabelName labelName;

  DeleteLabel({required this.labelName});
}

class CreateLabel extends LabelEvent {
  final LabelData labelData;

  CreateLabel({required this.labelData});
}
