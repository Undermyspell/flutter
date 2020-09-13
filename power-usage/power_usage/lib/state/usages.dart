import 'package:rxdart/rxdart.dart';

import '../models/usage.dart';

 // ignore: non_constant_identifier_names
 List<Usage> POWER_USAGES = [
  Usage(
      counterMeterConsumption: 1200,
      counterMeterFeedIn: 301.3,
      consumptionSonnenApp: 400,
      consumptionGridSonnenApp: 200,
      consumptionHeating: 300,
      consumptionWarmWater: 50,
      month: 1,
      year: 2020),
  Usage(
      counterMeterConsumption: 3500,
      counterMeterFeedIn: 899.4,
      consumptionSonnenApp: 345.44,
      consumptionGridSonnenApp: 201.33,
      consumptionHeating: 434.3,
      consumptionWarmWater: 51.2,
      month: 2,
      year: 2020)
];

class UsageService {
  final BehaviorSubject<Usage> _monthUsage = BehaviorSubject.seeded(Usage.empty());
  final BehaviorSubject<bool> _monthUsageIsLoading =
      BehaviorSubject.seeded(false);

  Stream<Usage> get monthUsage => _monthUsage.stream;
  Stream<bool> get monthUsageIsLoading => _monthUsageIsLoading.stream;

  void fetchUsageForMonth(int year, int month) async {
    _monthUsageIsLoading.add(true);
    await Future.delayed(Duration(seconds: 2));
    _monthUsage.add(POWER_USAGES.firstWhere(
        (usage) => usage.month == month && usage.year == year,
        orElse: () => null));
    _monthUsageIsLoading.add(false);
  }

  void dispose() {
    _monthUsage.close();
    _monthUsageIsLoading.close();
  }
}
