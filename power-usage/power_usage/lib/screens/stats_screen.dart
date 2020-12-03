import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StatsScreen extends StatefulWidget {
  static const String routeName = "/stats";

  @override
  _State createState() => _State();
}

class _State extends State<StatsScreen> {
  final List<charts.Series<Consumption, String>> seriesList =
      _createSampleData();
  final bool animate = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 300,
            ),
            child: charts.BarChart(
              seriesList,
              animate: animate,
              behaviors: [
                new charts.SeriesLegend(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static List<charts.Series<Consumption, String>> _createSampleData() {
    final data = [
      new Consumption("2017", 3456),
      new Consumption("2018", 2934),
      new Consumption("2019", 3678),
      new Consumption("2020", 4311),
    ];

    return [
      new charts.Series<Consumption, String>(
        id: 'Verbrauch',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Consumption sales, _) => sales.year,
        measureFn: (Consumption sales, _) => sales.consumptionMeterValue,
        data: data,
      )
    ];
  }
}

class Consumption {
  final String year;
  final int consumptionMeterValue;

  Consumption(this.year, this.consumptionMeterValue);
}
