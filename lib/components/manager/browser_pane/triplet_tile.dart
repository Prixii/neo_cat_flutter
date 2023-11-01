import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';
import 'package:neo_cat_flutter/types/graph_edge.dart';
import 'package:neo_cat_flutter/types/graph_node.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';
import 'package:neo_cat_flutter/utils/painter_util.dart';

import '../../../bloc/relation_chart_data_bloc/bloc.dart';
import '../../../bloc/relation_chart_data_bloc/state.dart';
import '../../../bloc/triplet_editor_bloc/event.dart';
import '../../../utils/bloc_util.dart';

/// @author wang.jiaqi
/// @date 2023-10-04 09

class TripletTile extends StatefulWidget {
  const TripletTile({super.key, required this.edge});

  final GraphEdge edge;

  @override
  State<TripletTile> createState() => _TripletTileState();
}

class _TripletTileState extends State<TripletTile> {
  Color backgroundColor = opacity;
  late final GraphEdge edge;
  late final GraphNode endNode;
  late final GraphNode startNode;

  @override
  void initState() {
    super.initState();
    startNode = widget.edge.start;
    edge = widget.edge;
    endNode = widget.edge.end;
  }

  Widget _startNodeBuilder() {
    var bgColor = relationChartDataBloc(context).getColor(startNode.label);
    return Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: CirclePainter(
                color: bgColor,
              ),
            );
          },
        ),
        Center(
          child: Text(startNode.name, style: calculateTextColor(bgColor)),
        ),
      ],
    );
  }

  Widget _edgeBuilder() {
    return Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: ArrowPainter(),
            );
          },
        ),
        Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  edge.type,
                  style: defaultTextBlack,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(),
            ),
          ],
        )
      ],
    );
  }

  Widget _endNodeBuiler() {
    var bgColor = relationChartDataBloc(context).getColor(endNode.label);
    return Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return CustomPaint(
                size: Size(constraints.maxWidth, constraints.maxHeight),
                painter: CirclePainter(color: bgColor));
          },
        ),
        Center(
          child: Text(
            endNode.name,
            style: calculateTextColor(bgColor),
          ),
        ),
      ],
    );
  }

  void _onHover() {
    setState(() {
      backgroundColor = const Color.fromRGBO(0, 0, 0, 0.04);
    });
  }

  void _onExit() {
    setState(() {
      backgroundColor = opacity;
    });
  }

  void _onChooseEdge() {
    tripletEditorBloc(context).add(ChooseEdge(edge: edge));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: MouseRegion(
        onEnter: (event) => _onHover(),
        onExit: (event) => _onExit(),
        child: GestureDetector(
          onTap: _onChooseEdge,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: backgroundColor,
            ),
            child: SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
                child:
                    BlocBuilder<RelationChartDataBloc, RelationChartDataState>(
                  builder: (context, state) => Row(
                    children: [
                      Expanded(flex: 1, child: _startNodeBuilder()),
                      Expanded(flex: 2, child: _edgeBuilder()),
                      Expanded(flex: 1, child: _endNodeBuiler()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
