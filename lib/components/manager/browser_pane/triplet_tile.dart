import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/state.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';
import 'package:neo_cat_flutter/types/graph_edge.dart';
import 'package:neo_cat_flutter/types/graph_node.dart';
import 'package:neo_cat_flutter/utils/painter_util.dart';

/// @author wang.jiaqi
/// @date 2023-10-04 09

class TripletTile extends StatefulWidget {
  final GraphEdge relation;

  const TripletTile({super.key, required this.relation});

  @override
  State<TripletTile> createState() => _TripletTileState();
}

class _TripletTileState extends State<TripletTile> {
  late final GraphNode sourceNode;
  late final GraphNode endNode;
  late final GraphEdge relation;

  @override
  void initState() {
    super.initState();
    var triplet =
        context.read<RelationChartDataBloc>().getTriplet(widget.relation);
    if (triplet != null) {
      sourceNode = triplet.$1;
      relation = triplet.$2;
      endNode = triplet.$3;
    }
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
            sourceNode.name,
            style: defaultText,
          ),
        ),
      ],
    );
  }

  Widget _relationBuilder() {
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
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  relation.type,
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RelationChartDataBloc, RelationChartDataState>(
      builder: (context, state) => SizedBox(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          child: Row(
            children: [
              Expanded(flex: 1, child: _sourceNodeBuilder()),
              Expanded(flex: 2, child: _relationBuilder()),
              Expanded(flex: 1, child: _endNodeBuiler()),
            ],
          ),
        ),
      ),
    );
  }
}
