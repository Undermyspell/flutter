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
        color: Theme.of(context).primaryColor,
        onRefresh: () => fetchUsageForMonth(datePicked.year, datePicked.month),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.grey[300],
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         height: 70,
              //         alignment: Alignment.center,
              //         child: Container(
              //           height: 50,
              //           width: 200,
              //           child: PowerUsageMonthPicker(
              //             datePicked,
              //             setDate,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
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
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
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
