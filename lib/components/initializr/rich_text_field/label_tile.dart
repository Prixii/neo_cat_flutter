import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/node/node_event.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/state.dart';
import 'package:neo_cat_flutter/components/initializr/rich_text_field/rich_text_editing_controller.dart';
import 'package:neo_cat_flutter/types/graph_node.dart';
import 'package:neo_cat_flutter/types/typdef.dart';
import 'package:neo_cat_flutter/utils/bloc_util.dart';

import '../../../theme/common_theme.dart';

class LabelTile extends StatefulWidget {
  const LabelTile(
      {super.key,
      required this.color,
      required this.labelName,
      required this.getController});

  final Color color;
  final RichTextEditingController Function() getController;
  final LabelName labelName;

  @override
  State<LabelTile> createState() => _LabelTileState();
}

class _LabelTileState extends State<LabelTile> {
  Color backgroundColor = Colors.transparent;

  void _createLabel(String name) {
    relationChartDataBloc(context).add(
      AddNode(
        GraphNode(
            label: widget.labelName,
            name: name,
            id: "${widget.labelName},$name".hashCode,
            properties: {}),
      ),
    );
  }

  void _setClass(RichTextEditingController controller) {
    var start = controller.selection.start;
    var end = controller.selection.end;
    var newText = controller.text;
    var head = newText.substring(0, start);
    var center = newText.substring(start, end);
    var tail = newText.substring(end);
    newText = "$head€${widget.labelName}£$center $tail";
    controller.text = newText;
    _createLabel(center);
  }

  Widget _classNameBuilder() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
      child: Text(
        widget.labelName,
        textAlign: TextAlign.left,
        style: defaultTextBlack,
      ),
    );
  }

  Widget _colorBoxBuilder() {
    return SizedBox(
      width: 30,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Container(color: widget.color),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RelationChartDataBloc, RelationChartDataState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(4),
        child: GestureDetector(
          child: MouseRegion(
            child: SizedBox(
              height: 30,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: backgroundColor,
                ),
                child: Row(
                  children: [
                    Expanded(flex: 1, child: _classNameBuilder()),
                    _colorBoxBuilder(),
                  ],
                ),
              ),
            ),
            onEnter: (event) => setState(() {
              backgroundColor = Colors.black.withOpacity(0.05);
            }),
            onExit: (event) => setState(() {
              backgroundColor = Colors.transparent;
            }),
          ),
          onTap: () {
            ContextMenuController.removeAny();
            _setClass(widget.getController());
          },
        ),
      ),
    );
  }
}
