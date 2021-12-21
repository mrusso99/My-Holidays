import 'package:flutter/material.dart';
import 'package:my_holidays/util/Global.dart';
import 'package:my_holidays/util/places.dart';

import '../screens/details.dart';

class VerticalPlaceItem extends StatelessWidget {
  final Map place;

  const VerticalPlaceItem({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        child: Container(
          alignment: Alignment.centerLeft,
          height: 100,
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "${place["img"]}",
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
                    const SizedBox(height: 5.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 15,
                          color: Colors.blueGrey[300],
                        ),
                        const SizedBox(width: 5),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${place["location"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.blueGrey[300],
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${place["price"]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.5,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
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

  int searchIndex(String hotelName){
    for (int i = 0; i < places.length; i++){
      if (places[i]['name'] == hotelName){
        return i;
      }
    }
    return -1;
  }
}
