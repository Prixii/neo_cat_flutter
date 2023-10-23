import 'package:neo_cat_flutter/types/enums.dart';

import '../../types/graph_edge.dart';
import '../../types/graph_node.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 09

class TripletEditorState {
  final GraphNode? sourceNode;
  final GraphEdge? edge;
  final GraphNode? endNode;
  final TripletPosition viewMode;

  TripletEditorState({
    required this.sourceNode,
    required this.edge,
    required this.endNode,
    required this.viewMode,
  });

  TripletEditorState.initial()
      : sourceNode = null,
        edge = null,
        endNode = null,
        viewMode = TripletPosition.start;

  TripletEditorState copyWith({
    GraphNode? sourceNode,
    GraphEdge? edge,
    GraphNode? endNode,
    TripletPosition? viewMode,
  }) =>
      TripletEditorState(
        sourceNode: sourceNode ?? this.sourceNode,
        edge: edge ?? this.edge,
        endNode: endNode ?? this.endNode,
        viewMode: viewMode ?? this.viewMode,
      );

  TripletEditorState removeStartNode() {
    return TripletEditorState(
        sourceNode: null, edge: edge, endNode: endNode, viewMode: viewMode);
  }

  TripletEditorState removeEndNode() {
    return TripletEditorState(
        sourceNode: sourceNode, edge: edge, endNode: null, viewMode: viewMode);
  }
}
