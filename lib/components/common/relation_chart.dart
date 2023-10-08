import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/types/node.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';
import 'package:neo_cat_flutter/utils/painter_util.dart';

/// @author wang.jiaqi
/// @date 2023-10-08 19
var positionList = <(double, double)>[];

class RelationChart extends StatefulWidget {
  const RelationChart({super.key, required this.width, required this.height});

  final double height;
  final double width;

  @override
  State<RelationChart> createState() => _RelationChartState();
}

class _RelationChartState extends State<RelationChart> {
  var offsetList = <Offset>[];
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: GestureDetector(
        onTapUp: (TapUpDetails details) => isTapInNode(
            xCooridnate: details.localPosition.dx,
            yCoordinate: details.localPosition.dy,
            positionList: positionList),
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: CustomPaint(painter: MyCustomPainterTest()),
          // child: MyCustomPaint(),
        ),
      ),
    );
  }
}

class MyCustomPainterTest extends CustomPainter {
  var nodeList = <BaseNode>[];
  var list = <Offset>[];

  Future<List<Offset>> getNodiPosition(double x, double y) async {
    await for ((double, double) value in calcPointCoordinates(
      nodeCount: 9,
      xCoordinate: x,
      yCoordinate: y,
    )) {
      positionList.add(value);
      list.add(Offset(value.$1, value.$2));
    }

    return list;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < 10; i++) {
      nodeList.add(BaseNode(name: 'Node$i', id: '$i', className: 'node'));
    }
    final paint = Paint()..color = Colors.blue;
    var center = Offset(size.width / 2, size.height / 2);

    getNodiPosition(size.width / 2, size.height / 2);

    canvas.drawCircle(center, 30, paint);

    for (int index = 0; index < list.length; index++) {
      canvas.drawCircle(list[index], 30, paint);
    }
  }

  @override
  bool shouldRepaint(covariant MyCustomPainterTest oldDelegate) {
    return oldDelegate.list != list;
  }
}
