import 'package:fluent_ui/fluent_ui.dart';

import 'graph_node.dart';
import 'source_edge.dart';
import 'typdef.dart';

class GraphEdge {
  GraphNode start;
  GraphNode end;
  String type;
  EdgeId id;
  Paint? paint;

  static GraphEdge? fromSourceEdge(
      SourceEdge sourceEdge, Map<NodeId, GraphNode> nodeMap) {
    var source = nodeMap[sourceEdge.start];
    var end = nodeMap[sourceEdge.end];
    if (source != null && end != null) {
      return GraphEdge(source, end, sourceEdge.type, sourceEdge.id);
    }
    return null;
  }

  GraphEdge(this.start, this.end, this.type, this.id, {this.paint});

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      other is GraphEdge && hashCode == other.hashCode;

  @override
  int get hashCode => id;
}

abstract class GraphObserver {
  void notifyGraphInvalidated();
}
