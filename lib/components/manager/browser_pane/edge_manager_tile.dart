import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/types/graph_edge.dart';
import 'package:neo_cat_flutter/types/typdef.dart';

import '../../../bloc/edge/edge_event.dart';
import '../../../theme/common_theme.dart';
import '../../../utils/bloc_util.dart';
import '../../common/popup_menu/menu_options.dart';
import '../../common/popup_menu/popup_menu.dart';
import 'triplet_tile.dart';

class EdgeManagerTile extends StatefulWidget {
  const EdgeManagerTile({super.key, required this.type, required this.edges});

  final EdgeType type;
  final List<GraphEdge> edges;

  @override
  State<EdgeManagerTile> createState() => _EdgeManagerTileState();
}

class _EdgeManagerTileState extends State<EdgeManagerTile> {
  late OverlayEntry overlayEntry;
  Position position = (0, 0);
  GraphEdge? edge;
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
            relationChartDataBloc(context).add(DeleteEdge(edge: edge!));
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

  void _alertConflict() {
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
                relationChartDataBloc(context).add(DeleteEdgeType(widget.type));
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  Widget _edgeListBuilder() {
    return ListView.builder(
      itemCount: widget.edges.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => GestureDetector(
        child: TripletTile(edge: widget.edges[index]),
        onSecondaryTapDown: (details) {
          setState(
            () {
              edge = widget.edges[index];
              position = (details.globalPosition.dx, details.globalPosition.dy);
            },
          );
          Overlay.of(context).insert(overlayEntry);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expander(
      contentPadding: const EdgeInsets.all(8.0),
      header: Row(
        children: [
          // TODO 设置可见性
          Checkbox(checked: true, onChanged: (value) {}),
          const SizedBox(
            width: 12,
          ),
          Text(
            widget.type,
            style: defaultTextBlack,
          ),
          Expanded(child: Container()),
          IconButton(
            icon: const Icon(
              FluentIcons.delete,
              color: Colors.errorPrimaryColor,
            ),
            onPressed: () {
              var edgeCount = relationChartDataBloc(context)
                      .state
                      .edgeToTypeMap[widget.type]
                      ?.length ??
                  0;
              if (edgeCount != 0) {
                _alertConflict();
                return;
              }
              relationChartDataBloc(context).add(DeleteEdgeType(widget.type));
            },
          ),
        ],
      ),
      content: _edgeListBuilder(),
    );
  }
}
