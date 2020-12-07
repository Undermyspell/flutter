import 'package:flutter/material.dart';

class MonthTile extends StatelessWidget {
  const MonthTile({
    Key key,
    @required this.months,
    @required this.i,
  }) : super(key: key);

  final List<int> months;
  final int i;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Center(
          child: Text(
            months[i - 1].toString(),
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Theme.of(context)
                  .accentColor, // Colors.white.withOpacity(.5),
            ),
          ),
        ),
        decoration: new BoxDecoration(
          border: Border.all(
            width: 3,
            color: Colors.white.withOpacity(.5),
          ),
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(10, 10), // changes position of shadow
            ),
          ],
        ),
      ),
      onTap: () => print(i),
    );
  }
}
