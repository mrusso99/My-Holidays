// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaxiService extends StatefulWidget {
  const TaxiService({Key? key}) : super(key: key);

  @override
  _TaxiServiceState createState() => _TaxiServiceState();
}

class _TaxiServiceState extends State<TaxiService> {
  DateTime pickedTime = DateTime.now();

  TimeOfDay _selectedTime = TimeOfDay(hour: 7, minute: 00);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: Column(
            children: [
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
                height: 10,
              ),
              const Text(
                'Dove vuoi andare?',
                style: TextStyle(
                    color: Color.fromRGBO(13, 78, 161, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Partenza:',
                    style: TextStyle(
                        color: Color.fromRGBO(13, 78, 161, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.withOpacity(0.1),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintText: 'es. Via Vittorio Emanuele, 2',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(246, 135, 30, 75),
                              width: 1),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Arrivo:',
                    style: TextStyle(
                        color: Color.fromRGBO(13, 78, 161, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.withOpacity(0.1),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintText: 'es. Piazza Garibaldi',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(246, 135, 30, 75),
                              width: 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Data e ora:',
                    style: TextStyle(
                        color: Color.fromRGBO(13, 78, 161, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _pickedDate();
                          },
                          child: Text('Seleziona la data')),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _selectTime(context);
                      },
                      child: Text('Seleziona l\'ora')),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Scegli uno tra i seguenti servizi taxi: ',
                style: TextStyle(
                    color: Color.fromRGBO(13, 78, 161, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 25,
              ),
              RiderTaxi('Mario', 'Rossi', 'Taxi&Co.', '€0,10/100metri'),
              RiderTaxi('Giuseppe', 'Verdi', 'GoWithUs', '€0,25/100metri'),
              RiderTaxi('Lucia', 'Bianchi', 'YellowTaxi', '€0,15/100metri'),
              RiderTaxi('Marco', 'Ferrari', 'TempestTaxi', '€0,18/100metri'),
            ],
          )),
    ));
  }

  _pickedDate() async {
    DateTime? date = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDate: pickedTime,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
              primary: Color.fromRGBO(246, 135, 30, 75),
            )),
            child: child!,
          );
        });
    if (date != null) {
      setState(() {
        pickedTime = date;
      });
    }
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
      confirmText: 'Conferma',
      cancelText: 'Indietro',
      builder: (context, child) => Theme(
          data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
            primary: Color.fromRGBO(246, 135, 30, 75),
            onSurface: Colors.black,
          )),
          child: child!),
    );

    if (timeOfDay != null && timeOfDay != _selectedTime) {
      setState(() {
        _selectedTime = timeOfDay;
      });
    }
  }

  Row RiderTaxi(
    String name,
    String surname,
    String company,
    String price,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Icon(
              Icons.account_circle,
              size: 40,
              color: Color.fromRGBO(13, 78, 161, 1),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '$name \n$surname  ',
              style: TextStyle(
                  color: Color.fromRGBO(13, 78, 161, 1),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(
          '$company\n$price',
          style: TextStyle(
              color: Color.fromRGBO(13, 78, 161, 1),
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        Column(
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.call,
                color: Color.fromRGBO(13, 78, 161, 1),
              ),
              label: Text(
                'Chiama',
                style: TextStyle(
                    color: Color.fromRGBO(13, 78, 161, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                _showMaterialDialog();
              },
              icon: Icon(
                Icons.book_outlined,
                color: Color.fromRGBO(13, 78, 161, 1),
              ),
              label: Text(
                'Prenota',
                style: TextStyle(
                    color: Color.fromRGBO(13, 78, 161, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text('Prenotazione effettuata'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Conferma',
                    style: TextStyle(
                        color: Color.fromRGBO(13, 78, 161, 1), fontSize: 18),
                  ))
            ],
          );
        });
  }
}
