import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/usage.dart';

class EditMonthlyUsageScreen extends StatefulWidget {
  static const String routeName = "/editmonthlyusage";

  @override
  _EditMonthlyUsageScreenState createState() => _EditMonthlyUsageScreenState();
}

class _EditMonthlyUsageScreenState extends State<EditMonthlyUsageScreen> {
  final _formKey = GlobalKey<FormState>();
  final focusCounterMeterFeedIn = FocusNode();
  final focusConsumptionHeating = FocusNode();
  final focusConsumptionSonnenApp = FocusNode();
  final focusConsumptionWarmWater = FocusNode();
  final focusConsumptionGridSonnenApp = FocusNode();

  var _editedUsage = Usage(
      consumptionGridSonnenApp: 0,
      consumptionHeating: 0,
      consumptionSonnenApp: 0,
      consumptionWarmWater: 0,
      counterMeterConsumption: 0,
      counterMeterFeedIn: 0,
      year: 1700,
      month: 1);

  String _inputValidator(value) {
    if (value.isEmpty) {
      return "Bitte einen Wert eingeben";
    }
    return null;
  }

  void _saveForm() {
    _formKey.currentState.save();
    print(_editedUsage.counterMeterConsumption);
    print(_editedUsage.counterMeterFeedIn);
    print(_editedUsage.consumptionHeating);
    print(_editedUsage.consumptionWarmWater);
    print(_editedUsage.consumptionSonnenApp);
    print(_editedUsage.consumptionGridSonnenApp);
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
                    onSaved: (value) {
                      _editedUsage = Usage(
                          counterMeterConsumption: double.parse(value),
                          counterMeterFeedIn: _editedUsage.counterMeterFeedIn,
                          month: _editedUsage.month,
                          year: _editedUsage.year,
                          consumptionWarmWater:
                              _editedUsage.consumptionWarmWater,
                          consumptionSonnenApp:
                              _editedUsage.consumptionGridSonnenApp,
                          consumptionHeating: _editedUsage.consumptionHeating,
                          consumptionGridSonnenApp:
                              _editedUsage.consumptionGridSonnenApp);
                    },
                    onFieldSubmitted: (v) => FocusScope.of(context)
                        .requestFocus(focusCounterMeterFeedIn),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Einspeisung Zählerstand 1. des Monats:",
                    ),
                    textInputAction: TextInputAction.next,
                    focusNode: focusCounterMeterFeedIn,
                    keyboardType: TextInputType.number,
                    validator: (value) => _inputValidator(value),
                    onSaved: (value) {
                      _editedUsage = Usage(
                          counterMeterConsumption:
                              _editedUsage.counterMeterConsumption,
                          counterMeterFeedIn: double.parse(value),
                          month: _editedUsage.month,
                          year: _editedUsage.year,
                          consumptionWarmWater:
                              _editedUsage.consumptionWarmWater,
                          consumptionSonnenApp:
                              _editedUsage.consumptionSonnenApp,
                          consumptionHeating: _editedUsage.consumptionHeating,
                          consumptionGridSonnenApp:
                              _editedUsage.consumptionGridSonnenApp);
                    },
                    onFieldSubmitted: (v) => FocusScope.of(context)
                        .requestFocus(focusConsumptionHeating),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Verbrauch Heizung:",
                    ),
                    focusNode: focusConsumptionHeating,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    validator: (value) => _inputValidator(value),
                    onSaved: (value) {
                      _editedUsage = Usage(
                          counterMeterConsumption:
                              _editedUsage.counterMeterConsumption,
                          counterMeterFeedIn: _editedUsage.counterMeterFeedIn,
                          month: _editedUsage.month,
                          year: _editedUsage.year,
                          consumptionWarmWater:
                              _editedUsage.consumptionWarmWater,
                          consumptionSonnenApp:
                              _editedUsage.consumptionSonnenApp,
                          consumptionHeating: double.parse(value),
                          consumptionGridSonnenApp:
                              _editedUsage.consumptionGridSonnenApp);
                    },
                    onFieldSubmitted: (v) => FocusScope.of(context)
                        .requestFocus(focusConsumptionWarmWater),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Verbrauch Warmwasser:",
                    ),
                    focusNode: focusConsumptionWarmWater,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    validator: (value) => _inputValidator(value),
                    onSaved: (value) {
                      _editedUsage = Usage(
                          counterMeterConsumption:
                              _editedUsage.counterMeterConsumption,
                          counterMeterFeedIn: _editedUsage.counterMeterFeedIn,
                          month: _editedUsage.month,
                          year: _editedUsage.year,
                          consumptionWarmWater: double.parse(value),
                          consumptionSonnenApp:
                              _editedUsage.consumptionSonnenApp,
                          consumptionHeating: _editedUsage.consumptionHeating,
                          consumptionGridSonnenApp:
                              _editedUsage.consumptionGridSonnenApp);
                    },
                    onFieldSubmitted: (v) => FocusScope.of(context)
                        .requestFocus(focusConsumptionSonnenApp),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Verbrauch Sonnen App:",
                    ),
                    focusNode: focusConsumptionSonnenApp,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    validator: (value) => _inputValidator(value),
                    onSaved: (value) {
                      _editedUsage = Usage(
                          counterMeterConsumption:
                              _editedUsage.counterMeterConsumption,
                          counterMeterFeedIn: _editedUsage.counterMeterFeedIn,
                          month: _editedUsage.month,
                          year: _editedUsage.year,
                          consumptionWarmWater:
                              _editedUsage.consumptionWarmWater,
                          consumptionSonnenApp: double.parse(value),
                          consumptionHeating: _editedUsage.consumptionHeating,
                          consumptionGridSonnenApp:
                              _editedUsage.consumptionGridSonnenApp);
                    },
                    onFieldSubmitted: (v) => FocusScope.of(context)
                        .requestFocus(focusConsumptionGridSonnenApp),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Netzbezug Sonnen App:",
                    ),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    focusNode: focusConsumptionGridSonnenApp,
                    validator: (value) => _inputValidator(value),
                    onSaved: (value) {
                      _editedUsage = Usage(
                        counterMeterConsumption:
                            _editedUsage.counterMeterConsumption,
                        counterMeterFeedIn: _editedUsage.counterMeterFeedIn,
                        month: _editedUsage.month,
                        year: _editedUsage.year,
                        consumptionWarmWater: _editedUsage.consumptionWarmWater,
                        consumptionSonnenApp: _editedUsage.consumptionSonnenApp,
                        consumptionHeating: _editedUsage.consumptionHeating,
                        consumptionGridSonnenApp: double.parse(value),
                      );
                    },
                    onFieldSubmitted: (_) {
                      if (_formKey.currentState.validate()) {
                        _saveForm();
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Processing Data'),
                          backgroundColor: Theme.of(context).accentColor,
                        ));
                      }
                    },
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
                            _saveForm();
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
