import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:neo_cat_flutter/types/class_data.dart';
import 'package:neo_cat_flutter/types/node.dart';
import 'package:neo_cat_flutter/types/relation.dart';

part 'relation_chart_data_model.g.dart';

/// @author wang.jiaqi
/// @date 2023-10-05 19

@JsonSerializable()
class RelationChartDataModel extends Equatable {
  final List<BaseNode> nodeList;
  final List<BaseRelation> relationList;
  final List<ClassData> classDataList;

  const RelationChartDataModel(
      {required this.nodeList,
      required this.relationList,
      required this.classDataList});

  RelationChartDataModel.initial()
      : nodeList = [],
        relationList = [],
        classDataList = <ClassData>[];

  RelationChartDataModel copyWith(List<BaseNode>? nodeList,
      List<BaseRelation>? relationList, List<ClassData>? classDataList) {
    return RelationChartDataModel(
      nodeList: nodeList ?? this.nodeList,
      relationList: relationList ?? this.relationList,
      classDataList: classDataList ?? this.classDataList,
    );
  }

  factory RelationChartDataModel.fromJson(Map<String, dynamic> json) =>
      _$RelationChartDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$RelationChartDataModelToJson(this);

  @override
  List<Object?> get props => [nodeList, relationList];
}
