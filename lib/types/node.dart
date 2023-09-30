import 'package:json_annotation/json_annotation.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 10

@JsonSerializable()
class BaseNode {
  BaseNode(
      {required this.name,
      required this.id,
      required this.className,
      int? symbolSize})
      : symbolSize = symbolSize ?? 30;

  String name;
  String id;
  String className;
  int symbolSize;
}
