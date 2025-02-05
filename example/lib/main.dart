import 'dart:async';
import 'package:flutter/material.dart';
import '../../jalali_table_calendar_pouya_version.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../../lib/src/jalali_table_calendar_pouya_version.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {
  String _datetime = '';
  String _format = 'yyyy-mm-dd';
  String _value = '';
  String _valuePiker = '';
  DateTime selectedDate = DateTime.now();

  Future _selectDate() async {
    String? picked = await jalaliCalendarPicker(
        context: context,
        convertToGregorian: true,
        showTimePicker: false,
        hore24Format: true);
    if (picked != null) setState(() => _value = picked);
  }

  DateTime today = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  String numberFormatter(String number, bool persianNumber) {
    Map numbers = {
      '0': '۰',
      '1': '۱',
      '2': '۲',
      '3': '۳',
      '4': '۴',
      '5': '۵',
      '6': '۶',
      '7': '۷',
      '8': '۸',
      '9': '۹',
    };
    if (persianNumber)
      numbers.forEach((key, value) => number = number.replaceAll(key, value));
    return number;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Jalil Table Calendar'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: JalaliTableCalendar(
                  showTimePicker: false,
                  context: context,
                  locale: Locale('fa'),
                  events: {
                    today: [],
                    today.add(Duration(days: 1)): [],
                    today.add(Duration(days: 2)): []
                    // today: ['sample event', 66546],
                    // today.add(Duration(days: 1)): [6, 5, 465, 1, 66546],
                    // today.add(Duration(days: 2)): [6, 5, 465, 66546],
                    // today.add(Duration(days: 3)): [],
                  },
                  //make marker for every day that have some events
                  // marker: (date, events) {
                  //   return Positioned(
                  //     left: 0,
                  //     top: 0,
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //           color: Colors.blue[200], shape: BoxShape.circle),
                  //       padding: const EdgeInsets.all(6.0),
                  //       child: Center(
                  //         child: Text(numberFormatter(
                  //             (events?.length).toString(), true)),
                  //       ),
                  //     ),
                  //   );
                  // },
                  onMonthChanged: (DateTime date) {
                    print(date);
                  },
                  onDaySelected: (DateTime selectDate) {
                    print(selectDate);
                  }),
            ),
            new ElevatedButton(
              onPressed: _selectDate,
              child: new Text('نمایش تقویم'),
            ),
            Text(
              _value,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Display date picker.
  void _showDatePicker() async {
    final bool showTitleActions = false;
    DatePicker.showDatePicker(context,
        minYear: 1300,
        maxYear: 1450,
        confirm: Text(
          'تایید',
          style: TextStyle(color: Colors.red),
        ),
        cancel: Text(
          'لغو',
          style: TextStyle(color: Colors.cyan),
        ),
        dateFormat: _format, onChanged: (year, month, day) {
      if (year == null || month == null || day == null) return;
      if (!showTitleActions) {
        _changeDatetime(year, month, day);
      }
    }, onConfirm: (year, month, day) {
      if (year == null || month == null || day == null) return;
      _changeDatetime(year, month, day);
      _valuePiker =
          " تاریخ ترکیبی : $_datetime  \n سال : $year \n  ماه :   $month \n  روز :  $day";
    });
  }

  void _changeDatetime(int year, int month, int day) {
    setState(() {
      _datetime = '$year-$month-$day';
    });
  }
}
