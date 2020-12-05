import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory Usage.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return Usage(
        counterMeterConsumption: data['counterMeterConsumption'] != null ? double.parse(data['counterMeterConsumption'].toString()) : 0,
        counterMeterFeedIn: data['counterMeterFeedIn'] != null ? double.parse(data['counterMeterFeedIn'].toString()) : 0,
        consumptionSonnenApp: data['consumptionSonnenApp'] != null ? double.parse(data['consumptionSonnenApp'].toString()) : 0,
        consumptionGridSonnenApp: data['consumptionGridSonnenApp'] != null ? double.parse(data['consumptionGridSonnenApp'].toString()) : 0,
        consumptionHeating: data['consumptionHeating'] != null ? double.parse(data['consumptionHeating'].toString()) : 0,
        consumptionWarmWater: data['consumptionWarmWater'] != null ? double.parse(data['consumptionWarmWater'].toString()) : 0,
        year: data['year'] ?? 0,
        month: data['month'] ?? 0);
  }

  factory Usage.fromFirestoreYearlySum(DocumentSnapshot doc) {
    Map data = doc.data();
    return Usage(
        counterMeterConsumption: data['sumCounterMeterConsumption'] != null ? double.parse(data['sumCounterMeterConsumption'].toString()) : 0,
        counterMeterFeedIn: data['sumCounterMeterFeedIn'] != null ? double.parse(data['sumCounterMeterFeedIn'].toString()) : 0,
        consumptionSonnenApp: data['sumConsumptionSonnenApp'] != null ? double.parse(data['sumConsumptionSonnenApp'].toString()) : 0,
        consumptionGridSonnenApp: data['sumConsumptionGridSonnenApp'] != null ? double.parse(data['sumConsumptionGridSonnenApp'].toString()) : 0,
        consumptionHeating: data['sumConsumptionHeating'] != null ? double.parse(data['sumConsumptionHeating'].toString()) : 0,
        consumptionWarmWater: data['sumConsumptionWarmWater'] != null ? double.parse(data['sumConsumptionWarmWater'].toString()) : 0,
        year: data['year'] ?? 0,
        month: 0);
  }
}
