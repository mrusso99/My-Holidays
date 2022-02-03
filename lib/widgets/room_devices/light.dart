import 'package:flutter/material.dart';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:my_holidays/util/app_colors.dart';
import 'package:my_holidays/util/mqtt_client.dart';

class LightDevice extends StatefulWidget {
  const LightDevice({
    Key? key,
  }) : super(key: key);

  @override
  _LightDeviceState createState() => _LightDeviceState();
}

class _LightDeviceState extends State<LightDevice> {
  late MqttClient client;
  var topic = "sensors/main-light/control";

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

  bool val1 = false;
  bool val2 = false;
  bool val3 = false;

  onChangeFuntion1(bool newValue) {
    setState(() {
      val1 = newValue;
    });
    connect().then((value) => client = value);

    if (val1 == true) {
      _publish('on');
    } else {
      _publish('off');
    }
  }

  onChangeFuntion2(bool newValue) {
    setState(() {
      val1 = newValue;
    });
    connect().then((value) => client = value);

    if (val1 == true) {
      _publish('on');
    } else {
      _publish('off');
    }
  }

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              buildList(size, 'LETTO MATRIMONIALE', val1, onChangeFuntion1),
              buildList(size, 'BAGNO', val2, onChangeFuntion2),
            ],
          ),
        ));
  }

  Widget buildList(Size size, String text, bool val, Function onChange) =>
      Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        height: size.height * 0.1,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.lightbulb_outline,
              color: AppColors.primaryColor,
              size: 50,
            ),
            Text(
              text,
              style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Switch(
              activeColor: AppColors.secondaryColor,
              value: val,
              onChanged: (newValue) => onChange(newValue),
            )
          ],
        ),
      );
}
