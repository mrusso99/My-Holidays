import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_holidays/widgets/background_image.dart';
import 'package:my_holidays/widgets/rounded_button.dart';
import 'package:my_holidays/widgets/text_input_login.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'https://wallpaperaccess.com/full/185289.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 3,
                            sigmaY: 3,
                          ),
                          child: CircleAvatar(
                            radius: size.width * 0.10,
                            backgroundColor: Colors.grey[400]!.withOpacity(0.5),
                            child: Icon(
                              Icons.person_outline,
                              color: Colors.white,
                              size: size.width * 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.06,
                      left: size.width * 0.54,
                      child: Container(
                        height: size.width * 0.10,
                        width: size.width * 0.08,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(color: Colors.white, width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Column(
                  children: [
                    TextInputField(
                      icon: Icons.person_outline,
                      hint: 'Username',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      visible: false,
                    ),
                    TextInputField(
                      icon: Icons.email_outlined,
                      hint: 'Email',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      visible: false,
                    ),
                    TextInputField(
                      icon: Icons.lock_outlined,
                      hint: 'Password',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      visible: true,
                    ),
                    TextInputField(
                      icon: Icons.lock_outlined,
                      hint: 'Conferma password',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.done,
                      visible: true,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    RoundedButton(buttonName: 'Registra'),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hai già un account?',
                          style: GoogleFonts.josefinSans(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, 'Login'),
                          child: Text(
                            'Login',
                            style: GoogleFonts.josefinSans(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
