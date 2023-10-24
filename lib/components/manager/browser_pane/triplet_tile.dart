import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/state.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/event.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';
import 'package:neo_cat_flutter/types/graph_edge.dart';
import 'package:neo_cat_flutter/types/graph_node.dart';
import 'package:neo_cat_flutter/utils/painter_util.dart';

import '../../../utils/bloc_util.dart';

/// @author wang.jiaqi
/// @date 2023-10-04 09

class TripletTile extends StatefulWidget {
  final GraphEdge edge;

  const TripletTile({super.key, required this.edge});

  @override
  State<TripletTile> createState() => _TripletTileState();
}

class _TripletTileState extends State<TripletTile> {
  Color backgroundColor = opacity;
  late final GraphNode startNode;
  late final GraphNode endNode;
  late final GraphEdge edge;

  @override
  void initState() {
    super.initState();
    startNode = widget.edge.start;
    edge = widget.edge;
    endNode = widget.edge.end;
  }

  Widget _sourceNodeBuilder() {
    return Stack(
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
          child: Text(
            startNode.name,
            style: defaultText,
          ),
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
    return Stack(
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
          child: Text(
            endNode.name,
            style: defaultText,
          ),
        ),
      ],
    );
  }

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

  void _handleChooseEdge() {
    tripletEditorBloc(context).add(ChooseEdge(edge: widget.edge));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RelationChartDataBloc, RelationChartDataState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(6),
        child: MouseRegion(
          onEnter: (event) => _handleHover(),
          onExit: (event) => _handleExit(),
          child: GestureDetector(
            onTap: _handleChooseEdge,
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
                      Expanded(flex: 1, child: _sourceNodeBuilder()),
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
