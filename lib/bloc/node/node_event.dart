import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/event.dart';

import '../../types/graph_node.dart';

abstract class NodeEvent extends RelationChartDataEvent {}

class AddNode extends NodeEvent {
  final GraphNode node;

  AddNode(this.node);
}
