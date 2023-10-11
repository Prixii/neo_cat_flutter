// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Relation _$RelationFromJson(Map<String, dynamic> json) => Relation(
      id: json['id'] as String,
      name: json['name'] as String,
      sourceNodeId: json['sourceNodeId'] as String,
      endNodeId: json['endNodeId'] as String,
    );

Map<String, dynamic> _$RelationToJson(Relation instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sourceNodeId': instance.sourceNodeId,
      'endNodeId': instance.endNodeId,
    };
