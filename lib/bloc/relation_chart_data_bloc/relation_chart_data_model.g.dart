// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation_chart_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RelationChartDataModelImpl _$$RelationChartDataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RelationChartDataModelImpl(
      nodeList: (json['nodeList'] as List<dynamic>)
          .map((e) => Node.fromJson(e as Map<String, dynamic>))
          .toList(),
      relationList: (json['relationList'] as List<dynamic>)
          .map((e) => Relation.fromJson(e as Map<String, dynamic>))
          .toList(),
      labelDataList: (json['labelDataList'] as List<dynamic>)
          .map((e) => LabelData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RelationChartDataModelImplToJson(
        _$RelationChartDataModelImpl instance) =>
    <String, dynamic>{
      'nodeList': instance.nodeList,
      'relationList': instance.relationList,
      'labelDataList': instance.labelDataList,
    };
