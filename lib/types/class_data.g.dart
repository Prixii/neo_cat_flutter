// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassData _$ClassDataFromJson(Map<String, dynamic> json) => ClassData(
      name: json['name'] as String?,
      properties: (json['properties'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ClassDataToJson(ClassData instance) => <String, dynamic>{
      'name': instance.name,
      'properties': instance.properties,
    };
