import 'package:flutter/material.dart';
import 'dart:math' as math;

class CirclesProgress extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCircle = Paint()
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke
      ..color = Colors.red;

    Paint completeArc = Paint()
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = math.min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, outerCircle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
