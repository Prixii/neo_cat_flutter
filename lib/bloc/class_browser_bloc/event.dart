import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/relation_chart_data_model.dart';
import 'package:neo_cat_flutter/types/class_data.dart';
import 'package:neo_cat_flutter/types/typdef.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 14

abstract class ClassBrowserEvent {
  ClassBrowserEvent();
}

/// 使用RelationChartData中的 [model] 来初始化
class InitClassBrowserState extends ClassBrowserEvent {
  final RelationChartDataModel model;

  InitClassBrowserState({required this.model});
}

/// 设置 [className] 的可见性
class SetIsClassVisible extends ClassBrowserEvent {
  final ClassName className;

  SetIsClassVisible({required this.className});
}

/// 更新某个类的数据到 [classData]
class UpdateClassData extends ClassBrowserEvent {
  final ClassData classData;
  final ClassName oldName;

  UpdateClassData({required this.classData, required this.oldName});
}

/// 删除名为 [className] 的类
class DeleteClassData extends ClassBrowserEvent {
  final ClassName className;

  DeleteClassData({required this.className});
}
