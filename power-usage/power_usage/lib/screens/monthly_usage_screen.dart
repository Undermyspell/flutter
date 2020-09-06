import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import '../widgets/circle_progress.dart';
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
                  height: 100,
                  child: CustomPaint(
                    foregroundPainter: CirclesProgress(),
                    child: Container(
                      height: 50,
                      width: 50,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
                child: GridView.count(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              crossAxisCount: 2,
              crossAxisSpacing: 50,
              mainAxisSpacing: 20,
              childAspectRatio: 1 / 1,
              children: [
                PowerUsageTile(
                  loadedPowerUsage[0].counterMeterConsumption,
                  Colors.grey,
                ),
                PowerUsageTile(
                  loadedPowerUsage[0].counterMeterFeedIn,
                  Colors.blue,
                ),
                PowerUsageTile(
                  loadedPowerUsage[0].consumptionSonnenApp,
                  Colors.blue,
                ),
                PowerUsageTile(
                  loadedPowerUsage[0].consumptionGridSonnenApp,
                  Colors.blue,
                ),
                PowerUsageTile(
                    loadedPowerUsage[0].consumptionHeating, Colors.blue),
                PowerUsageTile(
                  loadedPowerUsage[0].consumptionWarmWater,
                  Colors.blue,
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
