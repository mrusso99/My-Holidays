import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
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
    var _title = Image.asset('assets/logo_200x54.png', fit: BoxFit.cover);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: _title,
        centerTitle: true,
        automaticallyImplyLeading: true,
        foregroundColor: AppColors.primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 40),
              child: Text(LanguageLocalizations.of(context).frontbacktitle,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: RoundedButton(
                  color: AppColors.secondaryColor,
                  text: LanguageLocalizations.of(context).front,
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
                    color: AppColors.secondaryColor,
                    text: LanguageLocalizations.of(context).back,
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
              text: LanguageLocalizations.of(context).send,
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
