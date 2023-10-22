import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:neo_cat_flutter/types/node.dart';
import 'package:neo_cat_flutter/types/relation.dart';
import 'package:neo_cat_flutter/types/typdef.dart';

import '../../types/class_data.dart';
import 'relation_chart_data_model.dart';
part 'state.freezed.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 09

@freezed
class RelationChartDataState with _$RelationChartDataState {
  const factory RelationChartDataState({
    required RelationChartDataModel relationChartData,
    required Map<ClassName, ClassData> classMap,
    required Map<NodeId, Node> nodeMap,
    required Map<RelationId, Relation> relationMap,
    required Map<NodeId, Position> positionMap,
    required Map<ClassName, bool> classVisibilityMap,
    required Map<ClassName, List<Node>> nodeToClassMap,
  }) = _RelationChartDataState;

  factory RelationChartDataState.initial() => RelationChartDataState(
        relationChartData: RelationChartDataModel.initial(),
        classMap: <ClassName, ClassData>{},
        nodeMap: <NodeId, Node>{},
        relationMap: <RelationId, Relation>{},
        positionMap: <NodeId, Position>{},
        classVisibilityMap: <ClassName, bool>{},
        nodeToClassMap: <ClassName, List<Node>>{},
      );

  factory RelationChartDataState.fromJson(Map<String, dynamic> json) {
    var relationChartData = RelationChartDataModel.fromJson(json);
    var nodeMap = <NodeId, Node>{};
    for (var node in relationChartData.nodeList) {
      nodeMap[node.id] = node;
    }

    var relationMap = <RelationId, Relation>{};
    for (var relation in relationChartData.relationList) {
      relationMap[relation.id] = relation;
    }
    // TODO 初始化的时候，生成一个positionMap
    var positionMap = <NodeId, Position>{};

    var classVisibilityMap = <ClassName, bool>{};
    for (var classData in relationChartData.classDataList) {
      classVisibilityMap[classData.name] = true;
    }

    var nodeToClassMap = <ClassName, List<Node>>{};
    for (var node in nodeMap.values) {
      var nodeList = nodeToClassMap[node.className] ?? [];
      nodeList.add(node);
      nodeToClassMap[node.className] = nodeList;
    }

    var classMap = <ClassName, ClassData>{};
    for (var classData in relationChartData.classDataList) {
      classMap[classData.name] = classData;
    }

    return RelationChartDataState(
      relationChartData: relationChartData,
      classMap: classMap,
      nodeMap: nodeMap,
      positionMap: positionMap,
      relationMap: relationMap,
      classVisibilityMap: classVisibilityMap,
      nodeToClassMap: nodeToClassMap,
    );
  }
}
