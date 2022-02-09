import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback customOnPressed;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.color,
    required this.customOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: NewRoundedButton());
  }

  Widget NewRoundedButton() {
    return ElevatedButton(
      onPressed: customOnPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0)),
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        )),
      ),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}
