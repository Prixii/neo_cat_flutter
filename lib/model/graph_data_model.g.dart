// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graph_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GraphDataModel _$GraphDataModelFromJson(Map<String, dynamic> json) =>
    GraphDataModel(
      nodeList: (json['nodeList'] as List<dynamic>?)
          ?.map((e) => BaseNode.fromJson(e as Map<String, dynamic>))
          .toList(),
      relationList: (json['relationList'] as List<dynamic>?)
          ?.map((e) => BaseRelation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GraphDataModelToJson(GraphDataModel instance) =>
    <String, dynamic>{
      'nodeList': instance.nodeList,
      'relationList': instance.relationList,
    };
