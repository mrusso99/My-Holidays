// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/util/Global.dart';
import 'package:my_holidays/util/places.dart';
//import 'package:my_holidays/widgets/horizontal_rooms_item.dart';
import 'package:my_holidays/widgets/search_bar.dart';
import 'package:my_holidays/widgets/vertical_rooms_item.dart';

class Rooms extends StatelessWidget {
  const Rooms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String image = "imgs/GoFelix.jpg";
    int hotelIndex = GlobalState.instance.get('hotelIndex');
    var _title =
        Image.asset('assets/includes_logo_200x54.png', fit: BoxFit.cover);
    return Scaffold(
      appBar: AppBar(
        title: _title,
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 10),
          //  Container(
          //    height: 150,
          //  decoration: BoxDecoration(
          //  image: DecorationImage(
          //   image: AssetImage(image),
          //   fit: BoxFit.fitWidth,
          // ),
          //R ),
          //  ),
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
    var hotIdx = GlobalState.instance.get('hotelIndex');
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: ListView.builder(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: places == null ? 0 : places[hotIdx]["rooms"].length,
        itemBuilder: (BuildContext context, int index) {
          Map place =
              places[GlobalState.instance.get('hotelIndex')]["rooms"][index];
          return VerticalRoomsItem(place: place);
        },
      ),
    );
  }
}
