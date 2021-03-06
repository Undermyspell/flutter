import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:power_usage/screens/monthly_usage_screen.dart';
import 'package:power_usage/screens/stats_screen.dart';
import 'package:power_usage/widgets/month_grid.dart';
import '../state/usages.dart';

class YearOverviewScreen extends StatefulWidget {
  static const String routeName = "/yearsoverview";
  @override
  _YearOverviewScreenState createState() => _YearOverviewScreenState();
}

class _YearOverviewScreenState extends State<YearOverviewScreen> {
  final usageService = GetIt.instance.get<UsageService>();
  DateTime datePicked = DateTime.now();
  List<int> months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  Future<void> fetchExistingMonthsForYear(int year) async {
    await usageService.fetchExistingMonthsForYear(year);
  }

  setDate(DateTime date) {
    fetchExistingMonthsForYear(date.year);
    setState(() {
      datePicked = date;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchExistingMonthsForYear(datePicked.year);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monatliche Übersicht"),
      ),
      body: RefreshIndicator(
        backgroundColor: Theme.of(context).accentColor,
        color: Colors.white,
        onRefresh: () => fetchExistingMonthsForYear(datePicked.year),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            StreamBuilder<bool>(
                stream: usageService.existingMonthsForYearLoading,
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        )
                      : MonthGrid(
                          usageService: usageService,
                          year: this.datePicked.year,
                          months: months);
                }),
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
                          DateFormat('yyyy').format(datePicked),
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
