import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/usage.dart';

class UsageService {
  CollectionReference usages = FirebaseFirestore.instance.collection('usages');

  final BehaviorSubject<Usage> _monthUsage =
      BehaviorSubject.seeded(Usage.empty());
  final BehaviorSubject<bool> _monthUsageIsLoading =
      BehaviorSubject.seeded(false);
  final BehaviorSubject<List<Usage>> _yearlyUsages = BehaviorSubject.seeded([]);

  Stream<Usage> get monthUsage => _monthUsage.stream;
  Stream<bool> get monthUsageIsLoading => _monthUsageIsLoading.stream;
  Stream<List<Usage>> get yearlyUsages => _yearlyUsages.stream;

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

    var queryResult = await usages.where("year", whereIn: years).get();

    var allUsages =
        queryResult.docs.map((doc) => Usage.fromFirestore(doc)).toList();

    _yearlyUsages.add(allUsages);
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
