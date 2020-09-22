import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditMonthlyUsageScreen extends StatelessWidget {
  static const String routeName = "/editmonthlyusage";
  final _formKey = GlobalKey<FormState>();

  String _inputValidator(value) {
    if (value.isEmpty) {
      return "Bitte einen Wert eingeben";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monatsverbrauch bearbeiten"),
      ),
      body: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Verbrauch Zählerstand 1. des Monats:",
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    validator: (value) => _inputValidator(value),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Einspeisung Zählerstand 1. des Monats:",
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Verbrauch Heizung:",
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Verbrauch Warmwasser:",
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Verbrauch Sonnen App:",
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Netzbezug Sonnen App:",
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Colors.white,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Processing Data'),
                              backgroundColor: Theme.of(context).accentColor,
                            ));
                          }
                        },
                        child: Text(
                          "Speichern",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
