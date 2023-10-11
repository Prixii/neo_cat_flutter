// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassDataImpl _$$ClassDataImplFromJson(Map<String, dynamic> json) =>
    _$ClassDataImpl(
      name: json['name'] as String,
      properties: (json['properties'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$ClassDataImplToJson(_$ClassDataImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'properties': instance.properties,
    };
