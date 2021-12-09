import 'package:flutter/material.dart';
import 'package:my_holidays/util/places.dart';
import 'package:my_holidays/widgets/horizontal_place_item.dart';
import 'package:my_holidays/widgets/search_bar.dart';
import 'package:my_holidays/widgets/vertical_place_item.dart';

class Travels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          buildHorizontalList(context),
          const SizedBox(width: 25),
          buildVerticalList(),
        ],
      ),
      persistentFooterButtons: [
        SearchBar(),
      ],
    );
  }

  buildHorizontalList(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, top: 5),
      height: 250.0,
      width: MediaQuery.of(context).size.width,
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
  }

  buildVerticalList() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
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
