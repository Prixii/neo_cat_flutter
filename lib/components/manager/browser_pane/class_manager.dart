import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/class_browser_bloc/bloc.dart';
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

  List<ClassData> _getClassDataList() => _classBrowserBloc.state.classList;

  List<Node> _getNodeList({required int classIndex}) {
    var className = _getClassDataList()[classIndex];
    return _classBrowserBloc.state.nodeToClassMap[className] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: ListView.builder(
        itemCount: _getClassDataList().length,
        // itemCount: classDataList.length,
        itemBuilder: (BuildContext context, int index) => ClassManagerTile(
          classData: _getClassDataList()[index],
          nodeList: _getNodeList(classIndex: index),
        ),
      ),
    );
  }
}
