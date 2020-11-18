
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../widgets/power_usage_tile.dart';
import '../state/usages.dart';
import '../models/usage.dart';

class PowerUsageResultTiles extends StatelessWidget {
  final usageService = GetIt.instance.get<UsageService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<Usage>(
        stream: usageService.monthUsage,
        builder: (context, snapshot) {
          Usage usage = snapshot.data;
          if (snapshot.hasError) {
            return Center(
              child: Icon(
                Icons.error,
                size: 150,
                color: Colors.red,
              ),
            );
          }

          if (snapshot.hasData) {
            return GridView.count(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1 / 1.2,
              children: [
                PowerUsageTile(
                  usage.counterMeterConsumption,
                  Colors.grey,
                  usage.counterMeterConsumption / 10,
                  "Zähler Verbrauch"
                ),
                PowerUsageTile(
                  usage.counterMeterFeedIn,
                  Colors.blue,
                  usage.counterMeterFeedIn / 10,
                  "Zähler Einspeisung"
                ),
                PowerUsageTile(
                  usage.consumptionSonnenApp,
                  Colors.blue,
                  usage.consumptionSonnenApp /10,
                  "Sonnen Gesamt"
                ),
                PowerUsageTile(
                  usage.consumptionGridSonnenApp,
                  Colors.blue,
                  usage.consumptionGridSonnenApp / 10,
                  "Sonnen Netzbezug"
                ),
                PowerUsageTile(
                  usage.consumptionHeating,
                  Colors.blue,
                  usage.consumptionHeating / 10,
                  "Heizung"
                ),
                PowerUsageTile(
                  usage.consumptionWarmWater,
                  Colors.blue,
                  usage.consumptionWarmWater / 10,
                  "Warmwasser"
                ),
              ],
            );
          }

          return Center(
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