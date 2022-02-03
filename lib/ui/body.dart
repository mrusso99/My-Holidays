import 'package:flutter/material.dart';
import 'package:my_holidays/util/size_config.dart';
import 'favorite_item.dart';

class Body extends StatefulWidget {
  final Map place;

  const Body({Key? key, required this.place}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var startingRoomPrice = 1000000.23;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    for (var room in widget.place["rooms"]) {
      double roomPrice = double.parse(room['price']);
      if (roomPrice <= startingRoomPrice) {
        startingRoomPrice = roomPrice;
      }
    }
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FavoriteItem(
                  imagePath:
                      "${widget.place["img"][0]}", //AppAssets.whaleWhatching,
                  subtitle: "${widget.place["name"]}",
                  title: "${widget.place["location"]}",
                  category: widget.place["category"],
                  price: "$startingRoomPrice",
                  details: "${widget.place["details"]}",
                  reviews: 230,
                  rating: 4.0,
                  place: widget.place,
                ),
              ],
            )));
  }
}
