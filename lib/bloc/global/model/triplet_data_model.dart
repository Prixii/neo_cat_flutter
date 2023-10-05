import 'package:equatable/equatable.dart';
import 'package:neo_cat_flutter/types/node.dart';
import 'package:neo_cat_flutter/types/relation.dart';

class TripletDataModel extends Equatable {
  final BaseNode? sourceNode;
  final BaseRelation? relation;
  final BaseNode? endNode;

  const TripletDataModel({
    required this.sourceNode,
    required this.relation,
    required this.endNode,
  });

  const TripletDataModel.initial()
      : sourceNode = null,
        relation = null,
        endNode = null;

  TripletDataModel copyWith(
      {BaseNode? sourceNode, BaseRelation? relation, BaseNode? endNode}) {
    return TripletDataModel(
      sourceNode: sourceNode ?? this.sourceNode,
      relation: relation ?? this.relation,
      endNode: endNode ?? this.endNode,
    );
  }

  TripletDataModel remove({required int nodeIndex}) {
    return TripletDataModel(
      sourceNode: (nodeIndex == 0) ? null : sourceNode,
      relation: null,
      endNode: (nodeIndex == 1) ? null : endNode,
    );
  }

  @override
  List<Object?> get props => [sourceNode, relation, endNode];
}
