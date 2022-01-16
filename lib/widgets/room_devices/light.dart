import 'package:flutter/material.dart';

import 'package:mqtt_client/mqtt_client.dart';
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1552862750-746b8f6f7f25?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8bGlnaHRidWxifGVufDB8fDB8fA%3D%3D&w=1000&q=80'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.dstATop),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  const RotatedBox(
                    quarterTurns: 135,
                    child: Icon(
                      Icons.bar_chart_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView(
                  children: [
                    buildList(
                        size, 'LETTO MATRIMONIALE', val1, onChangeFuntion1),
                    const SizedBox(
                      height: 10,
                    ),
                    /*  buildList(size, 'LAMPADA A DX', val2, onChangeFuntion2),
                    const SizedBox(
                      height: 10,
                    ),
                    buildList(size, 'LAMPADA A SX', val3, onChangeFuntion3),*/
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
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
              color: Colors.white,
              size: 55,
            ),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Switch(
              activeColor: Colors.white,
              value: val,
              onChanged: (newValue) => onChange(newValue),
            )
          ],
        ),
      );
}
