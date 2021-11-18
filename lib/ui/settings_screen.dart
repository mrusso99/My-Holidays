import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_holidays/ui/main_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

/// This is the private State class that goes with MainScreen.
class _SettingsScreenState extends State<SettingsScreen> {
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Holidays'),
        systemOverlayStyle:
        SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        elevation: 0,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.account_box),
              title: Text('Dark Mode'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text('Lingua'),
            ),
          ),
        ]),
            ),
        bottomNavigationBar: BottomNavigationBar(
          items: [],
        ),
    );
  }
}