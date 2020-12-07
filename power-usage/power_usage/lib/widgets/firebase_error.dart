import 'package:flutter/material.dart';

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
