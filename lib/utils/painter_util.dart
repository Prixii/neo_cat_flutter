import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';

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
