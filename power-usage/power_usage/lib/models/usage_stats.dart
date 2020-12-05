
class UsageStat {
  final String year;
  final double value;

  UsageStat(this.year, this.value);
}

class UsageStatsData {
    final List<UsageStat> counterMeterStatsData;
    final List<UsageStat> counterMeterFeedInStatsData;
    final List<UsageStat> cconsumptionHeatingStatsData;
    final List<UsageStat> consumptionWarmWaterStatsData;
    final List<UsageStat> consumptionSonnenAppStatsData;
    final List<UsageStat> consumptionSonnenAppGridStatsData;

  UsageStatsData(this.counterMeterStatsData, this.counterMeterFeedInStatsData, this.cconsumptionHeatingStatsData, this.consumptionWarmWaterStatsData, this.consumptionSonnenAppStatsData, this.consumptionSonnenAppGridStatsData);
}