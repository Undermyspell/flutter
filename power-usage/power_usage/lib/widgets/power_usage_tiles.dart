
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