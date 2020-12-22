import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:power_usage/routearguments/monthargument.dart';
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
  bool _datePicked = false;

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

  Future<void> _saveForm(BuildContext context) async {
    _formKey.currentState.save();
    showProcessingSnackbar(context);
    await usageService.saveMonthlyUsage(_editedUsage);
    showSaveSuccessSnackbar(context);
    usageService.fetchUsageForMonth(_editedUsage.year, _editedUsage.month);
    Navigator.pop(context);
  }

  void showProcessingSnackbar(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content:
          Text('Saving usage for ${_editedUsage.year}/${_editedUsage.month}'),
      backgroundColor: Theme.of(context).accentColor,
    ));
  }

  void showSaveSuccessSnackbar(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('Saved usage for ${_editedUsage.year}/${_editedUsage.month}'),
        backgroundColor: Colors.green));
    usageService.fetchUsageForMonth(_editedUsage.year, _editedUsage.month);
  }

  @override
  Widget build(BuildContext context) {
    final MonthArgument monthArgument =
        ModalRoute.of(context).settings.arguments;
    _datePicked = monthArgument != null;
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
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
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Einspeisung Zählerstand 1. des Monats:",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
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
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Verbrauch Heizung:",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
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
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Verbrauch Warmwasser:",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
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
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Verbrauch Sonnen App:",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
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
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Netzbezug Sonnen App:",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
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
                        _saveForm(context);
                      }
                    },
                  ),
                  MonthPickerFormField(
                      context: context,
                      onSaved: setDate,
                      validator: (value) {
                        if (!_datePicked) {
                          return "Bitte einen Monat wählen";
                        }
                        return null;
                      },
                      initialValue: monthArgument != null
                          ? DateTime(monthArgument.year, monthArgument.month)
                          : DateTime.now(),
                      onValueChange: (_) => _datePicked = true),
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
                            _saveForm(context);
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

class MonthPickerFormField extends FormField<DateTime> {
  final DateTime datePicked = DateTime.now();
  final DateFormat formatter = DateFormat('MMMM yyyy');

  MonthPickerFormField(
      {BuildContext context,
      FormFieldSetter<DateTime> onSaved,
      FormFieldValidator<DateTime> validator,
      DateTime initialValue,
      void Function(DateTime) onValueChange})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<DateTime> state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      final prev = state.value;
                      final picked = await showMonthPicker(
                          context: context, initialDate: initialValue);
                      state.didChange(picked != null ? picked : prev);
                      onValueChange(picked);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 30,
                          ),
                          SizedBox(width: 5),
                          Text(
                            DateFormat('MMMM yyyy').format(state.value),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  state.hasError
                      ? Text(
                          state.errorText,
                          style: TextStyle(color: Colors.red),
                        )
                      : Container()
                ],
              );
            });
}
