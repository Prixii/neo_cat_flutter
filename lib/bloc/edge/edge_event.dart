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
  InitRelationBrowserState({required this.model});

  final RelationChartDataModel model;
}

/// 更新/添加 [edge] 到Map
class UpdateEdge extends RelationBrowserEvent {
  UpdateEdge({required this.edge, required this.oldType});

  final GraphEdge edge;
  final EdgeType oldType;
}

/// 移除 [edge] 的关系
class DeleteEdge extends RelationBrowserEvent {
  DeleteEdge({required this.edge});

  final GraphEdge edge;
}

class CreateEdge extends RelationBrowserEvent {
  CreateEdge(this.edge);

  final GraphEdge edge;
}

class CreateEdgeTypeAndAddEdge extends RelationBrowserEvent {
  CreateEdgeTypeAndAddEdge(this.type, this.edge);

  final GraphEdge edge;
  final EdgeType type;
}

class DeleteEdgeType extends RelationBrowserEvent {
  DeleteEdgeType(this.type);

  final EdgeType type;
}
