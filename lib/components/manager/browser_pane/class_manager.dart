import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/components/manager/browser_pane/class_manager_tile.dart';
import 'package:neo_cat_flutter/types/label_data.dart';
import 'package:neo_cat_flutter/types/node.dart';
import 'package:neo_cat_flutter/utils/bloc_util.dart';

class ClassManager extends StatefulWidget {
  const ClassManager({super.key});

  @override
  State<ClassManager> createState() => _ClassManagerState();
}

class _ClassManagerState extends State<ClassManager> {
  List<LabelData> _getClassDataList() {
    return relationChartDataBloc(context).state.classMap.values.toList();
  }

  List<Node> _getNodeList({required int classIndex}) {
    var className = _getClassDataList()[classIndex].name;
    return relationChartDataBloc(context).state.nodeToClassMap[className] ?? [];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: ListView.builder(
        itemCount: _getClassDataList().length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: ClassManagerTile(
            classData: _getClassDataList()[index],
            nodeList: _getNodeList(classIndex: index),
          ),
        ),
      ),
    );
  }
}
