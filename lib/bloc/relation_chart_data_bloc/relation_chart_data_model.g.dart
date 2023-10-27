// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation_chart_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RelationChartDataModelImpl _$$RelationChartDataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RelationChartDataModelImpl(
      nodeList: (json['nodeList'] as List<dynamic>)
          .map((e) => SourceNode.fromJson(e as Map<String, dynamic>))
          .toList(),
      edgeList: (json['edgeList'] as List<dynamic>)
          .map((e) => SourceEdge.fromJson(e as Map<String, dynamic>))
          .toList(),
      labelDataList: (json['labelDataList'] as List<dynamic>)
          .map((e) => LabelData.fromJson(e as Map<String, dynamic>))
          .toList(),
      edgeTypeList: (json['edgeTypeList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$RelationChartDataModelImplToJson(
        _$RelationChartDataModelImpl instance) =>
    <String, dynamic>{
      'nodeList': instance.nodeList,
      'edgeList': instance.edgeList,
      'labelDataList': instance.labelDataList,
      'edgeTypeList': instance.edgeTypeList,
    };
