import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:my_holidays/util/app_colors.dart';
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
    var _title =
        Image.asset('assets/includes_logo_200x54.png', fit: BoxFit.cover);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: _title,
        centerTitle: true,
        automaticallyImplyLeading: true,
        foregroundColor: AppColors.primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RawMaterialButton(
              fillColor: AppColors.primaryColor,
              onPressed: () => _openDoor(),
              elevation: 2.0,
              child: Column(
                children: [
                  Icon(
                    _isOpened ? Icons.lock_open_outlined : Icons.lock_outlined,
                    size: 50.0,
                    color: AppColors.secondaryColor,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'APRI',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(40.0),
              shape: const CircleBorder(),
            ),
          ],
        ),
      ),
    );
  }
}
