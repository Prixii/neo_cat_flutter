import 'package:json_annotation/json_annotation.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

part 'relation.g.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 10

@JsonSerializable()
class Relation {
  String id;
  String name;
  String sourceNodeId;
  String endNodeId;

  Relation.byNodeName(
      {required this.id,
      required this.name,
      required String sourceNodeName,
      required String endNodeName})
      : sourceNodeId = getNodeIdByName(sourceNodeName),
        endNodeId = getNodeIdByName(endNodeName);

  Relation(
      {required this.id,
      required this.name,
      required this.sourceNodeId,
      required this.endNodeId});

  Relation copyWith({
    String? id,
    String? name,
    String? sourceNodeId,
    String? endNodeId,
  }) =>
      Relation(
        id: id ?? this.id,
        name: name ?? this.name,
        sourceNodeId: sourceNodeId ?? this.sourceNodeId,
        endNodeId: endNodeId ?? this.endNodeId,
      );

  factory Relation.fromJson(Map<String, dynamic> json) =>
      _$RelationFromJson(json);

  Map<String, dynamic> toJson() => _$RelationToJson(this);
}
