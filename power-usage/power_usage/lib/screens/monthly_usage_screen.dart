import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../models/usage.dart';
import 'package:power_usage/widgets/power_usage_month_picker.dart';
import '../widgets/power_usage_tile.dart';
import '../state/usages.dart';
import '../widgets/power_usage_month_picker.dart';

class MonthlyUsageScreen extends StatefulWidget {
  static const String routeName = "/monthlyusages";

  @override
  _MonthlyUsageScreenState createState() => _MonthlyUsageScreenState();
}

class _MonthlyUsageScreenState extends State<MonthlyUsageScreen> {
  final usageService = GetIt.instance.get<UsageService>();
  DateTime datePicked = DateTime.now();

  setDate(DateTime date) {
    usageService.fetchUsageForMonth(date.year, date.month);
    setState(() {
      datePicked = date;
    });
  }

  @override
  void initState() {
    super.initState();
    usageService.fetchUsageForMonth(datePicked.month, datePicked.year);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monatliche Übersicht"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.grey[300],
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 70,
                    alignment: Alignment.center,
                    child: Container(
                      height: 50,
                      width: 200,
                      child: PowerUsageMonthPicker(
                        datePicked,
                        setDate,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<bool>(
                  stream: usageService.monthUsageIsLoading,
                  builder: (context, snapshot) {
                    return snapshot.data
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                color: Colors.white,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.cloud),
                color: Colors.white,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PowerUsageResultTiles extends StatelessWidget {
  final usageService = GetIt.instance.get<UsageService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<Usage>(
        stream: usageService.monthUsage,
        builder: (context, snapshot) {
          Usage usage = snapshot.data;
          return snapshot.hasData
              ? GridView.count(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  crossAxisCount: 2,
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 30,
                  childAspectRatio: 1 / 1,
                  children: [
                    PowerUsageTile(
                      usage.counterMeterConsumption,
                      Colors.grey,
                      60,
                    ),
                    PowerUsageTile(
                      usage.counterMeterFeedIn,
                      Colors.blue,
                      50,
                    ),
                    PowerUsageTile(
                      usage.consumptionSonnenApp,
                      Colors.blue,
                      75,
                    ),
                    PowerUsageTile(
                      usage.consumptionGridSonnenApp,
                      Colors.blue,
                      20,
                    ),
                    PowerUsageTile(
                      usage.consumptionHeating,
                      Colors.blue,
                      83,
                    ),
                    PowerUsageTile(
                      usage.consumptionWarmWater,
                      Colors.blue,
                      30,
                    ),
                  ],
                )
              : Center(
                  child: Icon(
                    Icons.do_not_disturb_alt,
                    size: 150,
                    color: Theme.of(context).primaryColor,
                  ),
                );
        },
      ),
    );
  }
}
