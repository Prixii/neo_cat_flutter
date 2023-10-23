import 'dart:convert';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:neo_cat_flutter/types/source_node.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

import '../../../types/graph_edge.dart';
import '../../../types/graph_node.dart';

class Graph {
  final List<GraphNode> nodes;
  final List<GraphEdge> edges;
  List<GraphObserver> graphObserver = [];

  var isTree = false;

  Graph({required this.nodes, required this.edges});

  Graph.init()
      : nodes = [],
        edges = [];

  int nodeCount() => nodes.length;

  void addNode(GraphNode node) {
    if (!nodes.contains(node)) {
      nodes.add(node);
      notifyGraphObserver();
    }
  }

  void addNodes(List<SourceNode> nodeList) {
    for (var node in nodeList) {
      logger.d('[addNode]${node.toString()}');
      addNode(GraphNode.fromNode(node));
      logger.d('[nodes]${nodes.toList()}');
    }
  }

  void removeNode(GraphNode? node) {
    if (!nodes.contains(node)) {
//            throw IllegalArgumentException("Unable to find node in graph.")
    }

    if (isTree) {
      successorsOf(node).forEach((element) => removeNode(element));
    }

    nodes.remove(node);

    edges.removeWhere((edge) => edge.start == node || edge.end == node);

    notifyGraphObserver();
  }

  void removeNodes(List<GraphNode> nodeList) {
    for (var node in nodeList) {
      removeNode(node);
    }
  }

  void addEdgeS(GraphEdge edge) {
    var sourceSet = false;
    var destinationSet = false;
    for (var node in nodes) {
      if (!sourceSet && node == edge.start) {
        edge.start = node;
        sourceSet = true;
      } else if (!destinationSet && node == edge.end) {
        edge.end = node;
        destinationSet = true;
      }
    }
    if (!sourceSet) {
      nodes.add(edge.start);
    }
    if (!destinationSet) {
      nodes.add(edge.end);
    }

    if (!edges.contains(edge)) {
      edges.add(edge);
      notifyGraphObserver();
    }
  }

  void removeEdge(GraphEdge edge) => edges.remove(edge);

  void removeEdges(List<GraphEdge> edgeList) {
    for (var edge in edgeList) {
      removeEdge(edge);
    }
  }

  void removeEdgeFromPredecessor(GraphNode? predecessor, GraphNode? current) {
    edges.removeWhere(
        (edge) => edge.start == predecessor && edge.end == current);
  }

  bool hasNodes() => nodes.isNotEmpty;

  GraphEdge? getEdgeBetween(GraphNode source, GraphNode? destination) =>
      edges.firstWhereOrNull(
          (element) => element.start == source && element.end == destination);

  bool hasSuccessor(GraphNode? node) =>
      edges.any((element) => element.start == node);

  List<GraphNode> successorsOf(GraphNode? node) =>
      getOutEdges(node!).map((e) => e.end).toList();

  bool hasPredecessor(GraphNode node) =>
      edges.any((element) => element.end == node);

  List<GraphNode> predecessorsOf(GraphNode? node) =>
      getInEdges(node!).map((edge) => edge.start).toList();

  bool contains({GraphNode? node, GraphEdge? edge}) =>
      node != null && nodes.contains(node) ||
      edge != null && edges.contains(edge);

//  bool contains(Edge edge) => _edges.contains(edge);
  GraphNode getNodeAtPosition(int position) {
    if (position < 0) {
//            throw IllegalArgumentException("position can't be negative")
    }

    final size = nodes.length;
    if (position >= size) {
//            throw IndexOutOfBoundsException("Position: $position, Size: $size")
    }

    return nodes[position];
  }

  GraphNode getNodeUsingId(int id) =>
      nodes.firstWhere((element) => element.id == id);

  List<GraphEdge> getOutEdges(GraphNode node) =>
      edges.where((element) => element.start == node).toList();

  List<GraphEdge> getInEdges(GraphNode node) =>
      edges.where((element) => element.end == node).toList();

  void notifyGraphObserver() {
    for (var element in graphObserver) {
      element.notifyGraphInvalidated();
    }
  }

  String toJson() {
    var jsonString = {
      'nodes': [...nodes.map((e) => e.hashCode.toString())],
      'edges': [
        ...edges.map((e) => {
              'from': e.start.hashCode.toString(),
              'to': e.end.hashCode.toString()
            })
      ]
    };

    return jsonEncode(jsonString);
  }
}
