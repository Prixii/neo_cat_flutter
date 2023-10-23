// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SourceNodeImpl _$$SourceNodeImplFromJson(Map<String, dynamic> json) =>
    _$SourceNodeImpl(
      name: json['name'] as String,
      properties: json['properties'] as Map<String, dynamic>?,
      id: json['id'] as int,
      label: json['label'] as String,
    );

Map<String, dynamic> _$$SourceNodeImplToJson(_$SourceNodeImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'properties': instance.properties,
      'id': instance.id,
      'label': instance.label,
    };
