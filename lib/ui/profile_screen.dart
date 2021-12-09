import 'package:flutter/material.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

/// This is the private State class that goes with MainScreen.
class _ProfileScreenState extends State<ProfileScreen> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Card(
            child: ListTile(
                leading: Icon(Icons.account_box),
                title: Text(LanguageLocalizations.of(context).profile),
                onTap: () {
                  if (true) {
                    //todo check login
                    Navigator.pushNamed(context, 'Login');
                  }
                }),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text(LanguageLocalizations.of(context).settings),
              onTap: () {
                Navigator.pushNamed(context, 'Settings');
              },
            ),
          ),
        ]),
      ),
    );
  }
}
