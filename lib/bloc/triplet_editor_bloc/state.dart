import 'package:neo_cat_flutter/types/source_node.dart';
import 'package:neo_cat_flutter/types/source_edge.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 09

class TripletEditorState {
  final SourceNode? sourceNode;
  final SourceEdge? relation;
  final SourceNode? endNode;

  TripletEditorState({
    required this.sourceNode,
    required this.relation,
    required this.endNode,
  });

  TripletEditorState.initial()
      : sourceNode = null,
        relation = null,
        endNode = null;

  TripletEditorState copyWith({
    SourceNode? sourceNode,
    SourceEdge? relation,
    SourceNode? endNode,
  }) =>
      TripletEditorState(
        sourceNode: sourceNode ?? this.sourceNode,
        relation: relation ?? this.relation,
        endNode: endNode ?? this.endNode,
      );
  TripletEditorState removeSourceNode() {
    return TripletEditorState(
        sourceNode: null, relation: relation, endNode: endNode);
  }

  TripletEditorState removeEndNode() {
    return TripletEditorState(
        sourceNode: sourceNode, relation: relation, endNode: null);
  }
}
