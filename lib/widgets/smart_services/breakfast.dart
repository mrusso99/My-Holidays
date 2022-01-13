import 'dart:ui';

import 'package:flutter/material.dart';

class BreakFast extends StatefulWidget {
  const BreakFast({Key? key}) : super(key: key);

  @override
  _BreakFastState createState() => _BreakFastState();
}

class _BreakFastState extends State<BreakFast> {
  TimeOfDay _selectedTime = TimeOfDay(hour: 7, minute: 00);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color.fromRGBO(13, 78, 161, 1),
                ),
              ),
              const RotatedBox(
                quarterTurns: 135,
                child: Icon(
                  Icons.bar_chart_rounded,
                  color: Color.fromRGBO(13, 78, 161, 1),
                  size: 28,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'A che ora vuoi \nfare colazione? :',
                style: TextStyle(
                    color: Color.fromRGBO(13, 78, 161, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _selectTime(context);
                    },
                    child: const Text('Seleziona l\'ora'),
                  ),
                  Text(
                    'Ore: ${_selectedTime.format(context)}',
                    style: const TextStyle(
                      color: Color.fromRGBO(246, 135, 30, 75),
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
          /**Inserimento ora */
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
      confirmText: 'Conferma',
      cancelText: 'Indietro',
    );

    if (timeOfDay != null && timeOfDay != _selectedTime) {
      setState(() {
        _selectedTime = timeOfDay;
      });
    }
  }
}
