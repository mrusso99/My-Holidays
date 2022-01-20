// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/ui/body.dart';
import 'package:my_holidays/util/colors.dart';
import 'package:my_holidays/util/places.dart';
import 'package:my_holidays/widgets/horizontal_place_item.dart';
import 'package:my_holidays/widgets/search_bar.dart';
import 'package:my_holidays/widgets/vertical_place_item.dart';

class Travels extends StatelessWidget {
  const Travels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String image = "imgs/GoFelix.jpg";
    var _title =
        Image.asset('assets/includes_logo_200x54.png', fit: BoxFit.cover);
    return Scaffold(
      appBar: AppBar(
        title: _title,
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 20),
          //  Container(
          //    height: 150,
          //  decoration: BoxDecoration(
          //  image: DecorationImage(
          //   image: AssetImage(image),
          //   fit: BoxFit.fitWidth,
          // ),
          //R ),
          //  ),
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
          const SizedBox(height: 5),
          //  buildHorizontalList(context),
          buildVerticalList(),
          const SizedBox(height: 50),
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
