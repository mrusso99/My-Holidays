import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_holidays/ui/self_check_in.dart';
import 'package:my_holidays/util/app_colors.dart';
import 'package:my_holidays/widgets/rounded_button.dart';

class PickImage extends StatelessWidget {
  const PickImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
            padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 40),
            child: Text('Scegli da dove vuoi prendere l\'immagine',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ))),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: RoundedButton(
                color: AppColors.primaryColor,
                text: "Galleria",
                customOnPressed: () async {
                  pickimageFromGallery(context);
                })),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: RoundedButton(
                color: AppColors.primaryColor,
                text: "Fotocamera",
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
