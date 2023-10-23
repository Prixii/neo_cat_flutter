import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/node/node_event.dart';
import 'package:neo_cat_flutter/types/graph_edge.dart';

import '../../types/graph_node.dart';
import '../../types/label_data.dart';
import '../../types/typdef.dart';
import '../../utils/common_util.dart';
import '../label/label_event.dart';
import '../edge/edge_event.dart';
import 'event.dart';
import 'state.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 08

class RelationChartDataBloc
    extends Bloc<RelationChartDataEvent, RelationChartDataState> {
  RelationChartDataBloc() : super(RelationChartDataState.initial()) {
    on<InitRelationChartData>(
        (event, emit) => emit(_handleInitRelationChartData(event)));
    on<SetLabelVisibility>(
        (event, emit) => emit(_handleSetClassVisibility(event)));
    on<UpdateClassData>((event, emit) => emit(_handleUpdateClassData(event)));
    on<DeleteLabel>((event, emit) => emit(_handleDeleteClass(event)));
    on<UpdateRelation>((event, emit) => emit(_handleUpdateRelation(event)));
    on<DeleteRelation>((event, emit) => emit(_handleDeleteRelation(event)));
    on<CreateLabel>((event, emit) => emit(_handleCreateLabel(event)));
    on<AddNode>((event, emit) => emit(_handleAddNode(event)));
  }

  RelationChartDataState _handleInitRelationChartData(
    InitRelationChartData event,
  ) {
    var state = RelationChartDataState.fromJson(jsonDecode(event.rawData));
    logger.i('[relationChartDataEvent]: initRelationChartData!');
    return state;
  }

  RelationChartDataState _handleSetClassVisibility(SetLabelVisibility event) {
    var labelVisibilityMap = state.labelVisibilityMap;
    logger.i('[classBrowser]: SetClassVisible!');
    if (labelVisibilityMap[event.labelName] != null) {
      labelVisibilityMap[event.labelName] =
          !labelVisibilityMap[event.labelName]!;
      return state.copyWith(labelVisibilityMap: labelVisibilityMap);
    }
    return state;
  }

  RelationChartDataState _handleUpdateClassData(UpdateClassData event) {
    /// 未改名则不需要更新map
    if (event.oldName == event.classData.name) {
      var labelMap = state.labelMap;
      labelMap[event.oldName] = event.classData;
      return state.copyWith(labelMap: labelMap);
    } else {
      /// 类已经被改名了
      var labelMap = state.labelMap;
      var labelVisibilityMap = state.labelVisibilityMap;
      labelVisibilityMap[event.classData.name] =
          labelVisibilityMap[event.oldName] ?? true;
      labelVisibilityMap.remove(event.oldName);

      var nodeToLabelMap = state.nodeToLabelMap;
      nodeToLabelMap[event.classData.name] =
          nodeToLabelMap[event.oldName] ?? [];
      nodeToLabelMap.remove(event.oldName);
      logger.i('[classBrowser]: updateClassData renamed!');
      return state.copyWith(
        nodeToLabelMap: nodeToLabelMap,
        labelMap: labelMap,
        labelVisibilityMap: labelVisibilityMap,
      );
    }
  }

  /// 确保class没有实例！！！
  RelationChartDataState _handleDeleteClass(DeleteLabel event) {
    var labelMap = state.labelMap..remove(event.labelName);
    var classVisiblityMap = state.labelVisibilityMap..remove(event.labelName);
    var nodeToLabelMap = state.nodeToLabelMap..remove(event.labelName);

    logger.i('[classBrowser]: DeleteClassData!');

    return state.copyWith(
      nodeToLabelMap: nodeToLabelMap,
      labelVisibilityMap: classVisiblityMap,
      labelMap: labelMap,
    );
  }

  RelationChartDataState _handleUpdateRelation(UpdateRelation event) {
    var edgeMap = state.edgeMap;
    edgeMap[event.edge.id] = event.edge;
    return state.copyWith(edgeMap: edgeMap);
  }

  RelationChartDataState _handleDeleteRelation(DeleteRelation event) {
    return state.copyWith(edgeMap: state.edgeMap..remove(event.targetId));
  }

  RelationChartDataState _handleCreateLabel(CreateLabel event) {
    var labelMap = <LabelName, LabelData>{}..addAll(state.labelMap);
    labelMap[event.labelData.name] = event.labelData;
    var labelVisibilityMap = <LabelName, bool>{}
      ..addAll(state.labelVisibilityMap);
    labelVisibilityMap[event.labelData.name] = true;
    logger.d(labelMap);
    return state.copyWith(
        labelMap: labelMap, labelVisibilityMap: labelVisibilityMap);
  }

  RelationChartDataState _handleAddNode(AddNode event) {
    var nodeMap = <NodeId, GraphNode>{}..addAll(state.nodeMap);
    var node = event.node;
    nodeMap[node.id] = event.node;

    var nodeToLabelMap = <LabelName, List<GraphNode>>{}
      ..addAll(state.nodeToLabelMap);
    var nodeList = nodeToLabelMap[event.node.label] ?? [];
    nodeList.add(event.node);
    nodeToLabelMap[event.node.label] = nodeList;

    state.graph!.addNode(event.node);
    return state.copyWith(nodeMap: nodeMap, nodeToLabelMap: nodeToLabelMap);
  }

  Triplet? getTriplet(GraphEdge edge) {
    GraphNode? sourceNode = state.nodeMap[edge.start];
    GraphNode? endNode = state.nodeMap[edge.end];
    if (sourceNode != null && endNode != null) {
      return (sourceNode, edge, endNode);
    }
    return null;
  }

  int instanceCount(LabelName className) =>
      state.nodeToLabelMap[className]?.length ?? 0;

  Future<void> save() async {
    // var rawData = jsonEncode(state.relationChartData.toJson());
    // TODO 保存
  }

  GraphNode getGraphNode(NodeId id) {
    return state.nodeMap[id]!;
  }
}
