// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation_chart_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationChartDataModel _$RelationChatDataModelFromJson(
        Map<String, dynamic> json) =>
    RelationChartDataModel(
      nodeList: (json['nodeList'] as List<dynamic>)
          .map((e) => BaseNode.fromJson(e as Map<String, dynamic>))
          .toList(),
      relationList: (json['relationList'] as List<dynamic>)
          .map((e) => BaseRelation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RelationChatDataModelToJson(
        RelationChartDataModel instance) =>
    <String, dynamic>{
      'nodeList': instance.nodeList,
      'relationList': instance.relationList,
    };
