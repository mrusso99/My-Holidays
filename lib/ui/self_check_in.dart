import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_holidays/main.dart';
import 'package:my_holidays/widgets/rounded_button.dart';

class SelfCheckIn extends StatelessWidget {
  late XFile frontImage;
  late XFile backImage;
  bool _frontImageSent = false;
  bool _backImageSent = false;

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
                  customOnPressed: () async {
                    var result =
                        await Navigator.pushNamed(context, 'PickImage');
                    if (result != null) {
                      print(result);
                      frontImage = result as XFile;
                      _frontImageSent = true;
                    }
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: RoundedButton(
                    color: Colors.blueAccent,
                    text: "Retro",
                    customOnPressed: () async {
                      var result =
                          await Navigator.pushNamed(context, 'PickImage');
                      if (result != null) {
                        backImage = result as XFile;
                        _backImageSent = true;
                      }
                    },
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 130, 10, 10),
            child: RoundedButton(
              color: Colors.blueAccent,
              text: "Invia",
              customOnPressed: () {
                if (_backImageSent && _frontImageSent) {
                  List<XFile> images = [];
                  images.add(frontImage);
                  images.add(backImage);
                  Navigator.pop(context, images);
                }
              },
            ),
          )
        ],
      )),
    );
  }
}
