import 'package:flutter/material.dart';
import 'package:my_holidays/screens/details.dart';
import 'package:my_holidays/util/Global.dart';
import 'package:my_holidays/util/places.dart';
import 'package:my_holidays/widgets/smart_services/ristoranti.dart';
import 'package:my_holidays/widgets/smart_services/restaurant.dart';
import 'package:my_holidays/widgets/smart_services/restaurant_details.dart';

class RestaurantItem extends StatelessWidget {
  final Map place;

  const RestaurantItem({Key? key, required this.place}) : super(key: key);

 /* @override
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
                "${place["img"]}",
                height: 90,
                width: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              alignment: Alignment.centerLeft,
              height: 100,
              width: MediaQuery.of(context).size.width - 110,
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
              return const RestaurantDetails();
            },
          ),
        );
      },
    );
  }

  int searchIndex(String hotelName){
    for (int i = 0; i < ristoranti.length; i++){
      if (ristoranti[i]['name'] == hotelName){
        return i;
      }
    }
    return -1;
  }*/

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: InkWell(
        child: Container(
          alignment: Alignment.centerLeft,
          height: 250,
         // width: 150,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset("${place["img"]}",
                 height: 150,
                  fit: BoxFit.fitWidth,
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
                return const RestaurantDetails();
              },
            ),
          );
        },
      ),
    );
  }

  int searchIndex(String hotelName){
    for (int i = 0; i < ristoranti.length; i++){
      if (ristoranti[i]['name'] == hotelName){
        return i;
      }
    }
    return -1;
  }
}
