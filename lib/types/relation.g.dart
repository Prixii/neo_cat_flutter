// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRelation _$BaseRelationFromJson(Map<String, dynamic> json) => BaseRelation(
      id: json['id'] as String,
      name: json['name'] as String,
      startNodeId: json['startNodeId'] as String,
      endNodeId: json['endNodeId'] as String,
    );

Map<String, dynamic> _$BaseRelationToJson(BaseRelation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startNodeId': instance.startNodeId,
      'endNodeId': instance.endNodeId,
    };
