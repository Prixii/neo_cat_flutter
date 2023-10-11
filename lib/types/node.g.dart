// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NodeImpl _$$NodeImplFromJson(Map<String, dynamic> json) => _$NodeImpl(
      name: json['name'] as String,
      id: json['id'] as String,
      className: json['className'] as String,
      symbolSize: json['symbolSize'] as int? ?? 30,
    );

Map<String, dynamic> _$$NodeImplToJson(_$NodeImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'className': instance.className,
      'symbolSize': instance.symbolSize,
    };
