import 'package:neo_cat_flutter/types/enums.dart';
import 'package:neo_cat_flutter/types/source_node.dart';
import 'package:neo_cat_flutter/types/source_edge.dart';

abstract class TripletEditorEvent {
  TripletEditorEvent();
}

class ChooseNode extends TripletEditorEvent {
  final SourceNode newNode;

  ChooseNode({required this.newNode});
}

class RemoveNode extends TripletEditorEvent {
  final TripletPosition position;

  RemoveNode({required this.position});
}

class ChooseRelation extends TripletEditorEvent {
  final SourceEdge relation;

  ChooseRelation({required this.relation});
}
