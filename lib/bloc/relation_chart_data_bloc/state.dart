import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:neo_cat_flutter/types/graph_edge.dart';
import 'package:neo_cat_flutter/types/typdef.dart';

import '../../components/common/graphview/graph.dart';
import '../../types/graph_node.dart';
import '../../types/label_data.dart';
import 'relation_chart_data_model.dart';
part 'state.freezed.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 09

@freezed
class RelationChartDataState with _$RelationChartDataState {
  const factory RelationChartDataState({
    required RelationChartDataModel relationChartData,
    required Map<LabelName, LabelData> labelMap,
    required Map<NodeId, GraphNode> nodeMap,
    required Map<EdgeId, GraphEdge> edgeMap,
    required Map<LabelName, bool> labelVisibilityMap,
    required Map<LabelName, List<GraphNode>> nodeToLabelMap,
    required Set<EdgeType> edgeTypes,
    // TODO edge to type
    @Default(false) bool forceRefreshFlag,
    Graph? graph,
  }) = _RelationChartDataState;

  factory RelationChartDataState.initial() => RelationChartDataState(
        relationChartData: RelationChartDataModel.initial(),
        labelMap: <LabelName, LabelData>{},
        nodeMap: <NodeId, GraphNode>{},
        edgeMap: <EdgeId, GraphEdge>{},
        labelVisibilityMap: <LabelName, bool>{},
        nodeToLabelMap: <LabelName, List<GraphNode>>{},
        forceRefreshFlag: false,
        graph: Graph(
          edges: [],
          nodes: [],
          graphObserver: [],
        ),
        edgeTypes: {},
      );

  factory RelationChartDataState.fromJson(Map<String, dynamic> json) {
    var relationChartData = RelationChartDataModel.fromJson(json);
    var nodeMap = <NodeId, GraphNode>{};
    for (var node in relationChartData.nodeList) {
      nodeMap[node.id] = GraphNode.fromNode(node);
    }

    var edgeTypes = <EdgeType>{};
    var edgeMap = <EdgeId, GraphEdge>{};
    for (var edge in relationChartData.edgeList) {
      edgeTypes.add(edge.type);
      var newEdge = GraphEdge.fromSourceEdge(edge, nodeMap);
      if (newEdge != null) {
        edgeMap[edge.id] = newEdge;
      }
    }

    var classVisibilityMap = <LabelName, bool>{};
    for (var classData in relationChartData.labelDataList) {
      classVisibilityMap[classData.name] = true;
    }

    var nodeToLabelMap = <LabelName, List<GraphNode>>{};
    for (var node in nodeMap.values) {
      var nodeList = nodeToLabelMap[node.label] ?? [];
      nodeList.add(node);
      nodeToLabelMap[node.label] = nodeList;
    }

    var classMap = <LabelName, LabelData>{};
    for (var classData in relationChartData.labelDataList) {
      classMap[classData.name] = classData;
    }

    var graph = Graph(
        nodes: nodeMap.values.toList(),
        edges: edgeMap.values.toList(),
        graphObserver: []);

    return RelationChartDataState(
      relationChartData: relationChartData,
      labelMap: classMap,
      nodeMap: nodeMap,
      edgeMap: edgeMap,
      labelVisibilityMap: classVisibilityMap,
      nodeToLabelMap: nodeToLabelMap,
      forceRefreshFlag: false,
      graph: graph,
      edgeTypes: edgeTypes,
    );
  }
}
