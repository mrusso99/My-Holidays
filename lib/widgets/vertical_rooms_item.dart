import 'package:flutter/material.dart';
import 'package:my_holidays/util/Global.dart';
import 'package:my_holidays/util/places.dart';

import '../screens/details.dart';

class VerticalRoomsItem extends StatelessWidget {
  final Map place;

  const VerticalRoomsItem({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.centerLeft,
        height: 100,
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "${place["img"][0]}",
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              alignment: Alignment.centerLeft,
              height: 80,
              width: MediaQuery.of(context).size.width - 130,
              child: ListView(
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${place["name"]}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  /*const SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${place["price"]}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.5,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              " €",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.5,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                            ),
                          ]
                        ),
                      ],
                    ),*/
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        int index = searchIndex("${place["id"]}");
        GlobalState.instance
            .set('hotelIndex', GlobalState.instance.get('hotelIndex'));
        GlobalState.instance.set('roomIndex', index);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const Details();
            },
          ),
        );
      },
    );
  }

  int searchIndex(String roomName) {
    for (int i = 0; i < places.length; i++) {
      if (places[GlobalState.instance.get('hotelIndex')]["rooms"][i]['id'] ==
          roomName) {
        return i;
      }
    }
    return -1;
  }
}
