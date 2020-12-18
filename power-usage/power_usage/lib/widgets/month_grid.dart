import 'package:flutter/material.dart';
import 'package:power_usage/state/usages.dart';
import './month_tile.dart';

class MonthGrid extends StatelessWidget {
  const MonthGrid({
    Key key,
    @required this.usageService,
    @required this.months,
  }) : super(key: key);

  final UsageService usageService;
  final List<int> months;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<int>>(
        stream: usageService.existingMonthsForYear,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Padding(
                  padding: const EdgeInsets.all(15),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: [
                      for (var i in months)
                        MonthTile(
                          months: months,
                          i: i,
                          color: snapshot.data.contains(i)
                              ? Color(0xFF5aa469)
                              : Color(0xFFd35d6e),
                        ),
                    ],
                  ),
                )
              : Container();
        });
  }
}
