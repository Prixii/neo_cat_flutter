import 'package:neo_cat_flutter/types/node.dart';
import 'package:neo_cat_flutter/types/relation.dart';
import 'package:neo_cat_flutter/types/typdef.dart';

import 'relation_chart_data_model.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 09

class RelationChartDataState {
  late RelationChartDataModel relationChartData;
  late Map<NodeId, BaseNode> nodeMap;
  late Map<RelationId, BaseRelation> relationMap;
  late Map<NodeId, Position> positionMap;

  RelationChartDataState({
    required this.relationChartData,
    required this.nodeMap,
    required this.positionMap,
    required this.relationMap,
  });

  RelationChartDataState.initial()
      : relationChartData = RelationChartDataModel.initial(),
        nodeMap = <NodeId, BaseNode>{},
        positionMap = <NodeId, Position>{},
        relationMap = <RelationId, BaseRelation>{};

  RelationChartDataState.fromJson(Map<String, dynamic> json) {
    relationChartData = RelationChartDataModel.fromJson(json);

    nodeMap = <NodeId, BaseNode>{};
    positionMap = <NodeId, Position>{};
    relationMap = <RelationId, BaseRelation>{};

    for (var node in relationChartData.nodeList) {
      nodeMap[node.id] = node;
    }

    for (var relation in relationChartData.relationList) {
      relationMap[relation.id] = relation;
    }
  }

  RelationChartDataState copyWith({
    RelationChartDataModel? relationChartData,
    Map<NodeId, BaseNode>? nodeMap,
    Map<RelationId, BaseRelation>? relationMap,
    Map<NodeId, Position>? positionMap,
  }) =>
      RelationChartDataState(
        relationChartData: relationChartData ?? this.relationChartData,
        nodeMap: nodeMap ?? this.nodeMap,
        positionMap: positionMap ?? this.positionMap,
        relationMap: this.relationMap,
      );
}
