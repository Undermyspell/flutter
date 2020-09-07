import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import '../widgets/power_usage_tile.dart';
import '../state/usages.dart';

class MonthlyUsageScreen extends StatelessWidget {
  static const String routeName = "/monthlyusages";
  final loadedPowerUsage = POWER_USAGES;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monatliche Übersicht"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.lightBlue,
                  height: 150,
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
                child: GridView.count(
              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
              crossAxisCount: 2,
              crossAxisSpacing: 50,
              mainAxisSpacing: 20,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {},
        backgroundColor: Colors.blue[300],
      ),
    );
  }
}
