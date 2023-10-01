import 'package:json_annotation/json_annotation.dart';
part 'node.g.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 10

@JsonSerializable()
class BaseNode {
  String name;
  String id;
  String className;
  int symbolSize;

  BaseNode(
      {required this.name,
      required this.id,
      required this.className,
      int? symbolSize})
      : symbolSize = symbolSize ?? 30;

  factory BaseNode.fromJson(Map<String, dynamic> json) =>
      _$BaseNodeFromJson(json);

  Map<String, dynamic> toJson() => _$BaseNodeToJson(this);
}
