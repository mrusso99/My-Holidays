import 'package:flutter/material.dart';
import 'package:my_holidays/ui/rooms_item.dart';
import 'package:my_holidays/util/size_config.dart';

class BodyRooms extends StatefulWidget {
  final Map place;
  final int index;

  const BodyRooms({Key? key, required this.place, required this.index})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<BodyRooms> {
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
                RoomsItem(
                    imagePath:
                        "${widget.place["img"]}", //AppAssets.whaleWhatching,
                    subtitle:
                        "${widget.place["details"]}".substring(0, 50) + "...",
                    title: "${widget.place["name"]}",
                    hours: '4',
                    price: "${widget.place["price"]}",
                    details: " ",
                    reviews: 230,
                    rating: 4.0,
                    place: widget.place,
                    roomIndex: widget.index),
              ],
            )));
  }
}
