// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/util/places.dart';
import 'package:my_holidays/widgets/horizontal_place_item.dart';
import 'package:my_holidays/widgets/search_bar.dart';
import 'package:my_holidays/widgets/vertical_place_item.dart';

class Travels extends StatelessWidget {
  const Travels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String image = "imgs/GoFelix.jpg";
    return Scaffold(
      appBar: AppBar(
        title: Text("Gofelix"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 10),
          SearchBar(),
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
            padding: const EdgeInsets.all(20),
            child: Text(
              LanguageLocalizations.of(context).texthome,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blueGrey[300],
              ),
            ),
          ),
          const SizedBox(height: 10),
          //  buildHorizontalList(context),
          buildVerticalList(),
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
          return VerticalPlaceItem(place: place);
        },
      ),
    );
  }
}
