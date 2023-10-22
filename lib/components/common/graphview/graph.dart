import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:neo_cat_flutter/types/node.dart';
import 'package:neo_cat_flutter/types/relation.dart';
import 'package:neo_cat_flutter/utils/bloc_util.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

class Graph {
  final List<GraphNode> _nodes = [];
  final List<Edge> _edges = [];
  List<GraphObserver> graphObserver = [];

  List<GraphNode> get nodes => _nodes; //  List<Node> nodes = _nodes;
  List<Edge> get edges => _edges;

  var isTree = false;

  int nodeCount() => _nodes.length;

  void addNode(GraphNode node) {
    if (!_nodes.contains(node)) {
      _nodes.add(node);
      notifyGraphObserver();
    }
  }

  void addNodes(List<Node> nodes) {
    for (var node in nodes) {
      logger.d('[addNode]${node.toString()}');
      addNode(GraphNode.fromNode(node));
      logger.d('[nodes]${_nodes.toList()}');
    }
  }

  void removeNode(GraphNode? node) {
    if (!_nodes.contains(node)) {
//            throw IllegalArgumentException("Unable to find node in graph.")
    }

    if (isTree) {
      successorsOf(node).forEach((element) => removeNode(element));
    }

    _nodes.remove(node);

    _edges
        .removeWhere((edge) => edge.source == node || edge.destination == node);

    notifyGraphObserver();
  }

  void removeNodes(List<GraphNode> nodes) {
    for (var node in nodes) {
      removeNode(node);
    }
  }

  Edge addEdge(GraphNode source, GraphNode destination, String type,
      {Paint? paint}) {
    final edge = Edge(source, destination, type, paint: paint);
    addEdgeS(edge);

    return edge;
  }

  void addEdgeS(Edge edge) {
    var sourceSet = false;
    var destinationSet = false;
    for (var node in _nodes) {
      if (!sourceSet && node == edge.source) {
        edge.source = node;
        sourceSet = true;
      } else if (!destinationSet && node == edge.destination) {
        edge.destination = node;
        destinationSet = true;
      }
    }
    if (!sourceSet) {
      _nodes.add(edge.source);
    }
    if (!destinationSet) {
      _nodes.add(edge.destination);
    }

    if (!_edges.contains(edge)) {
      _edges.add(edge);
      notifyGraphObserver();
    }
  }

  void addEdges(List<Relation> relations, BuildContext context) {
    for (var relation in relations) {
      addEdgeS(Edge.fromRelation(relation, context));
    }
  }

  void removeEdge(Edge edge) => _edges.remove(edge);

  void removeEdges(List<Edge> edges) {
    for (var edge in edges) {
      removeEdge(edge);
    }
  }

  void removeEdgeFromPredecessor(GraphNode? predecessor, GraphNode? current) {
    _edges.removeWhere(
        (edge) => edge.source == predecessor && edge.destination == current);
  }

  bool hasNodes() => _nodes.isNotEmpty;

  Edge? getEdgeBetween(GraphNode source, GraphNode? destination) =>
      _edges.firstWhereOrNull((element) =>
          element.source == source && element.destination == destination);

  bool hasSuccessor(GraphNode? node) =>
      _edges.any((element) => element.source == node);

  List<GraphNode> successorsOf(GraphNode? node) =>
      getOutEdges(node!).map((e) => e.destination).toList();

  bool hasPredecessor(GraphNode node) =>
      _edges.any((element) => element.destination == node);

  List<GraphNode> predecessorsOf(GraphNode? node) =>
      getInEdges(node!).map((edge) => edge.source).toList();

  bool contains({GraphNode? node, Edge? edge}) =>
      node != null && _nodes.contains(node) ||
      edge != null && _edges.contains(edge);

//  bool contains(Edge edge) => _edges.contains(edge);
  GraphNode getNodeAtPosition(int position) {
    if (position < 0) {
//            throw IllegalArgumentException("position can't be negative")
    }

    final size = _nodes.length;
    if (position >= size) {
//            throw IndexOutOfBoundsException("Position: $position, Size: $size")
    }

    return _nodes[position];
  }

  GraphNode getNodeUsingKey(ValueKey key) =>
      _nodes.firstWhere((element) => element.key == key);

  GraphNode getNodeUsingId(dynamic id) =>
      _nodes.firstWhere((element) => element.key == ValueKey(id));

  List<Edge> getOutEdges(GraphNode node) =>
      _edges.where((element) => element.source == node).toList();

  List<Edge> getInEdges(GraphNode node) =>
      _edges.where((element) => element.destination == node).toList();

  void notifyGraphObserver() {
    for (var element in graphObserver) {
      element.notifyGraphInvalidated();
    }
  }

  String toJson() {
    var jsonString = {
      'nodes': [..._nodes.map((e) => e.hashCode.toString())],
      'edges': [
        ..._edges.map((e) => {
              'from': e.source.hashCode.toString(),
              'to': e.destination.hashCode.toString()
            })
      ]
    };

    return jsonEncode(jsonString);
  }
}

// 表示节点的类
class GraphNode {
  GraphNode.fromNode(Node node) {
    name = node.name;
    key = ValueKey(node.id);
  }

  ValueKey? key; // 用于表示节点的键

  String? name; // 结点的名字

  // 节点的构造函数
  GraphNode(this.name, id, {Key? key}) {
    this.key = ValueKey(key?.hashCode); // 初始化节点的键
  }

  // 使用 ID 初始化节点
  GraphNode.id(dynamic id) {
    key = ValueKey(id);
  }

  Size size = const Size(0, 0); // 节点的大小

  Offset position = const Offset(0, 0); // 节点的位置

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

  // 重写等于运算符
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GraphNode && hashCode == other.hashCode;

  // 获取哈希码
  @override
  int get hashCode {
    return key?.value.hashCode ?? key.hashCode;
  }

  // 转换为字符串
  @override
  String toString() {
    return 'Node{position: $position, key: $key, _size: $size}';
  }
}

class Edge {
  GraphNode source;
  GraphNode destination;
  String type;

  factory Edge.fromRelation(Relation relaion, BuildContext context) {
    return Edge(relationChartDataBloc(context).getGraphNode(relaion.start),
        relationChartDataBloc(context).getGraphNode(relaion.end), relaion.type);
  }

  Key? key;
  Paint? paint;

  Edge(this.source, this.destination, this.type, {this.key, this.paint});

  @override
  bool operator ==(Object? other) =>
      identical(this, other) || other is Edge && hashCode == other.hashCode;

  @override
  int get hashCode => key?.hashCode ?? Object.hash(source, destination);
}

abstract class GraphObserver {
  void notifyGraphInvalidated();
}
