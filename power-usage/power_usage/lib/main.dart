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
        primaryColor: const Color.fromARGB(255, 63 , 131, 192),
        accentColor: Colors.grey[500],
      ),
      home: MonthlyUsageScreen(),
      routes: {MonthlyUsageScreen.routeName: (ctx) => MonthlyUsageScreen()},
    );
  }
}
