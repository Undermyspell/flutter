import 'package:flutter/material.dart';

class Usage {
  double counterMeterConsumption;
  double counterMeterFeedIn;
  double consumptionSonnenApp;
  double consumptionGridSonnenApp;
  double consumptionHeating;
  double consumptionWarmWater;
  int month;
  int year;

  Usage(
      {@required this.counterMeterConsumption,
      @required this.counterMeterFeedIn,
      @required this.consumptionSonnenApp,
      @required this.consumptionGridSonnenApp,
      @required this.consumptionHeating,
      @required this.consumptionWarmWater,
      @required this.month,
      @required this.year});

  Usage.empty();
}
