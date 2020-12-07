import 'package:flutter/material.dart';
import 'package:power_usage/screens/monthly_usage_screen.dart';
import 'package:power_usage/screens/stats_screen.dart';
import 'package:power_usage/widgets/month_tile.dart';

class YearOverviewScreen extends StatefulWidget {
  @override
  _YearOverviewScreenState createState() => _YearOverviewScreenState();
}

class _YearOverviewScreenState extends State<YearOverviewScreen> {
  List<int> months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monatliche Übersicht"),
      ),
      body: Container(
        child: Center(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              for (var i in months)
                MonthTile(months: months, i: i),
            ],
          ),
        ),
      ),
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

