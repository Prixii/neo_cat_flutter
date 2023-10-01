// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseNode _$BaseNodeFromJson(Map<String, dynamic> json) => BaseNode(
      name: json['name'] as String,
      id: json['id'] as String,
      className: json['className'] as String,
      symbolSize: json['symbolSize'] as int?,
    );

Map<String, dynamic> _$BaseNodeToJson(BaseNode instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'className': instance.className,
      'symbolSize': instance.symbolSize,
    };
