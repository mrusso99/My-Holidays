import 'package:flutter/material.dart';

class SmartRoom extends StatefulWidget {
  const SmartRoom({Key? key}) : super(key: key);

  @override
  _SmartRoomState createState() => _SmartRoomState();
}

class _SmartRoomState extends State<SmartRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        buildBasicCard(
            'https://images.unsplash.com/photo-1552862750-746b8f6f7f25?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8bGlnaHRidWxifGVufDB8fDB8fA%3D%3D&w=1000&q=80',
            Icons.lightbulb_outline,
            'LUCI',
            '/lights'),
        buildBasicCard(
            'https://images.unsplash.com/photo-1545259741-2ea3ebf61fa3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c21hcnQlMjB0ZWNofGVufDB8fDB8fA%3D%3D&w=1000&q=80',
            Icons.device_thermostat_outlined,
            'TEMPERATURA',
            '/thermostat'),
        buildBasicCard(
            'https://www.spider-mac.com/wp-content/uploads/2020/01/hero-landing.jpeg',
            Icons.lock_outline,
            'SMART LOCK',
            '/lights'),
      ],
    ));
  }

  Widget buildBasicCard(String url, IconData icon, String title, String path) =>
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
              Column(
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 70,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )
                ],
              )
            ],
          ),
        ),
      );
}
