import '../../types/graph_edge.dart';
import '../../types/graph_node.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 09

class TripletEditorState {
  final GraphNode? sourceNode;
  final GraphEdge? edge;
  final GraphNode? endNode;

  TripletEditorState({
    required this.sourceNode,
    required this.edge,
    required this.endNode,
  });

  TripletEditorState.initial()
      : sourceNode = null,
        edge = null,
        endNode = null;

  TripletEditorState copyWith({
    GraphNode? sourceNode,
    GraphEdge? edge,
    GraphNode? endNode,
  }) =>
      TripletEditorState(
        sourceNode: sourceNode ?? this.sourceNode,
        edge: edge ?? this.edge,
        endNode: endNode ?? this.endNode,
      );
  TripletEditorState removeStartNode() {
    return TripletEditorState(sourceNode: null, edge: edge, endNode: endNode);
  }

  TripletEditorState removeEndNode() {
    return TripletEditorState(
        sourceNode: sourceNode, edge: edge, endNode: null);
  }
}
