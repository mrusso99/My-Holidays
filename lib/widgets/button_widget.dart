import 'package:flutter/material.dart';
import 'package:my_holidays/util/app_colors.dart';

class ButtonHeaderWidget extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback onClicked;

  const ButtonHeaderWidget({
    Key? key,
    required this.title,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => HeaderWidget(
    title: title,
    child: ButtonWidget(
      text: text,
      onClicked: onClicked,
    ),
  );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  Color getThemeColor(BuildContext context){
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (!isDarkMode){
      return AppColors.secondaryColor;
    } else {
      return Colors.black;
    }
  }

  Color getThemeTextColor(BuildContext context){
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (isDarkMode){
      return Colors.white;
    } else {
      return AppColors.white;
    }
  }


  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(40),
      primary: getThemeColor(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    child: FittedBox(
      child: Row (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.date_range_outlined, color: getThemeTextColor(context)),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(fontSize: 20, color: getThemeTextColor(context)),
          ),
        ],
      )
    ),
    onPressed: onClicked,
  );
}

class HeaderWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const HeaderWidget({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const SizedBox(height: 10),
      Text(
        title,
        style: TextStyle(
          color: getThemeTextColor(context),
          fontSize: 20,
        ),
      ),
      const SizedBox(height: 10),
      child,
    ],
  );

  Color getThemeColor(BuildContext context){
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (!isDarkMode){
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  getThemeTextColor(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (isDarkMode){
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

}

