import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import './state/usages.dart';
import './screens/monthly_usage_screen.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<UsageService>(UsageService());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Stromverbrauch für Monate",
      theme: ThemeData(
          primaryColor: Color.fromRGBO(38, 47, 92, 1),
          accentColor: Color.fromRGBO(255, 28, 146, 1),
          fontFamily: "Montserrat"),
      home: MonthlyUsageScreen(),
      routes: {MonthlyUsageScreen.routeName: (ctx) => MonthlyUsageScreen()},
    );
  }
}
