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
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FavoriteItem(
                  imagePath:
                      "${widget.place["img"]}", //AppAssets.whaleWhatching,
                  subtitle: "${widget.place["name"]}",
                  title: 'Whale Watching Tour',
                  hours: '4',
                  price: '89',
                  details: "${widget.place["location"]}",
                  reviews: 230,
                  rating: 4.0,
                  place: widget.place,
                ),
              ],
            )));
  }
}
