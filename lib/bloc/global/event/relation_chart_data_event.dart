import 'package:equatable/equatable.dart';
import 'package:neo_cat_flutter/types/node.dart';
import 'package:neo_cat_flutter/types/relation.dart';

/// @author wang.jiaqi
/// @date 2023-10-05 20

abstract class RelationChartDataEvent extends Equatable {
  const RelationChartDataEvent();
}

class ChooseNodeEvent extends RelationChartDataEvent {
  final BaseNode node;

  const ChooseNodeEvent({required this.node});

  @override
  List<Object?> get props => [node];
}

class RemoveNodeFromTripletEvent extends RelationChartDataEvent {
  final int nodeIndex;

  const RemoveNodeFromTripletEvent({required this.nodeIndex});

  @override
  List<Object?> get props => [nodeIndex];
}

class SetTripletEvent extends RelationChartDataEvent {
  final BaseNode sourceNode;
  final BaseRelation relation;
  final BaseNode endNode;

  const SetTripletEvent({
    required this.sourceNode,
    required this.relation,
    required this.endNode,
  });

  @override
  List<Object?> get props => [sourceNode, relation, endNode];
}

class UpdateTripletEvent extends RelationChartDataEvent {
  final BaseNode sourceNode;
  final BaseRelation relation;
  final BaseNode endNode;

  const UpdateTripletEvent({
    required this.sourceNode,
    required this.relation,
    required this.endNode,
  });

  @override
  List<Object?> get props => [sourceNode, relation, endNode];
}
