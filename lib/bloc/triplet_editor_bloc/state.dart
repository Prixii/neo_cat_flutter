import 'package:neo_cat_flutter/types/enums.dart';

import '../../types/graph_edge.dart';
import '../../types/graph_node.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 09

class TripletEditorState {
  final GraphNode? startNode;
  final GraphEdge? edge;
  final GraphNode? endNode;
  final TripletPosition viewMode;
  final GraphNode? showNode;

  TripletEditorState({
    required this.startNode,
    required this.edge,
    required this.endNode,
    required this.viewMode,
    required this.showNode,
  });

  TripletEditorState.initial()
      : startNode = null,
        edge = null,
        endNode = null,
        viewMode = TripletPosition.start,
        showNode = null;

  TripletEditorState copyWith({
    GraphNode? startNode,
    GraphEdge? edge,
    GraphNode? endNode,
    TripletPosition? viewMode,
    GraphNode? showNode,
  }) =>
      TripletEditorState(
        startNode: startNode ?? this.startNode,
        edge: edge ?? this.edge,
        endNode: endNode ?? this.endNode,
        viewMode: viewMode ?? this.viewMode,
        showNode: showNode ?? this.showNode,
      );

  TripletEditorState removeStartNode() {
    var newShowNode = viewMode == TripletPosition.start ? null : showNode;
    return TripletEditorState(
      startNode: null,
      edge: null,
      endNode: endNode,
      viewMode: viewMode,
      showNode: newShowNode,
    );
  }

  TripletEditorState removeEndNode() {
    var newShowNode = viewMode == TripletPosition.end ? null : showNode;
    return TripletEditorState(
      startNode: startNode,
      edge: null,
      endNode: null,
      viewMode: viewMode,
      showNode: newShowNode,
    );
  }
}
