import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/class_browser_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/class_browser_bloc/event.dart';
import 'package:neo_cat_flutter/bloc/class_browser_bloc/state.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/bloc.dart';
import 'package:neo_cat_flutter/components/manager/browser_pane/class_manager_tile.dart';
import 'package:neo_cat_flutter/types/class_data.dart';
import 'package:neo_cat_flutter/types/node.dart';

class ClassManager extends StatefulWidget {
  const ClassManager({super.key});

  @override
  State<ClassManager> createState() => _ClassManagerState();
}

class _ClassManagerState extends State<ClassManager> {
  final _classBrowserBloc = ClassBrowserBloc();
  List<ClassData> _getClassDataList() {
    return _classBrowserBloc.state.classList;
  }

  List<Node> _getNodeList({required int classIndex}) {
    var className = _getClassDataList()[classIndex].name;
    return _classBrowserBloc.state.nodeToClassMap[className] ?? [];
  }

  @override
  void initState() {
    super.initState();
    _classBrowserBloc.add(
      InitClassBrowserState(
          model: context.read<RelationChartDataBloc>().state.relationChartData),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClassBrowserBloc>(
      create: (context) => _classBrowserBloc,
      child: BlocBuilder<ClassBrowserBloc, ClassBrowserState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(6),
          child: BlocBuilder<ClassBrowserBloc, ClassBrowserState>(
            builder: (context, state) => ListView.builder(
              itemCount: _getClassDataList().length,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                child: ClassManagerTile(
                  classData: _getClassDataList()[index],
                  nodeList: _getNodeList(classIndex: index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
