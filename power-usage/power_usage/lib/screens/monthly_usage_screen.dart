import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:power_usage/screens/edit_monthly_usage_screen.dart';
import 'package:power_usage/screens/stats_screen.dart';
import 'package:power_usage/screens/year_overview_screen.dart';
import '../widgets/power_usage_tiles.dart';
import '../state/usages.dart';

class MonthlyUsageScreen extends StatefulWidget {
  static const String routeName = "/monthlyusages";

  @override
  _MonthlyUsageScreenState createState() => _MonthlyUsageScreenState();
}

class _MonthlyUsageScreenState extends State<MonthlyUsageScreen> {
  final usageService = GetIt.instance.get<UsageService>();
  DateTime datePicked = DateTime.now();

  Future<void> fetchUsageForMonth(int year, int month) async {
    await usageService.fetchUsageForMonth(year, month);
  }

  setDate(DateTime date) {
    fetchUsageForMonth(date.year, date.month);
    setState(() {
      datePicked = date;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUsageForMonth(datePicked.month, datePicked.year);
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
        onRefresh: () => fetchUsageForMonth(datePicked.year, datePicked.month),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.white,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: StreamBuilder<bool>(
                    stream: usageService.monthUsageIsLoading,
                    builder: (context, snapshot) {
                      return !snapshot.hasData || snapshot.data
                          ? Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            )
                          : PowerUsageResultTiles();
                    }),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(EditMonthlyUsageScreen.routeName);
        },
        backgroundColor: Theme.of(context).accentColor,
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: Container(
          color: Theme.of(context).primaryColor,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      YearOverviewScreen.routeName, (r) => false);
                },
              ),
              IconButton(
                icon: Icon(Icons.calendar_today),
                color: Colors.white,
                onPressed: () async {
                  final picked = await showMonthPicker(
                      context: context, initialDate: datePicked);
                  setDate(picked != null ? picked : datePicked);
                },
              ),
              IconButton(
                icon: Icon(Icons.show_chart),
                color: Colors.white,
                onPressed: () =>
                    Navigator.of(context).pushNamed(StatsScreen.routeName),
              ),
              SizedBox(
                width: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
