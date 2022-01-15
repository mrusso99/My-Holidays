import 'package:flutter/material.dart';

class SmartServices extends StatefulWidget {
  const SmartServices({Key? key}) : super(key: key);

  @override
  _SmartServicesState createState() => _SmartServicesState();
}

class _SmartServicesState extends State<SmartServices> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: ListView(
      children: [
        buildBasicCard(
            'https://static.stacker.com/s3fs-public/styles/sar_screen_maximum_large/s3/2020-07/croppedUntitleddesign20200717T040046THQ4345.png',
            Icons.coffee_outlined,
            'COLAZIONE',
            '/breakfast',
            size),
        buildBasicCard(
            'https://nccadrianogiuriola.it/wp-content/uploads/2018/11/ncc-adriano-1.jpg',
            Icons.local_taxi_outlined,
            'TAXI',
            '/taxi',
            size),
        buildBasicCard(
            'https://www.periodicodaily.com/wp-content/uploads/2021/03/Home-restaurant.jpg',
            Icons.restaurant_outlined,
            'RISTORANTE',
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
              Ink.image(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.color),
                image: NetworkImage(url),
                height: 240,
                fit: BoxFit.cover,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, path);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 177),
                child: Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(246, 135, 30, 75)),
                  child: Column(
                    children: [
                      Icon(
                        icon,
                        color: const Color.fromRGBO(13, 78, 161, 1),
                        size: 35,
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                            color: Color.fromRGBO(13, 78, 161, 1),
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
