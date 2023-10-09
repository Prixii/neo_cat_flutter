import 'package:neo_cat_flutter/types/relation.dart';
import 'package:neo_cat_flutter/types/typdef.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 09

class RelationBrowserState {
  final Map<RelationId, BaseRelation> relationMap;

  RelationBrowserState({required this.relationMap});

  RelationBrowserState.initial() : relationMap = <RelationId, BaseRelation>{};

  RelationBrowserState copyWith({Map<RelationId, BaseRelation>? relationMap}) =>
      RelationBrowserState(relationMap: relationMap ?? this.relationMap);
}
