// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RelationImpl _$$RelationImplFromJson(Map<String, dynamic> json) =>
    _$RelationImpl(
      id: json['id'] as int,
      type: json['type'] as String,
      start: json['start'] as int,
      end: json['end'] as int,
    );

Map<String, dynamic> _$$RelationImplToJson(_$RelationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'start': instance.start,
      'end': instance.end,
    };
