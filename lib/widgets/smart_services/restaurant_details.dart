// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/util/Global.dart';
import 'package:my_holidays/util/app_colors.dart';
import 'package:my_holidays/util/places.dart';
import 'package:my_holidays/widgets/smart_services/ristoranti.dart';
import 'package:my_holidays/widgets/date_picker_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantDetails extends StatelessWidget {
  const RestaurantDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimeOfDay _selectedTime = const TimeOfDay(hour: 12, minute: 00);
    int? numberAdult = 1;
    int? numberChild = 0;
    int hotelIndex = GlobalState.instance.get('hotelIndex');
    var _title =
        Image.asset('assets/includes_logo_200x54.png', fit: BoxFit.cover);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: _title,
        centerTitle: true,
        automaticallyImplyLeading: true,
        foregroundColor: AppColors.primaryColor,
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 10.0),
          buildSlider(hotelIndex),
          const SizedBox(height: 20),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${ristoranti[hotelIndex]["name"]}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: AppColors.primaryColor,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  /*IconButton(
                    icon: const Icon(
                      Icons.bookmark,
                    ),
                    onPressed: () {},
                  ),*/
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.location_on,
                    size: 14,
                    color: AppColors.secondaryColor,
                  ),
                  const SizedBox(width: 3),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${ristoranti[hotelIndex]["location"]}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${ristoranti[hotelIndex]["price"]}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${ristoranti[hotelIndex]["details"]}",
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'A che ora vuoi \nmangiare? :',
                    style: TextStyle(
                        color: Color.fromRGBO(13, 78, 161, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /*ElevatedButton(
                        onPressed: () {
                          _selectTime(context);
                        },
                        child: const Text("Seleziona l'orario"),
                      ),*/
                      ElevatedButton(
                        onPressed: () {
                          _selectTime(context);
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0)),
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.secondaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                        ),
                        child: const Text(
                          "Seleziona l'orario",
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Text(
                        'Ore: ${_selectedTime.format(context)}',
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Icon(
                        Icons.emoji_people_outlined,
                        size: 30,
                        color: getThemeColor(context),
                      ),
                      const SizedBox(width: 20),
                      CustomNumberPicker(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.transparent, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        initialValue: 1,
                        maxValue: 10,
                        minValue: 0,
                        step: 1,
                        customMinusButton: FittedBox(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.remove,
                              color: getThemeTextColor(context),
                              size: 15,
                            ),
                            const SizedBox(width: 8),
                          ],
                        )),
                        customAddButton: FittedBox(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 8),
                            Icon(
                              Icons.add,
                              color: getThemeTextColor(context),
                              size: 15,
                            ),
                          ],
                        )),
                        onValue: (value) {
                          numberAdult = value as int?;
                        },
                      ),
                    ],
                  )),
              const SizedBox(height: 10.0),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Icon(
                        Icons.child_care_outlined,
                        size: 30,
                        color: getThemeColor(context),
                      ),
                      const SizedBox(width: 20),
                      CustomNumberPicker(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.transparent, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        initialValue: 0,
                        maxValue: 10,
                        minValue: 0,
                        step: 1,
                        customMinusButton: FittedBox(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.remove,
                              color: getThemeTextColor(context),
                              size: 15,
                            ),
                            const SizedBox(width: 8),
                          ],
                        )),
                        customAddButton: FittedBox(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 8),
                            Icon(
                              Icons.add,
                              color: getThemeTextColor(context),
                              size: 15,
                            ),
                          ],
                        )),
                        onValue: (value) {
                          numberChild = value as int?;
                        },
                      ),
                    ],
                  )),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: getThemeButtonColor(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      LanguageLocalizations.of(context).cancel,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 80),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: getThemeButtonColor(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      if (FirebaseAuth.instance.currentUser == null) {
                        _showMaterialDialog(context);
                      } else {
                        FirebaseFirestore.instance
                            .collection('restaurant')
                            .add({
                              'restaurant_name':
                                  '${ristoranti[hotelIndex]["name"]}',
                              'full_name': FirebaseAuth
                                  .instance.currentUser!.displayName,
                              'email': FirebaseAuth.instance.currentUser!.email,
                              'numberAdult': numberAdult,
                              'numberChild': numberChild,
                              'time': _selectedTime.format(context),
                            })
                            .then((value) =>
                                _showMaterialDialogReservation(context))
                            .catchError((error) =>
                                print("Failed to add reservation: $error"));
                      }
                    },
                    child: Text(
                      LanguageLocalizations.of(context).book,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ],
      ),
    );
  }

  _selectTime(BuildContext context) async {
    bool _isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (_isDarkMode) {
      final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 12, minute: 00),
        initialEntryMode: TimePickerEntryMode.input,
        confirmText: 'Conferma',
        cancelText: 'Indietro',
        builder: (context, child) => Theme(
            data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
              primary: Color.fromRGBO(246, 135, 30, 75),
              onSurface: Colors.white,
            )),
            child: child!),
      );
    } else if (!_isDarkMode) {
      final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 12, minute: 00),
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
    }
  }

  buildSlider(int index) {
    final idx = index;
    return Container(
      padding: const EdgeInsets.only(left: 20),
      height: 250.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: ristoranti == null ? 0 : ristoranti.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = ristoranti[idx];

          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                "${place["img"][0]}",
                height: 250.0,
                width: MediaQuery.of(context).size.width - 40.0,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Color getThemeColor(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (isDarkMode) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  Color getThemeButtonColor(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (!isDarkMode) {
      return AppColors.primaryColor;
    } else {
      return Colors.black;
    }
  }

  getThemeTextColor(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (isDarkMode) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  void _showMaterialDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(LanguageLocalizations.of(context).attention),
            content: Text(LanguageLocalizations.of(context).textattention),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _dismissDialog(context);
                    Navigator.pushNamed(context, 'Explore');
                  },
                  child: Text(
                    LanguageLocalizations.of(context).delete,
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
                      height: 1,
                    ),
                  )),
              TextButton(
                onPressed: () {
                  _dismissDialog(context);
                  Navigator.pushNamed(context, 'Login');
                },
                child: Text(
                  LanguageLocalizations.of(context).signin,
                  style: const TextStyle(
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

  _dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }

  void _showMaterialDialogReservation(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Prenotazione Effettuata'),
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
