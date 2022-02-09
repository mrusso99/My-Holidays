// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/ui/body_rooms.dart';
import 'package:my_holidays/util/Global.dart';
import 'package:my_holidays/util/app_colors.dart';
import 'package:my_holidays/util/places.dart';
//import 'package:my_holidays/widgets/horizontal_rooms_item.dart';
import 'package:my_holidays/widgets/search_bar.dart';
import 'package:my_holidays/widgets/vertical_rooms_item.dart';

class Rooms extends StatelessWidget {
  const Rooms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String image = "imgs/GoFelix.jpg";
    var _title = Image.asset('assets/logo_200x54.png', fit: BoxFit.cover);
    var hotelIndex = GlobalState.instance.get('hotelIndex');
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
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Text(
              '${places[hotelIndex]["name"]}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.location_on,
                      size: 14, color: AppColors.secondaryColor),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${places[hotelIndex]["location"]}",
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
              )),
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
      padding: const EdgeInsets.only(left: 10),
      child: ListView.builder(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: places == null ? 0 : places[hotIdx]["rooms"].length,
        itemBuilder: (BuildContext context, int index) {
          Map place =
              places[GlobalState.instance.get('hotelIndex')]["rooms"][index];
          //return VerticalRoomsItem(place: place);
          return BodyRooms(place: place, index: index);
        },
      ),
    );
  }
}
