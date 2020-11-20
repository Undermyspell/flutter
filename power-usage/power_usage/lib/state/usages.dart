import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/usage.dart';

// ignore: non_constant_identifier_names
List<Usage> POWER_USAGES = [
  Usage(
      counterMeterConsumption: 900,
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
  CollectionReference usages = FirebaseFirestore.instance.collection('usages');

  final BehaviorSubject<Usage> _monthUsage =
      BehaviorSubject.seeded(Usage.empty());
  final BehaviorSubject<bool> _monthUsageIsLoading =
      BehaviorSubject.seeded(false);

  Stream<Usage> get monthUsage => _monthUsage.stream;
  Stream<bool> get monthUsageIsLoading => _monthUsageIsLoading.stream;

  Future<void> fetchUsageForMonth(int year, int month) async {
    _monthUsageIsLoading.add(true);

    var queryResult = await usages
        .where("year", isEqualTo: year)
        .where("month", isEqualTo: month)
        .limit(1)
        .get();

    var usage = queryResult.docs
        .map((e) => Usage.fromFirestore(e))
        .toList()
        .firstWhere((usage) => usage != null, orElse: () => null);

    _monthUsage.add(usage);

    _monthUsageIsLoading.add(false);
  }

  void dispose() {
    _monthUsage.close();
    _monthUsageIsLoading.close();
  }
}
