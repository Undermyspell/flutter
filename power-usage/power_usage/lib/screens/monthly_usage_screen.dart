import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import '../widgets/power_usage_tile.dart';
import '../state/usages.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MonthlyUsageScreen extends StatelessWidget {
  static const String routeName = "/monthlyusages";
  final loadedPowerUsage = POWER_USAGES;
  DateTime datePicked = DateTime.now();

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
                  height: 70,
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    width: 200,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red),
                      ),
                      textColor: Colors.white,
                      color: Colors.red,
                      onPressed: () async {
                        final picked = await showMonthPicker(
                            context: context, initialDate: datePicked);
                        datePicked = picked != null ? picked : datePicked;
                        print(picked);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          Flexible(
                            child: const Text(
                              'Datum auswählen',
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
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
