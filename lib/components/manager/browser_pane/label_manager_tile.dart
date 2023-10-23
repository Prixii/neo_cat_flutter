import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/bloc/label/event.dart';
import 'package:neo_cat_flutter/components/common/popup_menu/menu_options.dart';
import 'package:neo_cat_flutter/types/graph_node.dart';
import 'package:neo_cat_flutter/types/label_data.dart';
import 'package:neo_cat_flutter/utils/bloc_util.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

import '../../../theme/common_theme.dart';
import '../../../types/typdef.dart';
import '../../common/popup_menu/popup_menu.dart';
import 'node_tile.dart';

/// @author wang.jiaqi
/// @date 2023-10-04 09

class ClassManagerTile extends StatefulWidget {
  const ClassManagerTile(
      {super.key, required this.classData, required this.nodeList});

  final LabelData classData;
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
            FluentIcons.accept,
            color: Colors.blue,
          ),
          label: 'Accept',
          onTap: () {
            logger.d(node?.name);
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

  @override
  void dispose() {
    try {
      overlayEntry.remove();
      // ignore: empty_catches
    } catch (e) {}
    super.dispose();
  }

  Widget _nodeListBuilder() {
    return ListView.builder(
      itemCount: widget.nodeList.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        child: NodeTile(
          node: widget.nodeList[index],
        ),
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
          .labelVisibilityMap[widget.classData.name] ??
      false;

  @override
  Widget build(BuildContext context) {
    return Expander(
      contentPadding: const EdgeInsets.all(8.0),
      header: Row(
        children: [
          Checkbox(
            checked: isClassVisible(),
            onChanged: (value) => relationChartDataBloc(context).add(
              SetClassVisibility(className: widget.classData.name),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            widget.classData.name,
            style: defaultTextBlack,
          )
        ],
      ),
      content: _nodeListBuilder(),
    );
  }
}
