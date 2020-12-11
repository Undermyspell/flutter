import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:power_usage/screens/stats_screen.dart';
import 'package:power_usage/screens/year_overview_screen.dart';
import 'package:power_usage/widgets/firebase_error.dart';
import 'package:power_usage/widgets/firebase_loading.dart';
import './screens/edit_monthly_usage_screen.dart';
import './state/usages.dart';
import './screens/monthly_usage_screen.dart';
import 'package:firebase_core/firebase_core.dart';

GetIt getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  Future<bool> setup() async {
    await _initialization;
    await FirebaseAuth.instance.signInAnonymously();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: setup(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return FirebaseError();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (!getIt.isRegistered<UsageService>()) {
              getIt.registerSingleton<UsageService>(UsageService());
            }
            return MaterialApp(
                title: "Stromverbrauch für Monate",
                theme: ThemeData(
                    primaryColor: Color(0xFF588da8),
                    accentColor: Color(0xFFdf7599),
                    fontFamily: "Montserrat"),
                home: YearOverviewScreen(),
                routes: {
                  MonthlyUsageScreen.routeName: (ctx) => MonthlyUsageScreen(),
                  EditMonthlyUsageScreen.routeName: (ctx) =>
                      EditMonthlyUsageScreen(),
                  StatsScreen.routeName: (ctx) => StatsScreen(),
                  YearOverviewScreen.routeName: (ctx) => YearOverviewScreen()
                },
                debugShowCheckedModeBanner: false);
          }
          return FirebaseLoading();
        });
  }
}
