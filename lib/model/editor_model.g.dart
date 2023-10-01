// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditorModel _$EditorModelFromJson(Map<String, dynamic> json) => EditorModel(
      startNode: json['startNode'] == null
          ? null
          : BaseNode.fromJson(json['startNode'] as Map<String, dynamic>),
      endNode: json['endNode'] == null
          ? null
          : BaseNode.fromJson(json['endNode'] as Map<String, dynamic>),
      relation: json['relation'] == null
          ? null
          : BaseRelation.fromJson(json['relation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EditorModelToJson(EditorModel instance) =>
    <String, dynamic>{
      'startNode': instance.startNode,
      'endNode': instance.endNode,
      'relation': instance.relation,
    };
