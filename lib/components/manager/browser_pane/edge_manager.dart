import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/components/manager/browser_pane/edge_manager_tile.dart';
import 'package:neo_cat_flutter/types/graph_edge.dart';
import 'package:neo_cat_flutter/types/typdef.dart';

import '../../../bloc/relation_chart_data_bloc/bloc.dart';
import '../../../bloc/relation_chart_data_bloc/state.dart';
import '../../../utils/bloc_util.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 22

class RelationManager extends StatefulWidget {
  const RelationManager({super.key});
  @override
  State<RelationManager> createState() => _RelationManagerState();
}

class _RelationManagerState extends State<RelationManager> {
  @override
  void initState() {
    super.initState();
  }

  List<GraphEdge> _getEdgeList(int index) {
    var type = _edgeTypeList()[index];
    return relationChartDataBloc(context).state.edgeToTypeMap[type] ?? [];
  }

  List<EdgeType> _edgeTypeList() =>
      relationChartDataBloc(context).state.edgeTypes.toList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: BlocBuilder<RelationChartDataBloc, RelationChartDataState>(
        builder: (context, state) => ListView.builder(
          itemCount: _edgeTypeList().length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            child: EdgeManagerTile(
              type: _edgeTypeList()[index],
              edges: _getEdgeList(index),
            ),
          ),
        ),
      ),
    );
  }
}
