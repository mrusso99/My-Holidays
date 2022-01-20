import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BreakFast extends StatefulWidget {
  const BreakFast({Key? key}) : super(key: key);

  @override
  _BreakFastState createState() => _BreakFastState();
}

class _BreakFastState extends State<BreakFast> {
  TimeOfDay _selectedTime = const TimeOfDay(hour: 7, minute: 00);
  bool _selected = false;
  bool _selected1 = false;
  bool _selected2 = false;
  bool _selected3 = false;
  bool _selected4 = false;
  bool _selected5 = false;

  double _totalPrice = 0.00;

  List ordine = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        _selectTime(context);
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0)),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(13, 78, 161, 1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                      ),
                      child: const Text(
                        "Seleziona l'orario",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Text(
                      'Ore: ${_selectedTime.format(context)}',
                      style: const TextStyle(
                        color: Color.fromRGBO(246, 135, 30, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
            /**Inserimento ora */
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Bevande',
              style: TextStyle(
                  color: Color.fromRGBO(13, 78, 161, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                SizedBox(
                  height: 50,
                  child: CheckboxListTile(
                    title: const Text('Caffè espresso'),
                    subtitle: const Text('€1,00'),
                    value: _selected,
                    onChanged: (value) {
                      setState(() {
                        _selected = value!;
                      });

                      if (_selected == true) {
                        _totalPrice += 1;
                        ordine.add('Caffè espresso    €1,00');
                      } else if (_selected == false && _totalPrice != 0.00) {
                        _totalPrice -= 1;
                        ordine.removeWhere(
                            (element) => element == 'Caffè espresso    €1,00');
                      }
                    },
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: CheckboxListTile(
                    title: const Text(
                      'Caffe macchiato',
                    ),
                    subtitle: const Text('€1,10'),
                    value: _selected1,
                    onChanged: (value) {
                      setState(() {
                        _selected1 = value!;
                      });
                      if (_selected1 == true) {
                        _totalPrice += 1.10;
                        ordine.add('Caffè macchiato €1,10');
                      } else if (_selected1 == false && _totalPrice != 0.00) {
                        _totalPrice -= 1.10;
                        ordine.removeWhere(
                            (element) => element == 'Caffè macchiato €1,10');
                      }
                    },
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: CheckboxListTile(
                    title: const Text('Cappuccino'),
                    subtitle: const Text('€1,00'),
                    value: _selected2,
                    onChanged: (value) {
                      setState(() {
                        _selected2 = value!;
                      });
                      if (_selected2 == true) {
                        _totalPrice += 1.00;
                        ordine.add('Cappuccino €1,00');
                      } else if (_selected2 == false && _totalPrice != 0.00) {
                        _totalPrice -= 1.00;
                        ordine.removeWhere(
                            (element) => element == 'Cappuccino €1,00');
                      }
                    },
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Food',
              style: TextStyle(
                  color: Color.fromRGBO(13, 78, 161, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                SizedBox(
                  height: 50,
                  child: CheckboxListTile(
                    title: const Text('Cornetto'),
                    subtitle: const Text('€0,80'),
                    value: _selected3,
                    onChanged: (value) {
                      setState(() {
                        _selected3 = value!;
                      });
                      if (_selected3 == true) {
                        _totalPrice += 0.88;
                        ordine.add('Cornetto €0,80');
                      } else if (_selected3 == false && _totalPrice != 0.00) {
                        _totalPrice -= 0.88;
                        ordine.removeWhere(
                            (element) => element == 'Cornetto €0,80');
                      }
                    },
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: CheckboxListTile(
                    title: const Text(
                      'Brioche',
                    ),
                    subtitle: const Text('€1,00'),
                    value: _selected4,
                    onChanged: (value) {
                      setState(() {
                        _selected4 = value!;
                      });
                      if (_selected4 == true) {
                        _totalPrice += 1.00;
                        ordine.add('Brioche €1,00');
                      } else if (_selected4 == false && _totalPrice != 0.00) {
                        _totalPrice -= 1.00;
                        ordine.removeWhere(
                            (element) => element == 'Brioche €1,00');
                      }
                    },
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: CheckboxListTile(
                    title: const Text('Uova e Bacon'),
                    subtitle: const Text('€2,00'),
                    value: _selected5,
                    onChanged: (value) {
                      setState(() {
                        _selected5 = value!;
                      });
                      if (_selected5 == true) {
                        _totalPrice += 2.00;
                        ordine.add('Uova e Bacon €2,00');
                      } else if (_selected5 == false && _totalPrice != 0.00) {
                        _totalPrice -= 2.00;
                        ordine.removeWhere(
                            (element) => element == 'Uova e Bacon €2,00');
                      }
                    },
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Richieste speciali',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(13, 78, 161, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                fillColor: Colors.grey.withOpacity(0.1),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: 'Es. senza glutine, vegetariano, vegano',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  // width: 0.0 produces a thin "hairline" border
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(246, 135, 30, 75), width: 1),
                ),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: SizedBox(
          height: 100,
          child: Card(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Totale:',
                style: TextStyle(fontSize: 20),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '€${_totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _totalPrice != 0
                          ? _showMaterialDialog(size)
                          : const AlertDialog(
                              title: Text('Attenzione: '),
                              content: Text('Aggiungi qualcosa all\'ordine'),
                            );
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0)),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(13, 78, 161, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                    ),
                    child: const Text(
                      "Ordina",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ))),
    );
  }

  void _showMaterialDialog(Size size) {
    showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
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
                  SizedBox(
                    height: size.height - size.height / 2,
                    width: size.width,
                    child: ListView.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(ordine[index]),
                      ),
                      itemCount: ordine.length,
                    ),
                  ),
                  Text(
                    'Totale: €${_totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance.collection('breakfast').add({
                        'full_name':
                            FirebaseAuth.instance.currentUser!.displayName,
                        'email': FirebaseAuth.instance.currentUser!.email,
                        'time': _selectedTime.format(context),
                        'ordini': ordine.toString()
                      });
                      Navigator.pop(context);
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
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(13, 78, 161, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                    ),
                  )
                ],
              ),
            ),
          );
        });
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
              colorScheme: const ColorScheme.light(
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
}
