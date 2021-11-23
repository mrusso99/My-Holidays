import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../languages/languageLocalizations.dart';
import '../util/fire_auth.dart';
import '../util/validator.dart';
import '../widgets/background_image.dart';
import 'profile_page.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          _focusName.unfocus();
          _focusEmail.unfocus();
          _focusPassword.unfocus();
        },
        child: Stack(
            children: [
              BackgroundImage(),
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
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Form(
                                  key: _registerFormKey,
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        cursorColor: Colors.white,
                                        controller: _nameTextController,
                                        focusNode: _focusName,
                                        validator: (value) => Validator.validateName(
                                          name: value,
                                        ),
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.only(top: 0),
                                            child: Icon(
                                              Icons.person_outline,
                                              color: Colors.white,
                                            ),
                                          ),
                                          fillColor: Colors.grey.withOpacity(0.4),
                                          filled: true,
                                          hintText: LanguageLocalizations.of(context).username,
                                          hintStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                          enabledBorder: const OutlineInputBorder(
                                            // width: 0.0 produces a thin "hairline" border
                                            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderRadius: BorderRadius.circular(6.0),
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      TextFormField(
                                        controller: _emailTextController,
                                        focusNode: _focusEmail,
                                        validator: (value) => Validator.validateEmail(
                                          email: value,
                                        ),
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.only(top: 0),
                                            child: Icon(
                                              Icons.email_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                          fillColor: Colors.grey.withOpacity(0.4),
                                          filled: true,
                                          hintText: "Email",
                                          hintStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                          enabledBorder: const OutlineInputBorder(
                                            // width: 0.0 produces a thin "hairline" border
                                            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderRadius: BorderRadius.circular(6.0),
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      TextFormField(
                                        controller: _passwordTextController,
                                        focusNode: _focusPassword,
                                        obscureText: true,
                                        validator: (value) => Validator.validatePassword(
                                          password: value,
                                        ),
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.only(top: 0),
                                            child: Icon(
                                              Icons.lock_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                          fillColor: Colors.grey.withOpacity(0.4),
                                          filled: true,
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                          enabledBorder: const OutlineInputBorder(
                                            // width: 0.0 produces a thin "hairline" border
                                            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderRadius: BorderRadius.circular(6.0),
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      TextFormField(
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.only(top: 0),
                                            child: Icon(
                                              Icons.lock_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                          fillColor: Colors.grey.withOpacity(0.4),
                                          filled: true,
                                          hintText: "Conferma Password",
                                          hintStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                          enabledBorder: const OutlineInputBorder(
                                            // width: 0.0 produces a thin "hairline" border
                                            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderRadius: BorderRadius.circular(6.0),
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      if (_isProcessing) CircularProgressIndicator() else Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                setState(() {
                                                  _isProcessing = true;
                                                });

                                                if (_registerFormKey.currentState!
                                                    .validate()) {
                                                  User? user = await FireAuth
                                                      .registerUsingEmailPassword(
                                                    name: _nameTextController.text,
                                                    email: _emailTextController.text,
                                                    password: _passwordTextController.text,
                                                  );

                                                  setState(() {
                                                    _isProcessing = false;
                                                  });

                                                  if (user != null) {
                                                    Navigator.of(context)
                                                        .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                        builder: (context) => ProfilePage(user: user),
                                                      ),
                                                      ModalRoute.withName('/'),
                                                    );
                                                  }
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.indigo,
                                              ),
                                              child: Text(
                                                'Registra',
                                                style: GoogleFonts.josefinSans(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                  height: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
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
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            ]
        )
    );
  }
}
