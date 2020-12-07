import 'package:flutter/material.dart';
import 'package:power_usage/screens/monthly_usage_screen.dart';
import 'package:power_usage/screens/stats_screen.dart';

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
                Container(
                  child: Center(
                    child: Text(
                      months[i - 1].toString(),
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor,// Colors.white.withOpacity(.5),
                      ),
                    ),
                  ),
                  decoration: new BoxDecoration(
                    border: Border.all(
                      width: 3,
                      color: Colors.white.withOpacity(.5),
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(10, 10), // changes position of shadow
                      ),
                    ],
                  ),
                ),
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
