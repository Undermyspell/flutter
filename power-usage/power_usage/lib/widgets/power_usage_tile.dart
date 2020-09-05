import 'package:flutter/material.dart';

class PowerUsageTile extends StatelessWidget {
  final Color background;
  final double amount;

  const PowerUsageTile(this.amount, this.background);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: background,
      ),
      child: Center(
        child: Text(
          amount.toString(),
        ),
      ),
    );
  }
}
