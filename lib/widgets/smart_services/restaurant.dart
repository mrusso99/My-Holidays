import 'package:flutter/material.dart';
import 'package:my_holidays/screens/travels.dart';
import 'package:my_holidays/util/app_colors.dart';
import 'package:my_holidays/util/places.dart';
import 'package:my_holidays/widgets/smart_services/ristoranti.dart';
import 'package:my_holidays/widgets/icon_badge.dart';
import 'package:my_holidays/widgets/smart_services/restaurant_item.dart';

import '../horizontal_place_item.dart';
import '../search_bar.dart';
import '../vertical_place_item.dart';

class Restaurant extends StatefulWidget {
  const Restaurant({Key? key}) : super(key: key);

  @override
  State<Restaurant> createState() => _RestaurantState();
}

/// This is the private State class that goes with MainScreen.
class _RestaurantState extends State<Restaurant> {
  @override
  Widget build(BuildContext context) {
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
          buildVerticalList(),
        ],
      ),
      persistentFooterButtons: [
        SearchBar(),
      ],
    );
  }

  buildVerticalList() {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 15),
      child: ListView.builder(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: ristoranti == null ? 0 : ristoranti.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = ristoranti[index];
          return RestaurantItem(place: place);
        },
      ),
    );
  }
}
