import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_holidays/widgets/background_image.dart';

import 'package:my_holidays/widgets/text_input_login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Flexible(
                child: Center(
                  child: Text(
                    'MyHolidays',
                    style: GoogleFonts.josefinSans(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                    inputAction: TextInputAction.done,
                    visible: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'ForgotPassword'),
                    child: Text(
                      'Hai dimenticato la password?',
                      style: GoogleFonts.josefinSans(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                      child: Text('Login',
                          style: GoogleFonts.josefinSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            height: 1,
                          )),
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'NewAccount'),
                child: Container(
                  child: Text(
                    'Crea un nuovo account',
                    style: GoogleFonts.josefinSans(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Colors.white,
                    ),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
}
