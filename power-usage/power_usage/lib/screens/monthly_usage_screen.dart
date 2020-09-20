import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../widgets/power_usage_tiles.dart';
import '../state/usages.dart';

class MonthlyUsageScreen extends StatefulWidget {
  static const String routeName = "/monthlyusages";

  @override
  _MonthlyUsageScreenState createState() => _MonthlyUsageScreenState();
}

class _MonthlyUsageScreenState extends State<MonthlyUsageScreen> {
  final usageService = GetIt.instance.get<UsageService>();
  DateTime datePicked = DateTime.now();

  Future<void> fetchUsageForMonth(int year, int month) async {
    await usageService.fetchUsageForMonth(year, month);
  }

  setDate(DateTime date) {
    fetchUsageForMonth(date.year, date.month);
    setState(() {
      datePicked = date;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUsageForMonth(datePicked.month, datePicked.year);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monatliche Übersicht"),
      ),
      body: RefreshIndicator(
        backgroundColor: Theme.of(context).accentColor,
        color: Colors.white,
        onRefresh: () => fetchUsageForMonth(datePicked.year, datePicked.month),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.white,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: StreamBuilder<bool>(
                    stream: usageService.monthUsageIsLoading,
                    builder: (context, snapshot) {
                      return !snapshot.hasData || snapshot.data
                          ? Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            )
                          : PowerUsageResultTiles();
                    }),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => new BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  backgroundColor: Colors.white,
                  content: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    FlatButton(
                      child: Text("ok"),
                      onPressed: () {},
                    ),
                    FlatButton(
                      child: Text("cancel"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                )),
          );
        },
        backgroundColor: Theme.of(context).accentColor,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                color: Colors.white,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.calendar_today),
                color: Colors.white,
                onPressed: () async {
                  final picked = await showMonthPicker(
                      context: context, initialDate: datePicked);
                  setDate(picked != null ? picked : datePicked);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
