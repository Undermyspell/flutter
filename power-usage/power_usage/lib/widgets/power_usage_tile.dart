import 'package:flutter/material.dart';

class PowerUsageTile extends StatelessWidget {
  final Color background;
  final double amount;

  const PowerUsageTile(this.amount, this.background);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.lightGreen,
          border: Border.all(
            width: 4,
            color: Colors.grey
          )),
      child: Center(
        child: Text(
          amount.toString(),
        ),
      ),
    );
  }
}
