import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:get_it/get_it.dart';
import 'package:power_usage/models/usage.dart';
import 'package:power_usage/models/usage_stats.dart';
import '../state/usages.dart';
import 'monthly_usage_screen.dart';

class StatsScreen extends StatefulWidget {
  static const String routeName = "/stats";

  @override
  _State createState() => _State();
}

class _State extends State<StatsScreen> {
  final usageService = GetIt.instance.get<UsageService>();
  Stream<List<charts.Series<UsageStat, String>>> seriesList;
  final bool animate = true;

  Future<void> fetchYearlyUsages() async {
    seriesList = usageService.yearlyUsages.map((yearlyUsages) {
      final UsageStatsData usageStatsData = createUsageStatList(yearlyUsages);
      final List<charts.Series<UsageStat, String>> usageSeriesData =
          _createUsageGroupStatSeries(usageStatsData);
      return usageSeriesData;
    });

    usageService.fetchUsagesForYears();
  }

  UsageStatsData createUsageStatList(List<Usage> yearlyUsages) {
    final List<UsageStat> usageStatsDataCounterMeter = [];
    final List<UsageStat> usageStatsDataCounterMeterFeedIn = [];
    final List<UsageStat> usageStatsDataHeating = [];
    final List<UsageStat> usageStatsDataWarmwater = [];
    final List<UsageStat> usageStatsDataSonnenApp = [];
    final List<UsageStat> usageStatsDataSonnenAppGrid = [];
    yearlyUsages.forEach((yearlyUsage) {
      usageStatsDataCounterMeter.add(UsageStat(
          yearlyUsage.year.toString(), yearlyUsage.counterMeterConsumption));
      usageStatsDataCounterMeterFeedIn.add(UsageStat(
          yearlyUsage.year.toString(), yearlyUsage.counterMeterFeedIn));
      usageStatsDataHeating.add(UsageStat(
          yearlyUsage.year.toString(), yearlyUsage.consumptionHeating));
      usageStatsDataWarmwater.add(UsageStat(
          yearlyUsage.year.toString(), yearlyUsage.consumptionWarmWater));
      usageStatsDataSonnenApp.add(UsageStat(
          yearlyUsage.year.toString(), yearlyUsage.consumptionSonnenApp));
      usageStatsDataSonnenAppGrid.add(UsageStat(
          yearlyUsage.year.toString(), yearlyUsage.consumptionGridSonnenApp));
    });

    return UsageStatsData(
        usageStatsDataCounterMeter,
        usageStatsDataCounterMeterFeedIn,
        usageStatsDataHeating,
        usageStatsDataWarmwater,
        usageStatsDataSonnenApp,
        usageStatsDataSonnenAppGrid);
  }

  @override
  void initState() {
    super.initState();
    fetchYearlyUsages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monatliche Übersicht"),
      ),
      body: Container(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 300,
            ),
            child: StreamBuilder<List<charts.Series<UsageStat, String>>>(
                stream: seriesList,
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? CircularProgressIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                        )
                      : charts.BarChart(
                          snapshot.data,
                          animate: animate,
                          behaviors: [
                            new charts.SeriesLegend(
                                position: charts.BehaviorPosition.bottom,
                                desiredMaxColumns: 2),
                          ],
                        );
                }),
          ),
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
                icon: Icon(Icons.home),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushNamed(MonthlyUsageScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<charts.Series<UsageStat, String>> _createUsageGroupStatSeries(
      UsageStatsData usageStatsData) {
    return [
      new charts.Series<UsageStat, String>(
        id: 'Zählerstand',
        domainFn: (UsageStat usageStat, _) => usageStat.year,
        measureFn: (UsageStat usageStat, _) => usageStat.value,
        data: usageStatsData.counterMeterStatsData,
        colorFn: (UsageStat usageStat, _) =>
            charts.MaterialPalette.blue.shadeDefault,
      ),
      new charts.Series<UsageStat, String>(
        id: 'Einspeisung',
        domainFn: (UsageStat usageStat, _) => usageStat.year,
        measureFn: (UsageStat usageStat, _) => usageStat.value,
        data: usageStatsData.counterMeterFeedInStatsData,
        colorFn: (UsageStat usageStat, _) =>
            charts.MaterialPalette.red.shadeDefault,
      ),
      new charts.Series<UsageStat, String>(
        id: 'Heizung',
        domainFn: (UsageStat usageStat, _) => usageStat.year,
        measureFn: (UsageStat usageStat, _) => usageStat.value,
        data: usageStatsData.cconsumptionHeatingStatsData,
        colorFn: (UsageStat usageStat, _) =>
            charts.MaterialPalette.green.shadeDefault,
      ),
      new charts.Series<UsageStat, String>(
        id: 'Warmwasser',
        domainFn: (UsageStat usageStat, _) => usageStat.year,
        measureFn: (UsageStat usageStat, _) => usageStat.value,
        data: usageStatsData.consumptionWarmWaterStatsData,
        colorFn: (UsageStat usageStat, _) =>
            charts.MaterialPalette.yellow.shadeDefault,
      ),
      new charts.Series<UsageStat, String>(
        id: 'Sonnenapp Verbrauch',
        domainFn: (UsageStat usageStat, _) => usageStat.year,
        measureFn: (UsageStat usageStat, _) => usageStat.value,
        data: usageStatsData.consumptionSonnenAppStatsData,
        colorFn: (UsageStat usageStat, _) =>
            charts.MaterialPalette.purple.shadeDefault,
      ),
      new charts.Series<UsageStat, String>(
        id: 'Sonnenapp Netz',
        domainFn: (UsageStat usageStat, _) => usageStat.year,
        measureFn: (UsageStat usageStat, _) => usageStat.value,
        data: usageStatsData.consumptionSonnenAppGridStatsData,
        colorFn: (UsageStat usageStat, _) =>
            charts.MaterialPalette.gray.shadeDefault,
      ),
    ];
  }
}
