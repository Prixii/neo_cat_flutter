import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/state.dart';
import 'package:neo_cat_flutter/components/manager/browser_pane/label_manager_tile.dart';
import 'package:neo_cat_flutter/types/graph_node.dart';
import 'package:neo_cat_flutter/types/label_data.dart';
import 'package:neo_cat_flutter/utils/bloc_util.dart';

class ClassManager extends StatefulWidget {
  const ClassManager({super.key});

  @override
  State<ClassManager> createState() => _ClassManagerState();
}

class _ClassManagerState extends State<ClassManager> {
  List<LabelData> _getClassDataList() {
    return relationChartDataBloc(context).state.labelMap.values.toList();
  }

  List<GraphNode> _getNodeList({required int classIndex}) {
    var className = _getClassDataList()[classIndex].name;
    return relationChartDataBloc(context).state.nodeToLabelMap[className] ?? [];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: BlocBuilder<RelationChartDataBloc, RelationChartDataState>(
        builder: (context, state) => ListView.builder(
          itemCount: _getClassDataList().length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            child: ClassManagerTile(
              label: _getClassDataList()[index],
              nodeList: _getNodeList(classIndex: index),
            ),
          ),
        ),
      ),
    );
  }
}
