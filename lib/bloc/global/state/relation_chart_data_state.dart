import 'package:equatable/equatable.dart';
import 'package:neo_cat_flutter/bloc/global/model/relation_chart_data_model.dart';
import 'package:neo_cat_flutter/bloc/global/model/triplet_data_model.dart';

/// @author wang.jiaqi
/// @date 2023-10-05 20

class RelationChartDataState extends Equatable {
  final RelationChartDataModel chartDataModel;
  final TripletDataModel tripletDataModel;

  const RelationChartDataState({
    required this.chartDataModel,
    required this.tripletDataModel,
  });

  RelationChartDataState.initial()
      : chartDataModel = RelationChartDataModel.initial(),
        tripletDataModel = const TripletDataModel.initial();

  RelationChartDataState copyWith({
    RelationChartDataModel? chartDataModel,
    TripletDataModel? tripletDataModel,
  }) {
    return RelationChartDataState(
      chartDataModel: chartDataModel ?? this.chartDataModel,
      tripletDataModel: tripletDataModel ?? this.tripletDataModel,
    );
  }

  @override
  List<Object?> get props => [chartDataModel, tripletDataModel];
}
