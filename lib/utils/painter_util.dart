import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/types/typdef.dart';

/// @author wang.jiaqi
/// @date 2023-10-02 12

class CirclePainter extends CustomPainter {
  Color? color;
  Offset? offset;
  double? radius;

  CirclePainter({this.color, this.offset, this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    double calcRadius() {
      return min(
          min(size.width / 2, size.height / 2), min(30.0, radius ?? 30.0));
    }

    final firstNodeCenter = offset ?? Offset(size.width / 2, size.height / 2);
    var firstNodeRadius = calcRadius();
    final firstNodePaint = Paint()..color = color ?? Colors.blue;
    canvas.drawCircle(firstNodeCenter, firstNodeRadius, firstNodePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    Offset startPoint = Offset(size.width * 0.1, size.height * 0.5);
    Offset endPoint = Offset(size.width * 0.9, size.height * 0.5);

    Offset arrowPoint2 = endPoint + const Offset(-5, 5);
    Offset arrowPoint3 = endPoint + const Offset(-5, -5);
    Path path = Path()
      ..moveTo(endPoint.dx, endPoint.dy)
      ..lineTo(arrowPoint2.dx, arrowPoint2.dy)
      ..lineTo(arrowPoint3.dx, arrowPoint3.dy)
      ..close();
    canvas.drawLine(startPoint, endPoint, paint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// 判定 [firstCircle] 和 [secondCircle] 两个节点是否碰撞
bool isCircleCollision(CirclePainter firstCircle, CirclePainter secondCircle) {
  if (firstCircle.offset != null && secondCircle.offset != null) {
    var xDelta = firstCircle.offset!.dx - secondCircle.offset!.dx;
    var yDelta = firstCircle.offset!.dy - secondCircle.offset!.dy;
    return (sqrt(xDelta * xDelta + yDelta * yDelta) <
        ((firstCircle.radius ?? 30) + (secondCircle.radius ?? 30)));
  }
  return false;
}

/// 计算位于 ([xCoordinate], [yCoordinate]) 的节点的周边节点的位置
/// 其中, 该节点周围共有 [nodeCount] 个节点
///
/// 如果不提供源节点，则默认以组件中心为轴
Stream<(double x, double y)> calcPointCoordinates({
  required int nodeCount,
  double? xCoordinate,
  double? yCoordinate,
}) async* {
  var angle = 360 / nodeCount;
  for (var index = 0; index < nodeCount; index++) {
    var xCoordinateTarget =
        (xCoordinate ?? 0) + cos((pi * 2) / 360 * angle * index) * 120;
    var yCoordinateTarget =
        (yCoordinate ?? 0) + sin((pi * 2) / 360 * angle * index) * 120;
    yield (xCoordinateTarget, yCoordinateTarget);
  }
}

/// 发生在 [xCooridnate], [yCoordinate] 上的点击事件, 是否点击到了节点上
Future<NodeId?> findNodeIdTapped({
  required double xCooridnate,
  required double yCoordinate,
  required Map<NodeId, Position> positionMap,
}) async {
  for (var nodeId in positionMap.keys) {
    var position = positionMap[nodeId];
    var xDelta = xCooridnate - position!.$1;
    var yDelta = yCoordinate - position.$2;
    if (sqrt(xDelta * xDelta + yDelta * yDelta) < 30) {
      return nodeId;
    }
  }
}
