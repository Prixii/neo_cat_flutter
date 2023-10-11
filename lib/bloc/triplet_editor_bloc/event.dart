import 'package:neo_cat_flutter/types/enums.dart';
import 'package:neo_cat_flutter/types/node.dart';
import 'package:neo_cat_flutter/types/relation.dart';

abstract class TripletEditorEvent {
  TripletEditorEvent();
}

class ChooseNode extends TripletEditorEvent {
  final Node newNode;

  ChooseNode({required this.newNode});
}

class RemoveNode extends TripletEditorEvent {
  final TripletPosition position;

  RemoveNode({required this.position});
}

class ChooseRelation extends TripletEditorEvent {
  final Relation relation;

  ChooseRelation({required this.relation});
}
