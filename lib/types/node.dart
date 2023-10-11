import 'package:json_annotation/json_annotation.dart';
part 'node.g.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 10

@JsonSerializable()
class Node {
  String name;
  String id;
  String className;
  int symbolSize;

  Node(
      {required this.name,
      required this.id,
      required this.className,
      int? symbolSize})
      : symbolSize = symbolSize ?? 30;

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);

  Map<String, dynamic> toJson() => _$NodeToJson(this);
}
