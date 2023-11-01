import 'package:flutter/widgets.dart';
import 'package:neo_cat_flutter/types/enums.dart';
import 'package:neo_cat_flutter/types/graph_edge.dart';
import 'package:neo_cat_flutter/types/graph_node.dart';
import 'package:neo_cat_flutter/types/typdef.dart';

abstract class TripletEditorEvent {
  TripletEditorEvent();
}

class ChooseNode extends TripletEditorEvent {
  ChooseNode({required this.newNode});

  final GraphNode newNode;
}

class RemoveNode extends TripletEditorEvent {
  RemoveNode({required this.position});

  final TripletPosition position;
}

class SetNodeLabel extends TripletEditorEvent {
  SetNodeLabel({required this.label});

  final LabelName label;
}

class ChooseEdge extends TripletEditorEvent {
  ChooseEdge({required this.edge});

  final GraphEdge edge;
}

class ClickTripletNode extends TripletEditorEvent {
  ClickTripletNode(this.position);

  final TripletPosition position;
}

class UpdateNode extends TripletEditorEvent {
  UpdateNode(this.properties, this.name);

  final String name;
  final Map<String, dynamic> properties;
}

class SetEdgeType extends TripletEditorEvent {
  SetEdgeType(this.type);

  final EdgeType type;
}

class CreateType extends TripletEditorEvent {
  CreateType(this.context);

  final BuildContext context;
}

class ResetEdge extends TripletEditorEvent {
  ResetEdge();
}
