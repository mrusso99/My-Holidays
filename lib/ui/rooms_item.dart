import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/screens/details.dart';
import 'package:my_holidays/screens/hotel_details.dart';
import 'package:my_holidays/screens/room_details.dart';
import 'package:my_holidays/util/Global.dart';
import 'package:my_holidays/util/places.dart';
import '../util/app_colors.dart';
import 'package:my_holidays/util/size_config.dart';
import 'package:my_holidays/util/text_styles.dart';

class RoomsItem extends StatefulWidget {
  const RoomsItem(
      {Key? key,
      required this.subtitle,
      required this.details,
      required this.title,
      required this.hours,
      required this.price,
      required this.rating,
      required this.reviews,
      required this.imagePath,
      required this.place,
      required this.roomIndex})
      : super(key: key);

  final String subtitle;
  final String details;
  final String title;
  final String hours;
  final String price;
  final double rating;
  final int reviews;
  final String imagePath;
  final Map place;
  final int roomIndex;

  @override
  _RoomItem createState() => _RoomItem();
}

class _RoomItem extends State<RoomsItem> {
  bool _isFavorited = true;
  int _favoriteCount = 41;
  late String firstHalf;

  bool flag = true;

  bool checkOverflow = false;

  @override
  void initState() {
    super.initState();

    firstHalf = widget.subtitle;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //var screen_width = getProportionateScreenWidth(size.width * 0.25);
    checkOverflow = MediaQuery.of(context).size.width <
        calcTextSize(
            firstHalf,
            const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15.0,
            )).width;
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              //height: getProportionateScreenHeight(250) + 50,
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: getProportionateScreenHeight(140),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        image: DecorationImage(
                            image: AssetImage(widget.imagePath),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, left: 5),
                      child: Text(widget.title, //
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: AppColors.primaryColor),
                          textAlign: TextAlign.left)),
                  /*Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10),
                    child: Text(subtitle,
                        style: TextStyles.heading.copyWith(fontSize: 14)),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 5, right: 10),
                    child: !checkOverflow
                        ? InkWell(
                            child: Text(
                              firstHalf,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15.0,
                              ),
                            ),
                          )
                        : flag
                            ? InkWell(
                                child: Text(
                                  firstHalf,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15.0,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    flag = !flag;
                                  });
                                },
                              )
                            : Builder(builder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      firstHalf,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15.0,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    InkWell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            LanguageLocalizations.of(context)
                                                .lessDetails,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 15.0,
                                                color: AppColors.primaryColor),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        setState(() {
                                          flag = !flag;
                                        });
                                      },
                                    ),
                                  ],
                                );
                              }),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 5, left: 5),
                      child: Row(
                        children: [
                          Text(
                              LanguageLocalizations.of(context)
                                      .startPrice
                                      .replaceAll('var_price', widget.price) +
                                  " ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: AppColors.secondaryColor)),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 5, left: 5),
                      child: Row(
                        children: const [
                          CircleAvatar(
                            radius: 11,
                            child: CircleAvatar(
                              backgroundColor: AppColors.white,
                              radius: 10,
                              child: Icon(
                                Icons.person,
                                size: 15,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 11,
                            child: CircleAvatar(
                              backgroundColor: AppColors.white,
                              radius: 10,
                              child: Icon(
                                Icons.person,
                                size: 15,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
            onTap: () {
              //int index = searchIndex("${place["id"]}");
              int hotelIndex = GlobalState.instance.get('hotelIndex');
              int index = searchRoomIndex(hotelIndex, "${widget.place["id"]}");
              GlobalState.instance.set('roomIndex', index);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    //return const Rooms();
                    return const RoomDetails();
                  },
                ),
              );
            },
          ),
        ));
  }

  int searchRoomIndex(int hotelIndex, String roomName) {
    for (int i = 0; i < places[hotelIndex]['rooms'].length; i++) {
      if (places[hotelIndex]['rooms'][i]['id'] == roomName) {
        return i;
      }
    }
    return -1;
  }

  // ���
}
