import 'package:neo_cat_flutter/types/node.dart';
import 'package:neo_cat_flutter/types/relation.dart';
import 'package:neo_cat_flutter/types/typdef.dart';

import 'relation_chart_data_model.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 09

class RelationChartDataState {
  late RelationChartDataModel relationChartData;
  late Map<NodeId, Node> nodeMap;
  late Map<RelationId, Relation> relationMap;
  late Map<NodeId, Position> positionMap;

  RelationChartDataState({
    required this.relationChartData,
    required this.nodeMap,
    required this.positionMap,
    required this.relationMap,
  });

  RelationChartDataState.initial()
      : relationChartData = RelationChartDataModel.initial(),
        nodeMap = <NodeId, Node>{},
        positionMap = <NodeId, Position>{},
        relationMap = <RelationId, Relation>{};

  RelationChartDataState.fromJson(Map<String, dynamic> json) {
    relationChartData = RelationChartDataModel.fromJson(json);
    nodeMap = <NodeId, Node>{};
    positionMap = <NodeId, Position>{};
    relationMap = <RelationId, Relation>{};

    for (var node in relationChartData.nodeList) {
      nodeMap[node.id] = node;
    }

    for (var relation in relationChartData.relationList) {
      relationMap[relation.id] = relation;
    }
  }

  RelationChartDataState copyWith({
    RelationChartDataModel? relationChartData,
    Map<NodeId, Node>? nodeMap,
    Map<RelationId, Relation>? relationMap,
    Map<NodeId, Position>? positionMap,
  }) =>
      RelationChartDataState(
        relationChartData: relationChartData ?? this.relationChartData,
        nodeMap: nodeMap ?? this.nodeMap,
        positionMap: positionMap ?? this.positionMap,
        relationMap: this.relationMap,
      );

  Future<Map<NodeId, Position>> getAbsolutePositionMap(
      {required Position center}) async {
    var absolutePositionMap = positionMap;
    for (var key in absolutePositionMap.keys) {
      var relativePosition = absolutePositionMap[key];
      if (relativePosition != null) {
        var absolutePosition = (
          relativePosition.$1 + center.$1,
          relativePosition.$2 + center.$2,
        );
        absolutePositionMap[key] = absolutePosition;
      }
    }
    return absolutePositionMap;
  }

  Future<void> generateRelativePositionMap() async {
    for (var entry in positionMap.entries) {
      var nodeId = entry.key;
      var node = entry.value;
    }
  }

  Triplet? getTriplet(Relation relation) {
    Node? sourceNode = nodeMap[relation.sourceNodeId];
    Node? endNode = nodeMap[relation.endNodeId];
    if (sourceNode != null && endNode != null) {
      return (sourceNode, relation, endNode);
    }
    return null;
  }
}
