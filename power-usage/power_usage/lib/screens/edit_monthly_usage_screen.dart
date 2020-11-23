import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../models/usage.dart';
import '../state/usages.dart';

class EditMonthlyUsageScreen extends StatefulWidget {
  static const String routeName = "/editmonthlyusage";

  @override
  _EditMonthlyUsageScreenState createState() => _EditMonthlyUsageScreenState();
}

class _EditMonthlyUsageScreenState extends State<EditMonthlyUsageScreen> {
  final usageService = GetIt.instance.get<UsageService>();
  final _formKey = GlobalKey<FormState>();
  final focusCounterMeterFeedIn = FocusNode();
  final focusConsumptionHeating = FocusNode();
  final focusConsumptionSonnenApp = FocusNode();
  final focusConsumptionWarmWater = FocusNode();
  final focusConsumptionGridSonnenApp = FocusNode();
  final DateFormat formatter = DateFormat('MMMM yyyy');
  DateTime datePicked = DateTime.now();
  setDate(DateTime date) {
    _editedUsage = Usage(
        consumptionGridSonnenApp: _editedUsage.consumptionGridSonnenApp,
        consumptionHeating: _editedUsage.consumptionHeating,
        consumptionSonnenApp: _editedUsage.consumptionGridSonnenApp,
        consumptionWarmWater: _editedUsage.consumptionWarmWater,
        counterMeterConsumption: _editedUsage.counterMeterConsumption,
        counterMeterFeedIn: _editedUsage.counterMeterFeedIn,
        month: date.month,
        year: date.year);

    setState(() {
      datePicked = date;
    });
  }

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

  Future<void> _saveForm() async {
    _formKey.currentState.save();
    await usageService.saveMonthlyUsage(_editedUsage);
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
                    onFieldSubmitted: (_) async {
                      if (_formKey.currentState.validate()) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Saving usage for ${_editedUsage.year}/${_editedUsage.month}'),
                            backgroundColor: Theme.of(context).accentColor,
                          ));
                          await _saveForm();
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Saved usage for ${_editedUsage.year}/${_editedUsage.month}'),
                              backgroundColor: Colors.green));
                          usageService.fetchUsageForMonth(
                              _editedUsage.year, _editedUsage.month);
                          Navigator.pop(context);
                        }
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () async {
                          final picked = await showMonthPicker(
                              context: context, initialDate: datePicked);
                          setDate(picked != null ? picked : datePicked);
                        },
                      ),
                      Text(
                        formatter.format(datePicked),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
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
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Saving usage for ${_editedUsage.year}/${_editedUsage.month}'),
                              backgroundColor: Theme.of(context).accentColor,
                            ));
                            await _saveForm();
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Saved usage for ${_editedUsage.year}/${_editedUsage.month}'),
                                backgroundColor: Colors.green));
                            usageService.fetchUsageForMonth(
                                _editedUsage.year, _editedUsage.month);
                            Navigator.pop(context);
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
