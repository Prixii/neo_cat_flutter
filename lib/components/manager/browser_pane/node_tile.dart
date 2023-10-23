import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/types/graph_node.dart';
import 'package:neo_cat_flutter/utils/painter_util.dart';

import '../../../theme/common_theme.dart';

/// @author wang.jiaqi
/// @date 2023-10-07 21

class NodeTile extends StatefulWidget {
  const NodeTile({super.key, required this.node});
  final GraphNode node;

  @override
  State<NodeTile> createState() => _NodeTileState();
}

class _NodeTileState extends State<NodeTile> {
  Color backgroundColor = opacity;

  void _handleHover() {
    setState(() {
      backgroundColor = const Color.fromRGBO(0, 0, 0, 0.04);
    });
  }

  void _handleExit() {
    setState(() {
      backgroundColor = opacity;
    });
  }

  Widget _nodeBuilder() {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: CirclePainter(),
            ),
            Center(
              child: SizedBox(
                width: (constraints.maxWidth > 40) ? 40 : constraints.maxWidth,
                child: Text(
                  widget.node.name,
                  overflow: TextOverflow.ellipsis,
                  style: defaultText.copyWith(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nodeNameBuilder() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: Text(
        widget.node.name,
        style: defaultTextBlack,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _handleHover(),
      onExit: (event) => _handleExit(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: backgroundColor,
        ),
        child: SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
            child: Row(
              children: [
                Expanded(flex: 1, child: _nodeBuilder()),
                Expanded(flex: 3, child: _nodeNameBuilder()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
