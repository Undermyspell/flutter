import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/usage.dart';

class UsageService {
  CollectionReference usages = FirebaseFirestore.instance.collection('usages');
  CollectionReference yearlySums =
      FirebaseFirestore.instance.collection('yearlysums');

  final BehaviorSubject<Usage> _monthUsage =
      BehaviorSubject.seeded(Usage.empty());
  final BehaviorSubject<bool> _monthUsageIsLoading =
      BehaviorSubject.seeded(false);
  final BehaviorSubject<List<int>> _existingMonthsForYear =
      BehaviorSubject.seeded(List<int>());
  final BehaviorSubject<bool> _existingMonthsForYearLoading =
      BehaviorSubject.seeded(false);
  final BehaviorSubject<List<Usage>> _yearSums = BehaviorSubject.seeded([]);

  Stream<Usage> get monthUsage => _monthUsage.stream;
  Stream<bool> get monthUsageIsLoading => _monthUsageIsLoading.stream;
  Stream<List<Usage>> get yearlyUsages => _yearSums.stream;
  Stream<bool> get existingMonthsForYearLoading => _existingMonthsForYearLoading.stream;
  Stream<List<int>> get existingMonthsForYear => _existingMonthsForYear.stream;

  Future<void> fetchUsageForMonth(int year, int month) async {
    _monthUsageIsLoading.add(true);

    var queryResult = await usages
        .where("year", isEqualTo: year)
        .where("month", isEqualTo: month)
        .limit(1)
        .get();

    var usage = queryResult.docs
        .map((doc) => Usage.fromFirestore(doc))
        .toList()
        .firstWhere((usage) => usage != null, orElse: () => null);

    _monthUsage.add(usage);

    _monthUsageIsLoading.add(false);
  }

  Future<void> fetchUsagesForYears() async {
    const List<int> years = [2019, 2020];

    var queryResult = await yearlySums.where("year", whereIn: years).get();

    var yearSums = queryResult.docs
        .map((doc) => Usage.fromFirestoreYearlySum(doc))
        .toList();

    _yearSums.add(yearSums);
  }

  Future<void> fetchExistingMonthsForYear(int year) async {
    _existingMonthsForYearLoading.add(true);

    var queryResult = await usages.where("year", isEqualTo: year).get();

    var existingMonths = queryResult.docs
        .map((doc) => Usage.fromFirestore(doc))
        .map((usage) => usage.month)
        .toList();

    _existingMonthsForYear.add(existingMonths);

    _existingMonthsForYearLoading.add(false);
  }

  Future<void> saveMonthlyUsage(Usage usage) async {
    return usages.add({
      "consumptionGridSonnenApp": usage.consumptionGridSonnenApp,
      "consumptionHeating": usage.consumptionHeating,
      "consumptionSonnenApp": usage.consumptionSonnenApp,
      "consumptionWarmWater": usage.consumptionWarmWater,
      "counterMeterConsumption": usage.counterMeterConsumption,
      "counterMeterFeedIn": usage.counterMeterFeedIn,
      "month": usage.month,
      "year": usage.year
    });
  }

  void dispose() {
    _monthUsage.close();
    _monthUsageIsLoading.close();
  }
}
