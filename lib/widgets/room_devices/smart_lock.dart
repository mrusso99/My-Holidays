import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:my_holidays/util/mqtt_client.dart';

class SmartLock extends StatefulWidget {
  const SmartLock({Key? key}) : super(key: key);

  @override
  _SmartLockState createState() => _SmartLockState();
}

class _SmartLockState extends State<SmartLock> {
  late MqttClient client;
  var topic = "sensors/main-door/control";

  void _publish(String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    var data = builder.payload;
    client.subscribe(
      topic,
      MqttQos.atLeastOnce,
    );
    client.publishMessage(topic, MqttQos.atLeastOnce, data!);
  }

  bool _isOpened = false;

  void _openDoor() {
    setState(() {
      _isOpened = true;
    });

    connect().then((value) => client = value);

    if (_isOpened == true) {
      _publish('Open');
    } else {
      _publish('Closed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://www.spider-mac.com/wp-content/uploads/2020/01/hero-landing.jpeg',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.dstATop),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 135,
                    child: Icon(
                      Icons.bar_chart_rounded,
                      color: Colors.blue.shade900,
                      size: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              RawMaterialButton(
                fillColor: Colors.blue.shade900,
                onPressed: () => _openDoor(),
                elevation: 2.0,
                child: Column(
                  children: [
                    Icon(
                      _isOpened
                          ? Icons.lock_open_outlined
                          : Icons.lock_outlined,
                      size: 50.0,
                      color: Colors.orange,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'APRI',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(40.0),
                shape: CircleBorder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
