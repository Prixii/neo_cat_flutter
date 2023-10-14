import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/event.dart';

import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/state.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 08

class RelationChartDataBloc
    extends Bloc<RelationChartDataEvent, RelationChartDataState> {
  RelationChartDataBloc() : super(RelationChartDataState.initial()) {
    on<InitRelationChartData>(
        (event, emit) => emit(_handleInitRelationChartData(event)));
    on<ReplacePositionMap>(
        (event, emit) => emit(_handleReplacePositionMap(event)));
  }

  RelationChartDataState _handleInitRelationChartData(
    InitRelationChartData event,
  ) {
    var state = RelationChartDataState.fromJson(jsonDecode(event.rawData));
    logger.i('[relationChartDataEvent]: initRelationChartData!');
    return state;
  }

  RelationChartDataState _handleReplacePositionMap(
    ReplacePositionMap event,
  ) {
    logger.i('[relationChartDataEvent]: replacePositionMap!');
    return state.copyWith(positionMap: event.positionMap);
  }
}
