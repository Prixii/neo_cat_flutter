import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:neo_cat_flutter/types/source_node.dart';
import 'package:neo_cat_flutter/types/source_edge.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

import '../../../types/graph_edge.dart';
import '../../../types/graph_node.dart';

class Graph {
  final List<GraphNode> _nodes = [];
  final List<GraphEdge> _edges = [];
  List<GraphObserver> graphObserver = [];

  List<GraphNode> get nodes => _nodes; //  List<Node> nodes = _nodes;
  List<GraphEdge> get edges => _edges;

  var isTree = false;

  int nodeCount() => _nodes.length;

  void addNode(GraphNode node) {
    if (!_nodes.contains(node)) {
      _nodes.add(node);
      notifyGraphObserver();
    }
  }

  void addNodes(List<SourceNode> nodes) {
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

  void addEdgeS(GraphEdge edge) {
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

  void removeEdge(GraphEdge edge) => _edges.remove(edge);

  void removeEdges(List<GraphEdge> edges) {
    for (var edge in edges) {
      removeEdge(edge);
    }
  }

  void removeEdgeFromPredecessor(GraphNode? predecessor, GraphNode? current) {
    _edges.removeWhere(
        (edge) => edge.source == predecessor && edge.destination == current);
  }

  bool hasNodes() => _nodes.isNotEmpty;

  GraphEdge? getEdgeBetween(GraphNode source, GraphNode? destination) =>
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

  bool contains({GraphNode? node, GraphEdge? edge}) =>
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
      _nodes.firstWhere((element) => element.id == key);

  GraphNode getNodeUsingId(dynamic id) =>
      _nodes.firstWhere((element) => element.id == ValueKey(id));

  List<GraphEdge> getOutEdges(GraphNode node) =>
      _edges.where((element) => element.source == node).toList();

  List<GraphEdge> getInEdges(GraphNode node) =>
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
