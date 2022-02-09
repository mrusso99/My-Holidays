import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/ui/self_check_in.dart';
import 'package:my_holidays/util/app_colors.dart';
import 'package:my_holidays/widgets/rounded_button.dart';

class PickImage extends StatelessWidget {
  const PickImage({Key? key}) : super(key: key);

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
                child: Text(LanguageLocalizations.of(context).chooseimgtitle,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor))),
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: RoundedButton(
                    color: AppColors.secondaryColor,
                    text: LanguageLocalizations.of(context).gallery,
                    customOnPressed: () async {
                      pickimageFromGallery(context);
                    })),
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: RoundedButton(
                    color: AppColors.secondaryColor,
                    text: LanguageLocalizations.of(context).photo,
                    customOnPressed: () async {
                      snapImage(context);
                    })),
          ],
        ));
  }

  void pickimageFromGallery(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(image.path);
      Navigator.pop(context, image);
    }
  }

  void snapImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      print(image.path);
      Navigator.pop(context, image);
    }
  }
}
