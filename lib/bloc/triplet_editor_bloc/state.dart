import 'package:neo_cat_flutter/types/node.dart';
import 'package:neo_cat_flutter/types/relation.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 09

class TripletEditorState {
  final Node? sourceNode;
  final Relation? relation;
  final Node? endNode;

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
    Node? sourceNode,
    Relation? relation,
    Node? endNode,
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
