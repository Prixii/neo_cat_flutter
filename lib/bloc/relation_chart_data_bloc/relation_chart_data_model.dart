import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:neo_cat_flutter/types/node.dart';
import 'package:neo_cat_flutter/types/relation.dart';

import '../../types/label_data.dart';

part 'relation_chart_data_model.g.dart';
part 'relation_chart_data_model.freezed.dart';

/// @author wang.jiaqi
/// @date 2023-10-05 19

@freezed
class RelationChartDataModel with _$RelationChartDataModel {
  const factory RelationChartDataModel({
    required List<Node> nodeList,
    required List<Relation> relationList,
    required List<LabelData> labelDataList,
  }) = _RelationChartDataModel;

  factory RelationChartDataModel.fromJson(Map<String, dynamic> json) =>
      _$RelationChartDataModelFromJson(json);

  factory RelationChartDataModel.initial() => const RelationChartDataModel(
        nodeList: [],
        relationList: [],
        labelDataList: <LabelData>[],
      );
}
