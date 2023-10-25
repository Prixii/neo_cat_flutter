import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';

import 'source_node.dart';
import 'typdef.dart';

var random = Random(1);

class GraphNode {
  Size size = const Size(0, 0); // 节点的大小
  Offset position = Offset(
      random.nextDouble() * 20 + 10, random.nextDouble() * 20 + 10); // 节点的位置

  int id;
  LabelName label;
  String name;
  Map<String, dynamic>? properties;

  GraphNode({
    required this.name,
    required this.id,
    required this.label,
    required this.properties,
  });

  factory GraphNode.fromNode(SourceNode node) {
    return GraphNode(
      name: node.name,
      id: node.id,
      label: node.label,
      properties: node.properties,
    );
  }

  double get height => size.height; // 获取节点的高度

  double get width => size.width; // 获取节点的宽度

  double get x => position.dx; // 获取节点的 x 坐标

  double get y => position.dy; // 获取节点的 y 坐标

  // 设置节点的 y 坐标
  set y(double value) {
    position = Offset(position.dx, value);
  }

  // 设置节点的 x 坐标
  set x(double value) {
    position = Offset(value, position.dy);
  }

  SourceNode toSourceNode() {
    return SourceNode(
      name: name,
      properties: properties ?? <String, dynamic>{},
      id: id,
      label: label,
    );
  }

  // 重写等于运算符
  @override
  bool operator ==(Object other) =>
      other is GraphNode && hashCode == other.hashCode;

  // 获取哈希码
  @override
  int get hashCode {
    return ("$id $name ${properties?.entries.toList() ?? name} $label")
        .hashCode;
  }

  // 转换为字符串
  @override
  String toString() {
    return 'Node{position: $position, key: $id, _size: $size, properties:${properties?.entries.toList()}}';
  }
}
