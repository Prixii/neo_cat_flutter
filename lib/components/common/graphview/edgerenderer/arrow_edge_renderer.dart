import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';

import '../../../../types/graph_node.dart';
import '../graph.dart';
import 'edge_renderer.dart';

const double arrowDegrees = 0.5;
const double arrowLength = 10;

class ArrowEdgeRenderer extends EdgeRenderer {
  var trianglePath = Path();

  @override
  void render(Canvas canvas, Graph graph, Paint paint) {
    var trianglePaint = Paint()
      ..color = paint.color
      ..style = PaintingStyle.fill;

    for (var edge in graph.edges) {
      // 获取起始节点和目标节点
      var source = edge.start;
      var destination = edge.end;

      // 获取起始节点和目标节点在画布上的偏移量
      var sourceOffset = source.position;
      var destinationOffset = destination.position;

      // 计算起始点的位置
      var startX = sourceOffset.dx;
      var startY = sourceOffset.dy;

      // 计算终点的位置
      var stopX = destinationOffset.dx;
      var stopY = destinationOffset.dy;

      // 调整起始点和终点，以适应目标节点的边界
      var clippedLine = clipLine(startX, startY, stopX, stopY, destination);

      // 声明一个可空的边界三角形画笔
      Paint? edgeTrianglePaint;

      // 如果边的画笔不为空，则用边的画笔，否则用传入的画笔
      if (edge.paint != null) {
        edgeTrianglePaint = Paint()
          ..color = edge.paint?.color ?? paint.color
          ..style = PaintingStyle.fill;
      }

      // 绘制箭头的三角形部分，并获取三角形的中心点
      var triangleCentroid = drawTriangle(
          canvas,
          edgeTrianglePaint ?? trianglePaint,
          clippedLine[0],
          clippedLine[1],
          clippedLine[2],
          clippedLine[3]);

      // 绘制连接起始点和三角形中心的线条，使用了边的画笔或传入的画笔
      canvas.drawLine(
          Offset(clippedLine[0], clippedLine[1]),
          Offset(triangleCentroid[0], triangleCentroid[1]),
          edge.paint ?? paint);

      // 计算文字的位置
      var textX = (clippedLine[0] + clippedLine[2]) / 2;
      var textY = (clippedLine[1] + clippedLine[3]) / 2 - 10; // 调整垂直位置

      // 绘制文字
      var span = TextSpan(
        style: defaultTextBlack,
        text: edge.type, // 节点之间的关系
      );
      var tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      )..layout();

      tp.paint(canvas,
          Offset(textX - tp.width / 2, textY - tp.height)); // 以文字中心为基准绘制
    }
  }

  List<double> drawTriangle(
      Canvas canvas, Paint paint, double x1, double y1, double x2, double y2) {
    var angle = (atan2(y2 - y1, x2 - x1) + pi);
    var x3 = (x2 + arrowLength * cos((angle - arrowDegrees)));
    var y3 = (y2 + arrowLength * sin((angle - arrowDegrees)));
    var x4 = (x2 + arrowLength * cos((angle + arrowDegrees)));
    var y4 = (y2 + arrowLength * sin((angle + arrowDegrees)));
    trianglePath.moveTo(x2, y2); // Top;
    trianglePath.lineTo(x3, y3); // Bottom left
    trianglePath.lineTo(x4, y4); // Bottom right
    trianglePath.close();
    canvas.drawPath(trianglePath, paint);

    // calculate centroid of the triangle
    var x = (x2 + x3 + x4) / 3;
    var y = (y2 + y3 + y4) / 3;
    var triangleCentroid = [x, y];
    trianglePath.reset();
    return triangleCentroid;
  }

  List<double> clipLine(double startX, double startY, double stopX,
      double stopY, GraphNode destination) {
    // 创建一个包含4个元素的列表，填充为0.0
    var resultLine = List.filled(4, 0.0);

    resultLine[1] = startY;

    // 计算角度
    var angle = atan2(stopY - startY, stopX - startX);

    // 计算目标节点尺寸的一半
    var halfHeight = destination.height / 2;
    var halfWidth = destination.width / 2;

    // 计算斜率乘以宽度的一半和高度的一半
    var halfSlopeWidth = cos(angle) * halfWidth;
    var halfSlopeHeight = sin(angle) * halfHeight;

    resultLine[0] = startX + halfSlopeWidth;
    resultLine[1] = startY + halfSlopeHeight;
    resultLine[2] = stopX - halfSlopeWidth;
    resultLine[3] = stopY - halfSlopeHeight;

    return resultLine;
  }
}
