import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/bloc/node/node_event.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

import '../../../bloc/label/label_event.dart';
import '../../../theme/common_theme.dart';
import '../../../types/graph_node.dart';
import '../../../types/label_data.dart';
import '../../../types/typdef.dart';
import '../../../utils/bloc_util.dart';
import '../../common/popup_menu/menu_options.dart';
import '../../common/popup_menu/popup_menu.dart';
import 'node_tile.dart';

/// @author wang.jiaqi
/// @date 2023-10-04 09

class ClassManagerTile extends StatefulWidget {
  const ClassManagerTile(
      {super.key, required this.label, required this.nodeList});

  final LabelData label;
  final List<GraphNode> nodeList;

  @override
  State<ClassManagerTile> createState() => _ClassManagerTileState();
}

class _ClassManagerTileState extends State<ClassManagerTile> {
  late OverlayEntry overlayEntry;

  Position position = (0, 0);

  GraphNode? node;
  @override
  void initState() {
    super.initState();
    overlayEntry = popupMenuBuilder(
      getPosition: () => position,
      options: [
        SingleMenuOption(
          icon: Icon(
            FluentIcons.delete,
            color: Colors.blue,
          ),
          label: 'Delete',
          onTap: () {
            relationChartDataBloc(context).add(DeleteNode(node!));
            overlayEntry.remove();
          },
        ),
        SingleMenuOption(
          icon: Icon(
            FluentIcons.accounts,
            color: Colors.blue,
          ),
          label: "Accounts",
        ),
      ],
    );
  }

  void _checkConflict() {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: Text(
          '警告',
          style: defaultTextBlack,
        ),
        content:
            const Text('此Label仍有子节点, 如果执行删除操作, 所有子节点(包括其相关的边)都会被删除，确认要删除吗'),
        actions: [
          Button(
              child: const Text('算了'),
              onPressed: () {
                Navigator.pop(context);
              }),
          Button(
              child: Text(
                '删除',
                style: defaultText.copyWith(color: Colors.errorPrimaryColor),
              ),
              onPressed: () {
                relationChartDataBloc(context)
                    .add(DeleteLabel(labelName: widget.label.name));
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    try {
      overlayEntry.remove();
    } catch (e) {
      logger.d('dispose overLay');
    }
    super.dispose();
  }

  Widget _nodeListBuilder() {
    return ListView.builder(
      itemCount: widget.nodeList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => GestureDetector(
        child: NodeTile(node: widget.nodeList[index]),
        onSecondaryTapDown: (details) {
          setState(
            () {
              node = widget.nodeList[index];
              position = (details.globalPosition.dx, details.globalPosition.dy);
            },
          );
          Overlay.of(context).insert(overlayEntry);
        },
      ),
    );
  }

  bool isClassVisible() =>
      relationChartDataBloc(context)
          .state
          .labelVisibilityMap[widget.label.name] ??
      false;

  @override
  Widget build(BuildContext context) {
    return Expander(
      contentPadding: const EdgeInsets.all(8.0),
      header: Row(
        children: [
          // _visibilityBox(),
          const SizedBox(
            width: 12,
          ),
          Text(
            widget.label.name,
            style: defaultTextBlack,
          ),
          Expanded(child: Container()),
          IconButton(
            icon: const Icon(
              FluentIcons.delete,
              color: Colors.errorPrimaryColor,
            ),
            onPressed: () {
              var nodeCount = relationChartDataBloc(context)
                      .state
                      .nodeToLabelMap[widget.label.name]
                      ?.length ??
                  0;
              if (nodeCount != 0) {
                _checkConflict();
                return;
              }
              relationChartDataBloc(context)
                  .add(DeleteLabel(labelName: widget.label.name));
            },
          ),
        ],
      ),
      content: _nodeListBuilder(),
    );
  }
}
