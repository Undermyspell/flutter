import 'package:flutter/material.dart';
import 'dart:math' as math;

class CirclesProgress extends CustomPainter {

  final double percentage;

  CirclesProgress(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCircle = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..color = Colors.purple[200];

    Paint completeArc = Paint()
      ..strokeWidth = 8
      ..color = Colors.purple[400] //Color.fromARGB(255, 63 , 131, 192)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = math.min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, outerCircle);

    double angle = 2 * math.pi * (percentage / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2, angle, false, completeArc);
  }

  @override
  bool shouldRepaint(CirclesProgress oldDelegate) {
    return oldDelegate.percentage != percentage;
  }
}
