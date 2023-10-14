import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/types/node.dart';
import 'package:neo_cat_flutter/utils/painter_util.dart';

import '../../../theme/common_theme.dart';

/// @author wang.jiaqi
/// @date 2023-10-07 21

class NodeTile extends StatefulWidget {
  const NodeTile({super.key, required this.node});
  final Node node;

  @override
  State<NodeTile> createState() => _NodeTileState();
}

class _NodeTileState extends State<NodeTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return CustomPaint(
                        size: Size(constraints.maxWidth, constraints.maxHeight),
                        painter: CirclePainter(),
                      );
                    },
                  ),
                  Center(
                    child: Text(widget.node.name),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Text(
                  widget.node.name,
                  style: defaultTextBlack,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
