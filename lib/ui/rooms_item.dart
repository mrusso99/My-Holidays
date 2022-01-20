import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_holidays/screens/details.dart';
import 'package:my_holidays/screens/hotel_details.dart';
import 'package:my_holidays/screens/room_details.dart';
import 'package:my_holidays/util/Global.dart';
import '../util/app_colors.dart';
import 'package:my_holidays/util/size_config.dart';
import 'package:my_holidays/util/text_styles.dart';

class RoomsItem extends StatelessWidget {
  const RoomsItem(
      {Key? key,
      required this.subtitle,
      required this.title,
      required this.hours,
      required this.reviews,
      required this.rating,
      required this.price,
      required this.details,
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
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: getProportionateScreenHeight(250),
            padding: EdgeInsets.only(bottom: 10),
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
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      image: DecorationImage(
                          image: AssetImage(imagePath), fit: BoxFit.cover)),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(title.toUpperCase(), //
                        style: TextStyles.regular4)),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10),
                  child: Text(subtitle,
                      style: TextStyles.heading.copyWith(fontSize: 14)),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10),
                    child: Row(
                      children: [
                        Text("\$$price" " per person ",
                            style: TextStyles.regular3),
                        Container(
                          height: 3,
                          width: 3,
                          decoration: BoxDecoration(
                              color: AppColors.black, shape: BoxShape.circle),
                        ),
                        Text(" $hours" " max people ",
                            style: TextStyles.regular3),
                        Container(
                          height: 3,
                          width: 3,
                          decoration: BoxDecoration(
                              color: AppColors.black, shape: BoxShape.circle),
                        ),
                        Text(" $details.",
                            maxLines: 3, style: TextStyles.regular3),
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 13,
                          color: AppColors.primaryColor,
                        ),
                        Text(rating.toString(), style: TextStyles.semiBold),
                        Text(" ($reviews)", style: TextStyles.light)
                      ],
                    ))
              ],
            ),
          ),
          onTap: () {
            //int index = searchIndex("${place["id"]}");
            int index = searchIndex("${place["id"]}");
            GlobalState.instance.set('hotelIndex', index);
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
        ));
  }

  int searchIndex(String hotelName) {
    for (int i = 0; i < place.length; i++) {
      if (place['id'] == hotelName) {
        return i;
      }
    }
    return -1;
  }
}
