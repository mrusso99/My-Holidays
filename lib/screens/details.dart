import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/util/places.dart';
import 'package:my_holidays/widgets/date_picker_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Details extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    DateRangePickerWidget rangePickerWidget = DateRangePickerWidget();
    int? numberAdult = 0;
    int? numberChild = 0;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10.0),
          buildSlider(),
          SizedBox(height: 20),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${places[0]["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    size: 14,
                    color: Colors.blueGrey[300],
                  ),
                  SizedBox(width: 3),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${places[0]["location"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.blueGrey[300],
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${places[0]["price"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 40),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${places[0]["details"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 10.0),
              rangePickerWidget,
              SizedBox(height: 20.0),
              Container(
                alignment: Alignment.centerLeft,
                child: Row (
                  children: [
                    Icon(
                      Icons.emoji_people_outlined,
                      size: 30,
                      color: getThemeColor(context),
                    ),
                    SizedBox(width: 20),
                    CustomNumberPicker(
                      initialValue: 0,
                      maxValue: 10,
                      minValue: 0,
                      step: 1,
                      onValue: (value) {
                        numberAdult = value as int?;
                        print(value.toString());
                      },
                    )
                  ],
                )
              ),
              SizedBox(height: 10.0),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Row (
                    children: [
                      Icon(
                        Icons.child_care_outlined,
                        size: 30,
                        color: getThemeColor(context),
                      ),
                      SizedBox(width: 20),
                      CustomNumberPicker(
                        initialValue: 0,
                        maxValue: 10,
                        minValue: 0,
                        step: 1,
                        onValue: (value) {
                          numberChild = value as int?;
                          print(value.toString());
                        },
                      ),
                    ],
                  )
              ),
              SizedBox(height: 20.0),
              Container(
                  child: Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: getThemeButtonColor(context),
                        ),
                        onPressed: () {},
                        child: Text(
                            LanguageLocalizations.of(context).cancel,
                            style: TextStyle(
                              color: getThemeTextColor(context),
                            )
                          ),
                      ),
                      SizedBox(width: 80),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: getThemeButtonColor(context),
                        ),
                        onPressed: () {
                          if(FirebaseAuth.instance.currentUser == null){
                            _showMaterialDialog(context);
                          } else {
                            FirebaseFirestore.instance.collection('reservation').add({
                              'full_name': FirebaseAuth.instance.currentUser!.displayName,
                              'email': FirebaseAuth.instance.currentUser!.email,
                              'numberAdult': numberAdult,
                              'numberChild': numberChild,
                              'from': rangePickerWidget.getFrom(),
                              'until': ,
                            }).then((value) => print('Reservation Added'))
                            .catchError((error) => print("Failed to add reservation: $error"));
                          }
                        },
                        child: Text(
                            LanguageLocalizations.of(context).book,
                            style: TextStyle(
                              color: getThemeTextColor(context),
                            )
                        ),
                      ),

                    ],
                  )
              ),
              SizedBox(height: 20.0),
            ],
            ),
        ],
      ),
    );
  }

  buildSlider() {
    return Container(
      padding: EdgeInsets.only(left: 20),
      height: 250.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: places == null ? 0 : places.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = places[index];

          return Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                "${place["img"]}",
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

  Color getThemeColor(BuildContext context){
    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    if (isDarkMode){
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  Color getThemeButtonColor(BuildContext context){
    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    if (!isDarkMode){
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  getThemeTextColor(BuildContext context) {
    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    if (isDarkMode){
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
            title: Text('Attenzione'),
            content: Text('Devi prima accedere'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _dismissDialog(context);
                    Navigator.pushNamed(context, 'Explore');
                  },
                  child: Text('Annulla',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
                      height: 1,
                    ),
                  )
              ),
              TextButton(
                onPressed: () {
                  _dismissDialog(context);
                  Navigator.pushNamed(context, 'Login');
                },
                child: Text(
                  'Accedi',
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

  _dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }
  
}
