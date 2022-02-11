import 'package:flutter/material.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/util/app_colors.dart';

class SmartRoom extends StatefulWidget {
  const SmartRoom({Key? key}) : super(key: key);

  @override
  _SmartRoomState createState() => _SmartRoomState();
}

class _SmartRoomState extends State<SmartRoom> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _title = Image.asset('assets/logo_200x54.png', fit: BoxFit.cover);
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
                'https://www.spider-mac.com/wp-content/uploads/2020/01/hero-landing.jpeg',
                Icons.lock_outline,
                LanguageLocalizations.of(context).smart_lock,
                '/smart_lock',
                size),
            buildBasicCard(
                'https://images.unsplash.com/photo-1552862750-746b8f6f7f25?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8bGlnaHRidWxifGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                Icons.lightbulb_outline,
                LanguageLocalizations.of(context).lights,
                '/lights',
                size),
            buildBasicCard(
                'https://images.unsplash.com/photo-1545259741-2ea3ebf61fa3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c21hcnQlMjB0ZWNofGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                Icons.device_thermostat_outlined,
                LanguageLocalizations.of(context).temperature,
                '/thermostat',
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
                  image: NetworkImage(url),
                  height: 180,
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
                      BoxDecoration(color: AppColors.white.withOpacity(0.5)),
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
                          fontSize: 25,
                        ),
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
