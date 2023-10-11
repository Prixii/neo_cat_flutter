// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RelationImpl _$$RelationImplFromJson(Map<String, dynamic> json) =>
    _$RelationImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      sourceNodeId: json['sourceNodeId'] as String,
      endNodeId: json['endNodeId'] as String,
    );

Map<String, dynamic> _$$RelationImplToJson(_$RelationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sourceNodeId': instance.sourceNodeId,
      'endNodeId': instance.endNodeId,
    };
