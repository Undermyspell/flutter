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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.purple[200].withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(10, 10), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              "hallo",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
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
            ),
          ],
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
