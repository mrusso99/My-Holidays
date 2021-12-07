import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/background_image.dart';
import '../widgets/text_input_login.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
            ),
            title: Text(
              'Forgot Password',
              style: TextStyle(
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
                  child: const Text(
                    'Inserisci la tua email. Ti invieremo le istruzioni per reimpostare la tua password',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey.withOpacity(0.1),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintText: "Email",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      // width: 0.0 produces a thin "hairline" border
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 0.1),
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Icon(
                        Icons.mail_outline_outlined,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: size.height * 0.07,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueAccent),
                  child: TextButton(
                    child: Text('Invia',
                        style: TextStyle(
                          color: Colors.white,
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
