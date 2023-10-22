// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NodeImpl _$$NodeImplFromJson(Map<String, dynamic> json) => _$NodeImpl(
      name: json['name'] as String,
      properties: json['properties'] as Map<String, dynamic>?,
      id: json['id'] as int,
      label: json['label'] as String,
    );

Map<String, dynamic> _$$NodeImplToJson(_$NodeImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'properties': instance.properties,
      'id': instance.id,
      'label': instance.label,
    };
