import 'package:flutter/material.dart';
import 'package:power_usage/screens/monthly_usage_screen.dart';
import 'package:power_usage/screens/stats_screen.dart';

class YearOverviewScreen extends StatefulWidget {
  @override
  _YearOverviewScreenState createState() => _YearOverviewScreenState();
}

class _YearOverviewScreenState extends State<YearOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monatliche Übersicht"),
      ),
      body: Container(),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.calendar_today),
                color: Colors.white,
                onPressed: () => Navigator.of(context)
                    .pushNamed(MonthlyUsageScreen.routeName),
              ),
              IconButton(
                icon: Icon(Icons.show_chart),
                color: Colors.white,
                onPressed: () =>
                    Navigator.of(context).pushNamed(StatsScreen.routeName),
              )
            ],
          ),
        ),
      ),
    );
  }
}
