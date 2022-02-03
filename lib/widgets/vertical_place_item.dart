import 'package:flutter/material.dart';
import 'package:my_holidays/screens/hotel_details.dart';
import 'package:my_holidays/util/Global.dart';
import 'package:my_holidays/util/places.dart';
import 'package:my_holidays/widgets/vertical_rooms_item.dart';

import '../screens/rooms.dart';

class VerticalPlaceItem extends StatelessWidget {
  final Map place;

  const VerticalPlaceItem({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.centerLeft,
        height: 240,
        width: 240,
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "${place["img"][0]}",
                height: 180,
                width: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
      onTap: () {
        int index = searchIndex("${place["id"]}");
        GlobalState.instance.set('hotelIndex', index);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              //return const Rooms();
              return const HotelDetails();
            },
          ),
        );
      },
    );
  }

  int searchIndex(String hotelName) {
    for (int i = 0; i < places.length; i++) {
      if (places[i]['id'] == hotelName) {
        return i;
      }
    }
    return -1;
  }
}
