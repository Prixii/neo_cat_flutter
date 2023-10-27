import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/event.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/relation_chart_data_model.dart';
import 'package:neo_cat_flutter/types/graph_edge.dart';
import 'package:neo_cat_flutter/types/typdef.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 15

abstract class RelationBrowserEvent extends RelationChartDataEvent {
  RelationBrowserEvent();
}

/// 使用 [model] 来初始化
class InitRelationBrowserState extends RelationBrowserEvent {
  final RelationChartDataModel model;

  InitRelationBrowserState({required this.model});
}

/// 更新/添加 [edge] 到Map
class UpdateEdge extends RelationBrowserEvent {
  final GraphEdge edge;

  UpdateEdge({required this.edge});
}

/// 移除 [edge] 的关系
class DeleteEdge extends RelationBrowserEvent {
  final GraphEdge edge;

  DeleteEdge({required this.edge});
}

class CreateEdge extends RelationBrowserEvent {
  final GraphEdge edge;

  CreateEdge(this.edge);
}

class CreateEdgeType extends RelationBrowserEvent {
  final EdgeType type;

  CreateEdgeType(this.type);
}
