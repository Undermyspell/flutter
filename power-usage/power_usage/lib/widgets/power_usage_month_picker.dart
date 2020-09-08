import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:intl/intl.dart';

class PowerUsageMonthPicker extends StatelessWidget {
  final DateTime date;
  final Function setDateCallback;
  final DateFormat formatter = DateFormat('MMMM yyyy');

  PowerUsageMonthPicker(this.date, this.setDateCallback);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: Theme.of(context).primaryColor),
      ),
      textColor: Colors.white,
      color: Theme.of(context).primaryColor,
      onPressed: () async {
        final picked =
            await showMonthPicker(context: context, initialDate: date);
        setDateCallback(picked != null ? picked : date);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: 24.0,
          ),
          Flexible(
            child: Text(
              formatter.format(date),
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
