import 'package:flutter/material.dart';

class Usage {
  final double counterMeterConsumption;
  final double counterMeterFeedIn;
  final double consumptionSonnenApp;
  final double consumptionGridSonnenApp;
  final double consumptionHeating;
  final double consumptionWarmWater;
  final int month;
  final int year;

  const Usage(
      {@required this.counterMeterConsumption,
      @required this.counterMeterFeedIn,
      @required this.consumptionSonnenApp,
      @required this.consumptionGridSonnenApp,
      @required this.consumptionHeating,
      @required this.consumptionWarmWater, 
      @required this.month,
      @required this.year});
}
