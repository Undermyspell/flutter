import 'package:flutter/material.dart';
import 'package:power_usage/widgets/circle_progress.dart';

class PowerUsageTile extends StatefulWidget {
  final Color background;
  final double amount;
  final double percentage;

  const PowerUsageTile(this.amount, this.background, this.percentage);

  @override
  _PowerUsageTileState createState() => _PowerUsageTileState();
}

class _PowerUsageTileState extends State<PowerUsageTile>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  double currentPercent;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    animation =
        Tween<double>(begin: 0, end: widget.percentage).animate(controller)
          ..addListener(() {
            setState(() {
              currentPercent = animation.value;
            });
          });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: CustomPaint(
          foregroundPainter: CirclesProgress(animation.value),
          child: Center(
            child: Text(
              widget.amount.toString(),
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        animation.status == AnimationStatus.completed
            ? controller.reverse()
            : controller.forward();
      },
    );
  }
}
