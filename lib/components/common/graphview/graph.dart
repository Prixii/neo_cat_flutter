import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:collection/collection.dart' show IterableExtension;

class Graph {
  final List<Node> _nodes = [];
  final List<Edge> _edges = [];
  List<GraphObserver> graphObserver = [];

  List<Node> get nodes => _nodes; //  List<Node> nodes = _nodes;
  List<Edge> get edges => _edges;

  var isTree = false;

  int nodeCount() => _nodes.length;

  void addNode(Node node) {
    if (!_nodes.contains(node)) {
      _nodes.add(node);
      notifyGraphObserver();
    }
  }

  void addNodes(List<Node> nodes) {
    for (var node in nodes) {
      addNode(node);
    }
  }

  void removeNode(Node? node) {
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

  void removeNodes(List<Node> nodes) {
    for (var node in nodes) {
      removeNode(node);
    }
  }

  Edge addEdge(Node source, Node destination, String type, {Paint? paint}) {
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

  void addEdges(List<Edge> edges) {
    for (var edge in edges) {
      addEdgeS(edge);
    }
  }

  void removeEdge(Edge edge) => _edges.remove(edge);

  void removeEdges(List<Edge> edges) {
    for (var edge in edges) {
      removeEdge(edge);
    }
  }

  void removeEdgeFromPredecessor(Node? predecessor, Node? current) {
    _edges.removeWhere(
        (edge) => edge.source == predecessor && edge.destination == current);
  }

  bool hasNodes() => _nodes.isNotEmpty;

  Edge? getEdgeBetween(Node source, Node? destination) =>
      _edges.firstWhereOrNull((element) =>
          element.source == source && element.destination == destination);

  bool hasSuccessor(Node? node) =>
      _edges.any((element) => element.source == node);

  List<Node> successorsOf(Node? node) =>
      getOutEdges(node!).map((e) => e.destination).toList();

  bool hasPredecessor(Node node) =>
      _edges.any((element) => element.destination == node);

  List<Node> predecessorsOf(Node? node) =>
      getInEdges(node!).map((edge) => edge.source).toList();

  bool contains({Node? node, Edge? edge}) =>
      node != null && _nodes.contains(node) ||
      edge != null && _edges.contains(edge);

//  bool contains(Edge edge) => _edges.contains(edge);
  Node getNodeAtPosition(int position) {
    if (position < 0) {
//            throw IllegalArgumentException("position can't be negative")
    }

    final size = _nodes.length;
    if (position >= size) {
//            throw IndexOutOfBoundsException("Position: $position, Size: $size")
    }

    return _nodes[position];
  }

  Node getNodeUsingKey(ValueKey key) =>
      _nodes.firstWhere((element) => element.key == key);

  Node getNodeUsingId(dynamic id) =>
      _nodes.firstWhere((element) => element.key == ValueKey(id));

  List<Edge> getOutEdges(Node node) =>
      _edges.where((element) => element.source == node).toList();

  List<Edge> getInEdges(Node node) =>
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
class Node {
  ValueKey? key; // 用于表示节点的键

  String? name; // 结点的名字

  // 节点的构造函数
  Node(this.name, id, {Key? key}) {
    this.key = ValueKey(key?.hashCode); // 初始化节点的键
  }

  // 使用 ID 初始化节点
  Node.id(dynamic id) {
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
      identical(this, other) || other is Node && hashCode == other.hashCode;

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
  Node source;
  Node destination;
  String type;

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
