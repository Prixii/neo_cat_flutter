import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/event.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/state.dart';
import 'package:neo_cat_flutter/types/enums.dart';
import 'package:neo_cat_flutter/types/relation.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

import '../relation_chart_data_bloc/bloc.dart';

class TripletEditorBloc extends Bloc<TripletEditorEvent, TripletEditorState> {
  final RelationChartDataBloc dataBloc;

  TripletEditorBloc({required this.dataBloc})
      : super(TripletEditorState.initial()) {
    on<ChooseNode>((event, emit) => emit(_handleChooseNode(event)));
    on<RemoveNode>((event, emit) => emit(_handleRemoveNode(event)));
    on<ChooseRelation>((event, emit) => emit(_handleChooseRelation(event)));
  }

  TripletEditorState _handleChooseNode(ChooseNode event) {
    if (state.sourceNode == null) {
      if (state.endNode != null) {
        getRelation();
      }
      return state.copyWith(sourceNode: event.newNode);
    } else if (state.endNode == null) {
      if (state.sourceNode != null) {
        getRelation();
      }
      return state.copyWith(endNode: event.newNode);
    } else {
      return state;
    }
  }

  TripletEditorState _handleRemoveNode(RemoveNode event) {
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
    var newState = state.copyWith(relation: event.relation);
    return newState;
  }

  BaseRelation? getRelation() {
    var relationList = dataBloc.state.relationChartData.relationList;
    logger.d(relationList);
  }
}
