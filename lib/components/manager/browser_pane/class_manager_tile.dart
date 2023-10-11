import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/class_browser_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/class_browser_bloc/event.dart';
import 'package:neo_cat_flutter/types/class_data.dart';
import 'package:neo_cat_flutter/types/node.dart';

import 'node_tile.dart';

/// @author wang.jiaqi
/// @date 2023-10-04 09

class ClassManagerTile extends StatefulWidget {
  const ClassManagerTile(
      {super.key, required this.classData, required this.nodeList});

  final ClassData classData;
  final List<Node> nodeList;

  @override
  State<ClassManagerTile> createState() => _ClassManagerTileState();
}

class _ClassManagerTileState extends State<ClassManagerTile> {
  @override
  void initState() {
    super.initState();
  }

  ClassBrowserBloc _getClassBrowserBloc() => context.read<ClassBrowserBloc>();

  Widget _nodeListBuilder() {
    return ListView.builder(
      itemCount: widget.nodeList.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => NodeTile(
        node: widget.nodeList[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expander(
      header: Row(
        children: [
          Checkbox(
              checked: _getClassBrowserBloc()
                  .state
                  .classVisibilityMap[widget.classData.name],
              onChanged: (value) => _getClassBrowserBloc()
                  .add(SetIsClassVisible(className: widget.classData.name))),
          const SizedBox(
            width: 12,
          ),
          Text(widget.classData.name)
        ],
      ),
      content: _nodeListBuilder(),
    );
  }
}
