import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/global/event/relation_chart_data_event.dart';
import 'package:neo_cat_flutter/bloc/global/model/triplet_data_model.dart';
import 'package:neo_cat_flutter/bloc/global/state/relation_chart_data_state.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

class RelationChartDataBloc
    extends Bloc<RelationChartDataEvent, RelationChartDataState> {
  RelationChartDataBloc() : super(RelationChartDataState.initial()) {
    on<ChooseNodeEvent>(
      (event, emit) => emit(_handleChooseNodeEvent(event)),
    );
    on<RemoveNodeFromTripletEvent>(
      (event, emit) => emit(_handleRemoveNodeEvent(event)),
    );
  }

  RelationChartDataState _handleChooseNodeEvent(ChooseNodeEvent event) {
    final TripletDataModel oldTripletModel = state.tripletDataModel;
    TripletDataModel newTripletModel;
    if (oldTripletModel.sourceNode == null) {
      newTripletModel = oldTripletModel.copyWith(sourceNode: event.node);
      logger.d('[add source node] ${event.node.toJson()}');
    } else if (oldTripletModel.endNode == null) {
      newTripletModel = oldTripletModel.copyWith(endNode: event.node);
      logger.d('[add end node] ${event.node.toJson()}');
    } else {
      logger.d('[editor is full]');
      return state;
    }
    return state.copyWith(tripletDataModel: newTripletModel);
  }

  RelationChartDataState _handleRemoveNodeEvent(
      RemoveNodeFromTripletEvent event) {
    final TripletDataModel oldTripletModel = state.tripletDataModel;
    TripletDataModel newTripletModel =
        oldTripletModel.remove(nodeIndex: event.nodeIndex);
    return state.copyWith(tripletDataModel: newTripletModel);
  }
}
