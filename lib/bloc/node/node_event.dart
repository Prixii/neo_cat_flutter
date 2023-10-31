import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/event.dart';
import 'package:neo_cat_flutter/types/label_data.dart';

import '../../types/graph_node.dart';

abstract class NodeEvent extends RelationChartDataEvent {}

class AddNode extends NodeEvent {
  final GraphNode node;

  AddNode(this.node);
}

class UpdateNode extends NodeEvent {
  final GraphNode node;

  UpdateNode(this.node);
}

class DeleteNode extends NodeEvent {
  final GraphNode node;

  DeleteNode(this.node);
}

class CreateLabelAndSetNode extends NodeEvent {
  final LabelData labelData;
  final GraphNode node;

  CreateLabelAndSetNode(this.labelData, this.node);
}
