// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/util/Global.dart';
import 'package:my_holidays/util/app_colors.dart';
import 'package:my_holidays/util/places.dart';
import 'package:my_holidays/widgets/date_picker_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class RoomDetails extends StatelessWidget {
  const RoomDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateRangePickerWidget rangePickerWidget = DateRangePickerWidget();
    int? numberAdult = 1;
    int? numberChild = 0;
    int hotelIndex = GlobalState.instance.get('hotelIndex');
    int roomIndex = GlobalState.instance.get('roomIndex');
    GlobalState.instance
        .set('roomPrice', places[hotelIndex]["rooms"][roomIndex]["price"]);
    var _title = Image.asset('assets/logo_200x54.png', fit: BoxFit.cover);
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
          const SizedBox(height: 20.0),
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
                      "${places[hotelIndex]["rooms"][roomIndex]["name"]}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: AppColors.primaryColor,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    size: 14,
                    color: AppColors.secondaryColor,
                  ),
                  const SizedBox(width: 3),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${places[hotelIndex]["location"]}",
                      style: TextStyle(
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
                  "${places[hotelIndex]["rooms"][roomIndex]["price"]} ??? - night",
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
                  "${places[hotelIndex]["rooms"][roomIndex]["details"]}",
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 10.0),
              rangePickerWidget,
              SizedBox(height: 20.0),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Icon(
                        Icons.emoji_people_outlined,
                        size: 30,
                        color: getThemeColor(context),
                      ),
                      SizedBox(width: 20),
                      CustomNumberPicker(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.transparent, width: 1),
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
                            SizedBox(width: 8),
                          ],
                        )),
                        customAddButton: FittedBox(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 8),
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
              SizedBox(height: 10.0),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Icon(
                        Icons.child_care_outlined,
                        size: 30,
                        color: getThemeColor(context),
                      ),
                      SizedBox(width: 20),
                      CustomNumberPicker(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.transparent, width: 1),
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
                            SizedBox(width: 8),
                          ],
                        )),
                        customAddButton: FittedBox(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 8),
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
              SizedBox(height: 20.0),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: Text(LanguageLocalizations.of(context).cancel,
                        style: TextStyle(
                          color: AppColors.white,
                        )),
                  ),
                  SizedBox(width: 80),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: getThemeButtonColor(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      if (FirebaseAuth.instance.currentUser == null) {
                        _showMaterialDialog(context);
                      } else {
                        await GlobalState.instance
                            .set('numberChild', numberChild);
                        await GlobalState.instance
                            .set('numberAdult', numberAdult);
                        await GlobalState.instance.set('roomIndex', roomIndex);
                        Navigator.pushNamed(context, 'Pay');
                      }
                    },
                    child: Text(LanguageLocalizations.of(context).book,
                        style: TextStyle(
                          color: AppColors.white,
                        )),
                  ),
                ],
              )),
              SizedBox(height: 20.0),
            ],
          ),
        ],
      ),
    );
  }

  buildSlider(int index) {
    final idx = index;
    int hotelIndex = GlobalState.instance.get('hotelIndex');
    int roomIndex = GlobalState.instance.get('roomIndex');
    Map place = places[hotelIndex]["rooms"][roomIndex];
    return Container(
      padding: const EdgeInsets.only(left: 20),
      height: 250.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: places == null ? 0 : place['img'].length, //places.lenght
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                "${place["img"][index]}",
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

  Future<int> getBalance() async {
    List<String> address = [];
    String base = 'https://10.0.2.2:4455/address/';
    address.add(base);

    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        address.add(doc["address"]);
      });
    });

    String toParse = address.join();

    final response = await http.get(Uri.parse(toParse));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final Map parsed = json.decode(response.body);
      return parsed['data']['balance'];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }
}
