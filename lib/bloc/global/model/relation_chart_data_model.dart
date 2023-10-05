import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:neo_cat_flutter/types/node.dart';
import 'package:neo_cat_flutter/types/relation.dart';

part 'relation_chart_data_model.g.dart';

/// @author wang.jiaqi
/// @date 2023-10-05 19

@JsonSerializable()
class RelationChartDataModel extends Equatable {
  final List<BaseNode> nodeList;
  final List<BaseRelation> relationList;

  const RelationChartDataModel({
    required this.nodeList,
    required this.relationList,
  });

  RelationChartDataModel.initial()
      : nodeList = [],
        relationList = [];

  RelationChartDataModel copyWith(
      List<BaseNode>? nodeList, List<BaseRelation>? relationList) {
    return RelationChartDataModel(
      nodeList: nodeList ?? this.nodeList,
      relationList: relationList ?? this.relationList,
    );
  }

  factory RelationChartDataModel.fromJson(Map<String, dynamic> json) =>
      _$RelationChatDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$RelationChatDataModelToJson(this);

  @override
  List<Object?> get props => [nodeList, relationList];
}
