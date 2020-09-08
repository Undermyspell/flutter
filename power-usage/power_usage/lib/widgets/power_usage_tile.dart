import 'package:flutter/material.dart';
import 'package:power_usage/widgets/circle_progress.dart';

class PowerUsageTile extends StatelessWidget {
  final Color background;
  final double amount;
  final double percentage;

  const PowerUsageTile(this.amount, this.background, this.percentage);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // color: Colors.lightGreen,
        // border: Border.all(width: 4, color: Colors.grey),
      ),
      child: CustomPaint(
        foregroundPainter: CirclesProgress(percentage),
        child: Center(
          child: Text(
            amount.toString(),
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor
            ),
          ),
        ),
      ),
    );
  }
}
