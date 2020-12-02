import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  static const String routeName = "/stats";

  @override
  _State createState() => _State();
}

class _State extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Stats here please",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
