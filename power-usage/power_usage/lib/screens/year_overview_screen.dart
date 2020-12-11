import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:power_usage/screens/monthly_usage_screen.dart';
import 'package:power_usage/screens/stats_screen.dart';
import 'package:power_usage/widgets/month_tile.dart';

class YearOverviewScreen extends StatefulWidget {
  static const String routeName = "/yearsoverview";
  @override
  _YearOverviewScreenState createState() => _YearOverviewScreenState();
}

class _YearOverviewScreenState extends State<YearOverviewScreen> {
  DateTime datePicked = DateTime.now();
  List<int> months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  setDate(DateTime date) {
    setState(() {
      datePicked = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monatliche Übersicht"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  for (var i in months) MonthTile(months: months, i: i),
                ],
              ),
            ),
          ],
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
                icon: Icon(Icons.dashboard),
                color: Colors.white,
                onPressed: () => Navigator.of(context)
                    .pushNamed(MonthlyUsageScreen.routeName),
              ),
              InkWell(
                onTap: () async {
                  final picked = await showMonthPicker(
                      context: context, initialDate: datePicked);
                  setDate(picked != null ? picked : datePicked);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          DateFormat('MMMM yyyy').format(datePicked),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
