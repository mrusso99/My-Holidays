import 'package:flutter/material.dart';
import 'package:my_holidays/util/Global.dart';
import 'package:my_holidays/util/places.dart';

import '../screens/details.dart';

class HorizontalPlaceItem extends StatelessWidget {
  final Map place;

  const HorizontalPlaceItem({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: InkWell(
        child: Container(
          alignment: Alignment.centerLeft,
          height: 200,
          width: 150,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "${place["img"][0]}",
                  height: 200,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${place["name"]}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 5.0),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${place["location"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Colors.blueGrey[300],
                  ),
                  //maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          int index = searchIndex("${place["name"]}");
          GlobalState.instance.set('hotelIndex', index);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const Details();
              },
            ),
          );
        },
      ),
    );
  }

  int searchIndex(String hotelName) {
    for (int i = 0; i < places.length; i++) {
      if (places[i]['name'] == hotelName) {
        return i;
      }
    }
    return -1;
  }
}
