import 'package:flutter/material.dart';
import 'package:my_holidays/widgets/background_image.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:my_holidays/widgets/text_input_login.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'https://wallpaperaccess.com/full/185289.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
            ),
            title: Text(
              'Forgot Password',
              style: GoogleFonts.josefinSans(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Container(
                  width: size.width * 0.7,
                  child: Text(
                    'Inserisci la tua email. Ti invieremo le istruzioni per reimpostare la tua password',
                    style: GoogleFonts.josefinSans(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextInputField(
                  icon: Icons.email_outlined,
                  hint: 'Email',
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.done,
                  visible: false,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: size.height * 0.07,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.indigo),
                  child: TextButton(
                    child: Text('Invia',
                        style: GoogleFonts.josefinSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          height: 1,
                        )),
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
