import 'package:json_annotation/json_annotation.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

part 'relation.g.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 10

@JsonSerializable()
class BaseRelation {
  String id;
  String name;
  String startNodeId;
  String endNodeId;

  BaseRelation.byNodeName(
      {required this.id,
      required this.name,
      required startNodeName,
      required endNodeName})
      : startNodeId = getNodeIdByName(startNodeName),
        endNodeId = getNodeIdByName(endNodeName);

  BaseRelation(
      {required this.id,
      required this.name,
      required this.startNodeId,
      required this.endNodeId});

  BaseRelation copyWith({
    String? id,
    String? name,
    String? startNodeId,
    String? endNodeId,
  }) =>
      BaseRelation(
        id: id ?? this.id,
        name: name ?? this.name,
        startNodeId: startNodeId ?? this.startNodeId,
        endNodeId: endNodeId ?? this.endNodeId,
      );

  factory BaseRelation.fromJson(Map<String, dynamic> json) =>
      _$BaseRelationFromJson(json);

  Map<String, dynamic> toJson() => _$BaseRelationToJson(this);
}
