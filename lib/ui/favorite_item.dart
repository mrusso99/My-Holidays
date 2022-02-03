import 'package:flutter/material.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/screens/hotel_details.dart';
import 'package:my_holidays/util/Global.dart';
import 'package:my_holidays/util/places.dart';
import '../util/app_colors.dart';
import 'package:my_holidays/util/size_config.dart';
import 'package:my_holidays/util/text_styles.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem(
      {Key? key,
      required this.subtitle,
      required this.title,
      required this.category,
      required this.reviews,
      required this.rating,
      required this.price,
      required this.details,
      required this.imagePath,
      required this.place})
      : super(key: key);

  final String subtitle;
  final String details;
  final String title;
  final int category;
  final String price;
  final double rating;
  final int reviews;
  final String imagePath;
  final Map place;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: getProportionateScreenHeight(290),
            padding: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: getProportionateScreenHeight(160),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      image: DecorationImage(
                          image: AssetImage(imagePath), fit: BoxFit.cover)),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(title.toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: AppColors.secondaryColor) //
                        )),
                Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10),
                    child: Text(subtitle,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColors.primaryColor))),
                Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10),
                    child: Row(
                      children: [
                        Text(
                            LanguageLocalizations.of(context).startingfrom +
                                " " +
                                LanguageLocalizations.of(context)
                                    .startPrice
                                    .replaceAll('var_price', price),
                            style: TextStyles.regular3),
                      ],
                    )),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: getProportionateScreenHeight(30),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    primary: false,
                    itemCount: category, //places.lenght
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: const Icon(
                            Icons.star,
                            size: 14,
                            color: AppColors.yellow,
                          ),
                        ),
                      );
                    },
                  ),
                )
                /*Padding(
                        padding: const EdgeInsets.only(top: 5, left: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 13,
                              color: AppColors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              size: 13,
                              color: AppColors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              size: 13,
                              color: AppColors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              size: 13,
                              color: AppColors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              size: 13,
                              color: AppColors.yellow,
                            ),
                            //Text(rating.toString(), style: TextStyles.semiBold),
                            //Text(" ($reviews)", style: TextStyles.light)
                          ],
                        ))*/
              ],
            ),
          ),
          onTap: () {
            //int index = searchIndex("${place["id"]}");
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
        ),
      ),
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
