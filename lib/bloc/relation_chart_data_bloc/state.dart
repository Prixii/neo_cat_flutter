import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:neo_cat_flutter/types/source_node.dart';
import 'package:neo_cat_flutter/types/source_edge.dart';
import 'package:neo_cat_flutter/types/typdef.dart';

import '../../types/label_data.dart';
import 'relation_chart_data_model.dart';
part 'state.freezed.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 09

@freezed
class RelationChartDataState with _$RelationChartDataState {
  const factory RelationChartDataState({
    required RelationChartDataModel relationChartData,
    required Map<LabelName, LabelData> classMap,
    // TODO 转换为 graph node
    required Map<NodeId, SourceNode> nodeMap,
    // TODO 转换为 graph edge
    required Map<EdgeId, SourceEdge> relationMap,
    required Map<LabelName, bool> classVisibilityMap,
    required Map<LabelName, List<SourceNode>> nodeToClassMap,
  }) = _RelationChartDataState;

  factory RelationChartDataState.initial() => RelationChartDataState(
        relationChartData: RelationChartDataModel.initial(),
        classMap: <LabelName, LabelData>{},
        nodeMap: <NodeId, SourceNode>{},
        relationMap: <EdgeId, SourceEdge>{},
        classVisibilityMap: <LabelName, bool>{},
        nodeToClassMap: <LabelName, List<SourceNode>>{},
      );

  factory RelationChartDataState.fromJson(Map<String, dynamic> json) {
    var relationChartData = RelationChartDataModel.fromJson(json);
    var nodeMap = <NodeId, SourceNode>{};
    for (var node in relationChartData.nodeList) {
      nodeMap[node.id] = node;
    }

    var relationMap = <EdgeId, SourceEdge>{};
    for (var relation in relationChartData.relationList) {
      relationMap[relation.id] = relation;
    }

    var classVisibilityMap = <LabelName, bool>{};
    for (var classData in relationChartData.labelDataList) {
      classVisibilityMap[classData.name] = true;
    }

    var nodeToClassMap = <LabelName, List<SourceNode>>{};
    for (var node in nodeMap.values) {
      var nodeList = nodeToClassMap[node.label] ?? [];
      nodeList.add(node);
      nodeToClassMap[node.label] = nodeList;
    }

    var classMap = <LabelName, LabelData>{};
    for (var classData in relationChartData.labelDataList) {
      classMap[classData.name] = classData;
    }

    return RelationChartDataState(
      relationChartData: relationChartData,
      classMap: classMap,
      nodeMap: nodeMap,
      relationMap: relationMap,
      classVisibilityMap: classVisibilityMap,
      nodeToClassMap: nodeToClassMap,
    );
  }
}
