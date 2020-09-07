import 'package:flutter/material.dart';
import 'dart:math' as math;

class CirclesProgress extends CustomPainter {

  final double percentage;

  CirclesProgress(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCircle = Paint()
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..color = Colors.black;

    Paint completeArc = Paint()
      ..strokeWidth = 8
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = math.min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, outerCircle);

    double angle = 2 * math.pi * (percentage / 100);
    print(angle);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2, angle, false, completeArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
