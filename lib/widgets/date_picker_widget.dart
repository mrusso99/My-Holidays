import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/util/Global.dart';

import 'button_widget.dart';

class DateRangePickerWidget extends StatefulWidget {
  const DateRangePickerWidget({Key? key}) : super(key: key);

  @override
  _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTimeRange dateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 0)),
      end: DateTime.now().add(Duration(hours: 24)));

  String getFrom() {
    // ignore: unnecessary_null_comparison
    if (dateRange == null) {
      return 'From';
    } else {
      GlobalState.instance
          .set('dateFrom', DateFormat('dd/MM/yyyy').format(dateRange.start));
      return DateFormat('dd/MM/yyyy').format(dateRange.start);
    }
  }

  String getUntil() {
    // ignore: unnecessary_null_comparison
    if (dateRange == null) {
      return 'Until';
    } else {
      GlobalState.instance
          .set('dateUntil', DateFormat('dd/MM/yyyy').format(dateRange.end));
      return DateFormat('dd/MM/yyyy').format(dateRange.end);
    }
  }

  @override
  Widget build(BuildContext context) => HeaderWidget(
        title: LanguageLocalizations.of(context).date_selector,
        child: Row(
          children: [
            Expanded(child: returnRangePickerFrom(context)),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward, color: getThemeColor()),
            const SizedBox(width: 8),
            Expanded(child: returnRangePickerUntil(context)),
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
      locale: Localizations.localeOf(context),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // header background color
              onPrimary: getThemeColor(), // header text color
              onSurface: getThemeColor(), // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: getThemeColor(), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (newDateRange == null) return;

    setState(() => dateRange = newDateRange);
  }

  Color getThemeColor() {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (isDarkMode) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  Widget returnRangePickerFrom(BuildContext context) {
    return Builder(
      builder: (context) => ButtonWidget(
        text: getFrom(),
        onClicked: () => pickDateRange(context),
      ),
    );
  }

  Widget returnRangePickerUntil(BuildContext context) {
    return Builder(
      builder: (context) => ButtonWidget(
        text: getUntil(),
        onClicked: () => pickDateRange(context),
      ),
    );
  }
}
