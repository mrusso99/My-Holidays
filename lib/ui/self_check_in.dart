import 'package:flutter/material.dart';
import 'package:my_holidays/widgets/rounded_button.dart';

class SelfCheckIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 40),
              child: Text('Scatta il fronte ed il retro del tuo documento',
                  style: const TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: RoundedButton(
                  color: Colors.blueAccent,
                  text: "Fronte",
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: RoundedButton(
                    color: Colors.blueAccent,
                    text: "Retro",
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 130, 10, 10),
            child: RoundedButton(color: Colors.blueAccent, text: "Invia"),
          )
        ],
      )),
    );
  }
}
