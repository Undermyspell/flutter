import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:power_usage/screens/stats_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return FirebaseError();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            getIt.registerSingleton<UsageService>(UsageService());
            return MaterialApp(
                title: "Stromverbrauch für Monate",
                theme: ThemeData(
                    primaryColor: Color.fromRGBO(38, 47, 92, 1),
                    accentColor: Color.fromRGBO(255, 28, 146, 1),
                    fontFamily: "Montserrat"),
                home: MonthlyUsageScreen(),
                routes: {
                  MonthlyUsageScreen.routeName: (ctx) => MonthlyUsageScreen(),
                  EditMonthlyUsageScreen.routeName: (ctx) => EditMonthlyUsageScreen(),
                  StatsScreen.routeName: (ctx) => StatsScreen(),
                },
                debugShowCheckedModeBanner: false);
          }
          return FirebaseLoading();
        });
  }
}

class FirebaseLoading extends StatelessWidget {
  const FirebaseLoading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: new BoxDecoration(color: Colors.white),
        child: Center(
          child: Icon(
            Icons.timelapse,
            size: 150,
            color: Color.fromRGBO(38, 47, 92, 1),
          ),
        ),
      ),
    );
  }
}

class FirebaseError extends StatelessWidget {
  const FirebaseError({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: new BoxDecoration(color: Colors.white),
        child: Center(
          child: Icon(
            Icons.error,
            size: 150,
            color: Color.fromRGBO(38, 47, 92, 1),
          ),
        ),
      ),
    );
  }
}
