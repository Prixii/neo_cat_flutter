import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/relation_chart_data_model.dart';
import 'package:neo_cat_flutter/types/relation.dart';
import 'package:neo_cat_flutter/types/typdef.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 09

class RelationBrowserState {
  final Map<RelationId, BaseRelation> relationMap;

  RelationBrowserState({required this.relationMap});

  RelationBrowserState.initial() : relationMap = <RelationId, BaseRelation>{};

  factory RelationBrowserState.fromModel(RelationChartDataModel model) {
    var relationList = model.relationList;
    var relationMap = <RelationId, BaseRelation>{};
    for (var relation in relationList) {
      relationMap[relation.id] = relation;
    }
    return RelationBrowserState(relationMap: relationMap);
  }

  RelationBrowserState copyWith({Map<RelationId, BaseRelation>? relationMap}) =>
      RelationBrowserState(relationMap: relationMap ?? this.relationMap);
}
