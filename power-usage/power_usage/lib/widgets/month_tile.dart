import 'package:flutter/material.dart';
import 'package:power_usage/routearguments/monthargument.dart';
import 'package:power_usage/screens/edit_monthly_usage_screen.dart';

class MonthTile extends StatelessWidget {
  const MonthTile({
    Key key,
    @required this.year,
    @required this.months,
    @required this.i,
    @required this.color,
  }) : super(key: key);

  final int year;
  final List<int> months;
  final int i;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Center(
          child: Text(
            months[i - 1].toString(),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Colors.white.withOpacity(.5),
            ),
          ),
        ),
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 3,
            color: Colors.white.withOpacity(.5),
          ),
          // borderRadius: BorderRadius.circular(50),
          color:
              color, // i % 2 == 0 ? Color(0xFF5aa469) : Color(0xFFd35d6e),//Theme.of(context).primaryColor,
          // boxShadow: [
          //   BoxShadow(
          //     color: Theme.of(context).primaryColor.withOpacity(.5),
          //     spreadRadius: 1,
          //     blurRadius: 5,
          //     offset: Offset(10, 10), // changes position of shadow
          //   ),
          // ],
        ),
      ),
      onTap: () => Navigator.of(context).pushNamed(
        EditMonthlyUsageScreen.routeName,
        arguments: MonthArgument(year, i),
      ),
    );
  }
}
