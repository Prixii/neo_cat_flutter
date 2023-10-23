import 'package:neo_cat_flutter/types/enums.dart';
import 'package:neo_cat_flutter/types/graph_edge.dart';
import 'package:neo_cat_flutter/types/graph_node.dart';

abstract class TripletEditorEvent {
  TripletEditorEvent();
}

class ChooseNode extends TripletEditorEvent {
  final GraphNode newNode;

  ChooseNode({required this.newNode});
}

class RemoveNode extends TripletEditorEvent {
  final TripletPosition position;

  RemoveNode({required this.position});
}

class ChooseRelation extends TripletEditorEvent {
  final GraphEdge relation;

  ChooseRelation({required this.relation});
}

class ClickTripletNode extends TripletEditorEvent {
  final TripletPosition position;

  ClickTripletNode(this.position);
}
