import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';
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
  final Color startNodeBorder;
  final Color endNodeBorder;
  TripletEditorState({
    required this.startNode,
    required this.edge,
    required this.endNode,
    required this.viewMode,
    required this.showNode,
    required this.startNodeBorder,
    required this.endNodeBorder,
  });

  TripletEditorState.initial()
      : startNode = null,
        edge = null,
        endNode = null,
        viewMode = TripletPosition.start,
        showNode = null,
        startNodeBorder = opacity,
        endNodeBorder = opacity;

  TripletEditorState copyWith({
    GraphNode? startNode,
    GraphEdge? edge,
    GraphNode? endNode,
    TripletPosition? viewMode,
    GraphNode? showNode,
    Color? startNodeBorder,
    Color? endNodeBorder,
  }) =>
      TripletEditorState(
        startNode: startNode ?? this.startNode,
        edge: edge ?? this.edge,
        endNode: endNode ?? this.endNode,
        viewMode: viewMode ?? this.viewMode,
        showNode: showNode ?? this.showNode,
        startNodeBorder: startNodeBorder ?? this.startNodeBorder,
        endNodeBorder: endNodeBorder ?? this.endNodeBorder,
      );

  TripletEditorState removeStartNode() {
    var newShowNode = viewMode == TripletPosition.start ? null : showNode;
    if (endNode != null) {
      return TripletEditorState(
        showNode: endNode,
        startNodeBorder: opacity,
        endNodeBorder: selectedColor,
        startNode: null,
        edge: null,
        endNode: endNode,
        viewMode: TripletPosition.end,
      );
    }
    return TripletEditorState(
      startNode: null,
      edge: null,
      endNode: endNode,
      viewMode: viewMode,
      showNode: newShowNode,
      startNodeBorder: opacity,
      endNodeBorder: endNodeBorder,
    );
  }

  TripletEditorState removeEndNode() {
    var newShowNode = viewMode == TripletPosition.end ? null : showNode;
    if (startNode != null) {
      return TripletEditorState(
        showNode: startNode,
        startNodeBorder: selectedColor,
        endNodeBorder: opacity,
        startNode: startNode,
        edge: null,
        endNode: null,
        viewMode: TripletPosition.start,
      );
    }
    return TripletEditorState(
      startNode: startNode,
      edge: null,
      endNode: null,
      viewMode: viewMode,
      showNode: newShowNode,
      startNodeBorder: startNodeBorder,
      endNodeBorder: opacity,
    );
  }
}
