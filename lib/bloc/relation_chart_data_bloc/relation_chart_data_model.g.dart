// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation_chart_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationChartDataModel _$RelationChartDataModelFromJson(
        Map<String, dynamic> json) =>
    RelationChartDataModel(
      nodeList: (json['nodeList'] as List<dynamic>)
          .map((e) => Node.fromJson(e as Map<String, dynamic>))
          .toList(),
      relationList: (json['relationList'] as List<dynamic>)
          .map((e) => Relation.fromJson(e as Map<String, dynamic>))
          .toList(),
      classDataList: (json['classDataList'] as List<dynamic>)
          .map((e) => ClassData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RelationChartDataModelToJson(
        RelationChartDataModel instance) =>
    <String, dynamic>{
      'nodeList': instance.nodeList,
      'relationList': instance.relationList,
      'classDataList': instance.classDataList,
    };
