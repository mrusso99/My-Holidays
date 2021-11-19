import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.buttonName,
  }) : super(key: key);

  final String buttonName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.07,
      width: size.width * 0.7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.indigo),
      child: TextButton(
        child: Text(buttonName,
            style: GoogleFonts.josefinSans(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              height: 1,
            )),
        onPressed: () =>
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
      ),
    );
  }
}
