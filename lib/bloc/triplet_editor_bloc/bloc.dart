import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/event.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/state.dart';
import 'package:neo_cat_flutter/types/enums.dart';
import 'package:neo_cat_flutter/types/relation.dart';
import 'package:neo_cat_flutter/types/typdef.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

class TripletEditorBloc extends Bloc<TripletEditorEvent, TripletEditorState> {
  final RelationChartDataBloc dataBloc;

  TripletEditorBloc({required this.dataBloc})
      : super(TripletEditorState.initial()) {
    on<ChooseNode>((event, emit) async => emit(await _handleChooseNode(event)));
    on<RemoveNode>((event, emit) => emit(_handleRemoveNode(event)));
    on<ChooseRelation>((event, emit) => emit(_handleChooseRelation(event)));
  }

  Future<TripletEditorState> _handleChooseNode(ChooseNode event) async {
    logger.i('[tripletEditorState]: ChooseNode!');
    var sourceNode = state.sourceNode;
    var endNode = state.endNode;
    if (sourceNode == null) {
      sourceNode = event.newNode;
      Relation? relation;
      if (endNode != null) {
        relation = await getRelation(sourceNode.id, endNode.id);
      }
      return state.copyWith(sourceNode: event.newNode, relation: relation);
    } else if (endNode == null) {
      endNode = event.newNode;
      var relation = await getRelation(sourceNode.id, endNode.id);
      return state.copyWith(endNode: endNode, relation: relation);
    } else {
      return state;
    }
  }

  TripletEditorState _handleRemoveNode(RemoveNode event) {
    logger.i('[tripletEditorState]: RemoveNode!');
    switch (event.position) {
      case TripletPosition.source:
        {
          return state.removeSourceNode();
        }
      case TripletPosition.end:
        {
          return state.removeEndNode();
        }
    }
  }

  TripletEditorState _handleChooseRelation(ChooseRelation event) {
    logger.i('[tripletEditorState]: ChooseRelation!');
    var newState = state.copyWith(relation: event.relation);
    return newState;
  }

  Future<Relation?> getRelation(NodeId source, NodeId end) async {
    var relationList = dataBloc.state.relationChartData.relationList;
    for (var relation in relationList) {
      if (relation.start == source && relation.end == end) {
        return relation;
      }
    }
    return null;
  }
}
