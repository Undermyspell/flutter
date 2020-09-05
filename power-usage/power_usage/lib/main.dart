import 'package:flutter/material.dart';
import './screens/monthly_usage_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Stromverbrauch für Monate",
      theme: ThemeData(
        primaryColor: Colors.red[500],
        accentColor: Colors.grey[500],
      ),
      home: MonthlyUsageScreen(),
      routes: {MonthlyUsageScreen.routeName: (ctx) => MonthlyUsageScreen()},
    );
  }
}
