import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_holidays/util/app_colors.dart';
import 'package:my_holidays/widgets/rounded_button.dart';

// ignore: must_be_immutable
class SelfCheckIn extends StatelessWidget {
  late XFile frontImage;
  late XFile backImage;
  bool _frontImageSent = false;
  bool _backImageSent = false;

  SelfCheckIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
              padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 40),
              child: Text('Scatta il fronte ed il retro del tuo documento',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: RoundedButton(
                  color: AppColors.primaryColor,
                  text: "Fronte",
                  customOnPressed: () async {
                    var result =
                        await Navigator.pushNamed(context, 'PickImage');
                    if (result != null) {
                      // ignore: avoid_print
                      print(result);
                      frontImage = result as XFile;
                      _frontImageSent = true;
                    }
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: RoundedButton(
                    color: AppColors.primaryColor,
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
            padding: const EdgeInsets.fromLTRB(10, 130, 10, 10),
            child: RoundedButton(
              color: AppColors.primaryColor,
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
      ),
    );
  }
}
