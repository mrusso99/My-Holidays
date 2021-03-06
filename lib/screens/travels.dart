// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/ui/body.dart';
import 'package:my_holidays/util/colors.dart';
import 'package:my_holidays/util/places.dart';

class Travels extends StatelessWidget {
  const Travels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _title = Image.asset('assets/logo_200x54.png', fit: BoxFit.cover);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: _title,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: <Widget>[
          //const SizedBox(height: 0),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              LanguageLocalizations.of(context).textSelected,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: primaryColor,
              ),
            ),
          ),
          //const SizedBox(height: 5),
          //  buildHorizontalList(context),
          buildVerticalList(),
          //const SizedBox(height: 25),
        ],
      ),
    );
  }

  /*buildHorizontalList(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5),
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: places == null ? 0 : places.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = places.reversed.toList()[index];
          return HorizontalPlaceItem(place: place);
        },
      ),
    );
  }*/

  buildVerticalList() {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: ListView.builder(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: places == null ? 0 : places.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = places[index];
          return Body(place: place);
        },
      ),
    );
  }
}
