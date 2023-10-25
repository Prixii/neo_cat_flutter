import 'package:neo_cat_flutter/types/enums.dart';
import 'package:neo_cat_flutter/types/graph_edge.dart';
import 'package:neo_cat_flutter/types/graph_node.dart';
import 'package:neo_cat_flutter/types/typdef.dart';

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

class SetNodeLabel extends TripletEditorEvent {
  final LabelName label;

  SetNodeLabel({required this.label});
}

class ChooseEdge extends TripletEditorEvent {
  final GraphEdge edge;

  ChooseEdge({required this.edge});
}

class ClickTripletNode extends TripletEditorEvent {
  final TripletPosition position;

  ClickTripletNode(this.position);
}

class UpdateNode extends TripletEditorEvent {
  final Map<String, dynamic> properties;
  final String name;

  UpdateNode(this.properties, this.name);
}
