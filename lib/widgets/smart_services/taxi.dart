// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_holidays/util/app_colors.dart';

class TaxiService extends StatefulWidget {
  const TaxiService({Key? key}) : super(key: key);

  @override
  _TaxiServiceState createState() => _TaxiServiceState();
}

class _TaxiServiceState extends State<TaxiService> {
  DateTime pickedTime = DateTime.now();

  TimeOfDay _selectedTime = TimeOfDay(hour: 7, minute: 00);
  TextEditingController partenza = TextEditingController();
  TextEditingController arrivo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _title = Image.asset('assets/logo_200x54.png', fit: BoxFit.cover);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: _title,
          centerTitle: true,
          automaticallyImplyLeading: true,
          foregroundColor: AppColors.primaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Dove vuoi andare?',
                    style: TextStyle(
                        color: AppColors.primaryColor,
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
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.7,
                        child: TextField(
                          autofocus: true,
                          controller: partenza,
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
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.7,
                        child: TextField(
                          autofocus: true,
                          controller: arrivo,
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
                          fontSize: 18,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _pickedDate();
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.fromLTRB(18.0, 0, 18.0, 0)),
                          backgroundColor: MaterialStateProperty.all(
                            AppColors.secondaryColor,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                        ),
                        child: Text(
                          'Seleziona la data',
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _selectTime(context);
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.fromLTRB(18.0, 0, 18.0, 0)),
                            backgroundColor: MaterialStateProperty.all(
                              AppColors.secondaryColor,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                          ),
                          child: Text(
                            'Seleziona l\'ora',
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold),
                          )),
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
                  RiderTaxi(
                      'Mario', 'Rossi', 'Taxi&Co.', '€0,10/100metri', size),
                  Divider(
                    height: 10,
                    thickness: 1,
                    color: Color.fromRGBO(246, 135, 30, 75),
                  ),
                  RiderTaxi(
                      'Giuseppe', 'Verdi', 'GoWithUs', '€0,25/100metri', size),
                  Divider(
                    height: 10,
                    thickness: 1,
                    color: Color.fromRGBO(246, 135, 30, 75),
                  ),
                  RiderTaxi(
                      'Lucia', 'Bianchi', 'YellowTaxi', '€0,15/100metri', size),
                  Divider(
                    height: 10,
                    thickness: 1,
                    color: Color.fromRGBO(246, 135, 30, 75),
                  ),
                  RiderTaxi('Marco', 'Ferrari', 'TempestTaxi', '€0,18/100metri',
                      size),
                  Divider(
                    height: 10,
                    thickness: 1,
                    color: Color.fromRGBO(246, 135, 30, 75),
                  ),
                  RiderTaxi(
                      'Claudio', 'Gallo', 'GoTaxi', '€0,22/100metri', size),
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

  // ignore: non_constant_identifier_names
  Row RiderTaxi(
    String name,
    String surname,
    String company,
    String price,
    Size size,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                partenza.text != '' && arrivo.text != ''
                    ? _showMaterialDialog(
                        size, company, partenza, arrivo, name, surname)
                    : const AlertDialog(
                        title: Text('Attenzione: '),
                        content:
                            Text('Devi aggiungere una partenza e un arrivo'),
                      );
                ;
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

  void _showMaterialDialog(
      Size size,
      String company,
      TextEditingController partenza,
      TextEditingController arrivo,
      String name,
      String surname) {
    showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
              body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              const Text(
                'Riepilogo',
                style: TextStyle(
                    color: Color.fromRGBO(13, 78, 161, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Partenza da: ${partenza.text}'),
                  Text('Arrivo a: ${arrivo.text}'),
                  Text('Data e ora: $pickedTime\n$_selectedTime'),
                  Text('Compagnia: $company'),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Indietro',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('taxi')
                          .add({
                            'taxi_driver_name': '$name $surname',
                            'full_name':
                                FirebaseAuth.instance.currentUser!.displayName,
                            'email': FirebaseAuth.instance.currentUser!.email,
                            'time': _selectedTime.format(context),
                            'date': pickedTime,
                            'partenza': partenza.text,
                            'arrivo': arrivo.text
                          })
                          .then((value) =>
                              _showMaterialDialogReservation(context))
                          .catchError((error) =>
                              print("Failed to add reservation: $error"));
                    },
                    child: const Text(
                      'Conferma',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                    ),
                  ),
                ],
              )
            ]),
          ));
        });
  }

  _dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }

  void _showMaterialDialogReservation(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Smart Service added'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _dismissDialog(context);
                  Navigator.pushNamed(context, '/');
                },
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 20,
                    height: 1,
                  ),
                ),
              )
            ],
          );
        });
  }
}
