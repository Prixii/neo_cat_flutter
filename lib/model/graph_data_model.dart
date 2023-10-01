import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:neo_cat_flutter/types/node.dart';
import 'package:neo_cat_flutter/types/relation.dart';

part 'graph_data_model.g.dart';

/// @author wang.jiaqi
/// @date 2023-10-01 21

@JsonSerializable()
class GraphDataModel extends Equatable {
  final List<BaseNode>? nodeList;
  final List<BaseRelation>? relationList;

  const GraphDataModel({this.nodeList, this.relationList});

  factory GraphDataModel.fromJson(Map<String, dynamic> json) =>
      _$GraphDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$GraphDataModelToJson(this);

  @override
  List<Object?> get props => [nodeList, relationList];
}
