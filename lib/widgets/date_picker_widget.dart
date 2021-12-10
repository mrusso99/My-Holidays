import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';

import 'button_widget.dart';

class DateRangePickerWidget extends StatefulWidget {
  @override
  _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTimeRange dateRange = DateTimeRange(start: DateTime.now().subtract(Duration(days: 0)), end: DateTime(2100));

  String getFrom() {
    if (dateRange == null) {
      return 'From';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'Until';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange.end);
    }
  }


  @override
  Widget build(BuildContext context) => HeaderWidget(
    title: LanguageLocalizations.of(context).date_selector,
    child: Row(
      children: [
        Expanded(
          child: returnRangePickerFrom(context)
        ),
        const SizedBox(width: 8),
        Icon(Icons.arrow_forward, color: getThemeColor()),
        const SizedBox(width: 8),
        Expanded(
          child: returnRangePickerUntil(context)
        ),
      ],
    ),
  );

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 24 * 3)),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 100),
      initialDateRange: dateRange,
    );
    if (newDateRange == null) return;

    setState(() => dateRange = newDateRange);
  }

  Color getThemeColor(){
    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    if (isDarkMode){
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  Widget returnRangePickerFrom(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          primaryColor: Colors.blue,
          buttonTheme: ButtonThemeData(
              highlightColor: Colors.green,
              buttonColor: Colors.green,
              colorScheme: Theme.of(context).colorScheme.copyWith(
                  secondary: Colors.greenAccent,
                  background: Colors.white,
                  primary: Colors.green,
                  primaryVariant: Colors.green,
                  brightness: Brightness.dark,
                  onBackground: Colors.green),
              textTheme: ButtonTextTheme.accent), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green)),
      child: Builder(
        builder: (context) => ButtonWidget(
          text: getFrom(),
          onClicked: () => pickDateRange(context),
        ),
      ),
    );
  }

  Widget returnRangePickerUntil(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          primaryColor: Colors.blue,
          buttonTheme: ButtonThemeData(
              highlightColor: Colors.green,
              buttonColor: Colors.green,
              colorScheme: Theme.of(context).colorScheme.copyWith(
                  secondary: Colors.greenAccent,
                  background: Colors.white,
                  primary: Colors.green,
                  primaryVariant: Colors.green,
                  brightness: Brightness.dark,
                  onBackground: Colors.green),
              textTheme: ButtonTextTheme.accent), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green)),
      child: Builder(
        builder: (context) => ButtonWidget(
          text: getUntil(),
          onClicked: () => pickDateRange(context),
        ),
      ),
    );
  }

}