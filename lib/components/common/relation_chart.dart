import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/bloc.dart';
import 'package:neo_cat_flutter/types/typdef.dart';
import 'package:neo_cat_flutter/utils/painter_util.dart';

/// @author wang.jiaqi
/// @date 2023-10-08 19
class RelationChart extends StatefulWidget {
  const RelationChart({super.key, required this.width, required this.height});

  final double height;
  final double width;

  @override
  State<RelationChart> createState() => _RelationChartState();
}

class _RelationChartState extends State<RelationChart> {
  RelationChartDataBloc _getChartDataBloc() =>
      context.read<RelationChartDataBloc>();

  Map<NodeId, Position> _getPositionMap() =>
      _getChartDataBloc().state.positionMap;
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: GestureDetector(
        onTapUp: (TapUpDetails details) => findNodeIdTapped(
            xCooridnate: details.localPosition.dx,
            yCoordinate: details.localPosition.dy,
            positionMap: _getPositionMap()),
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: CustomPaint(painter: MyCustomPainterTest(context: context)),
          // child: MyCustomPaint(),
        ),
      ),
    );
  }
}

class MyCustomPainterTest extends CustomPainter {
  final BuildContext context;

  MyCustomPainterTest({required this.context});

  RelationChartDataBloc _getChartDataBloc() =>
      context.read<RelationChartDataBloc>();

  Future<void> drawNodes({
    required Position center,
    required Canvas canvas,
  }) async {
    Map<NodeId, Position> positionMap =
        await _getChartDataBloc().state.getAbsolutePositionMap(center: center);
    final paint = Paint()..color = Colors.blue;
    for (var nodeId in positionMap.keys) {
      var position = positionMap[nodeId];
      if (position != null) {
        canvas.drawCircle(Offset(position.$1, position.$2), 30, paint);
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawNodes(center: (size.width / 2, size.height / 2), canvas: canvas);
  }

  @override
  bool shouldRepaint(covariant MyCustomPainterTest oldDelegate) {
    return true;
  }
}
