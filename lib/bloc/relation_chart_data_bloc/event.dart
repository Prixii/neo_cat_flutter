import 'package:neo_cat_flutter/types/typdef.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 14

abstract class RelationChartDataEvent {
  RelationChartDataEvent();
}

/// 使用从json文件中读取的数据 [rawData] 初始化State
class InitRelationChartData extends RelationChartDataEvent {
  final String rawData;

  InitRelationChartData({required this.rawData});
}

class ReplacePositionMap extends RelationChartDataEvent {
  final Map<NodeId, Position> positionMap;

  ReplacePositionMap({required this.positionMap});
}
