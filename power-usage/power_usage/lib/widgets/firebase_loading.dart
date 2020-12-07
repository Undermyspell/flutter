import 'package:flutter/material.dart';

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