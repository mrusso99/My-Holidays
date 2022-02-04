import 'package:flutter/material.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/util/app_colors.dart';

class SmartServices extends StatefulWidget {
  const SmartServices({Key? key}) : super(key: key);

  @override
  _SmartServicesState createState() => _SmartServicesState();
}

class _SmartServicesState extends State<SmartServices> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _title =
        Image.asset('assets/includes_logo_200x54.png', fit: BoxFit.cover);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: _title,
          centerTitle: true,
          automaticallyImplyLeading: true,
          foregroundColor: AppColors.primaryColor,
        ),
        body: ListView(
          children: [
            buildBasicCard(
                'assets/breakfast.png',
                Icons.coffee_outlined,
                LanguageLocalizations.of(context).breakfast,
                '/breakfast',
                size),
            buildBasicCard(
                'assets/taxi.jpeg',
                Icons.local_taxi_outlined,
                LanguageLocalizations.of(context).taxi,
                '/taxi',
                size),
            buildBasicCard(
                'assets/restaurant.jpeg',
                Icons.restaurant_outlined,
                LanguageLocalizations.of(context).restaurant,
                '/restaurant',
                size),
          ],
        ));
  }

  Widget buildBasicCard(
          String url, IconData icon, String title, String path, Size size) =>
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Ink.image(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.color),
                  image: Image.asset(url).image,
                  height: 175,
                  fit: BoxFit.cover,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, path);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 177),
                child: Container(
                  width: size.width,
                  decoration:
                      BoxDecoration(color: AppColors.white.withOpacity(0.8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: AppColors.primaryColor,
                        size: 35,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
