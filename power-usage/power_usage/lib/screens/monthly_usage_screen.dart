import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
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
  final loadedPowerUsage = POWER_USAGES;

  DateTime datePicked = DateTime.now();

  setDate(DateTime date) {
    print(date);
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
              child: Container(
                  child: GridView.count(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                crossAxisCount: 2,
                crossAxisSpacing: 50,
                mainAxisSpacing: 30,
                childAspectRatio: 1 / 1,
                children: [
                  PowerUsageTile(
                    loadedPowerUsage[0].counterMeterConsumption,
                    Colors.grey,
                    60,
                  ),
                  PowerUsageTile(
                    loadedPowerUsage[0].counterMeterFeedIn,
                    Colors.blue,
                    50,
                  ),
                  PowerUsageTile(
                    loadedPowerUsage[0].consumptionSonnenApp,
                    Colors.blue,
                    75,
                  ),
                  PowerUsageTile(
                    loadedPowerUsage[0].consumptionGridSonnenApp,
                    Colors.blue,
                    20,
                  ),
                  PowerUsageTile(
                    loadedPowerUsage[0].consumptionHeating,
                    Colors.blue,
                    83,
                  ),
                  PowerUsageTile(
                    loadedPowerUsage[0].consumptionWarmWater,
                    Colors.blue,
                    30,
                  ),
                ],
              )),
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
