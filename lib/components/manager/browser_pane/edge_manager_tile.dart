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
              //  TODO 删除EdgeType
            },
          ),
        ],
      ),
      content: _edgeListBuilder(),
    );
  }
}
