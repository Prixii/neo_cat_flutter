import 'package:neo_cat_flutter/utils/common_util.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 10

class BaseRelation {
  BaseRelation.byNodeName(
      {required this.id,
      required this.name,
      required startNodeName,
      required endNodeName})
      : startNodeId = getNodeIdByName(startNodeName),
        endNodeId = getNodeIdByName(endNodeName);

  BaseRelation.byNodeId(
      {required this.id,
      required this.name,
      required this.startNodeId,
      required this.endNodeId});

  String id;
  String name;
  String startNodeId;
  String endNodeId;
}
