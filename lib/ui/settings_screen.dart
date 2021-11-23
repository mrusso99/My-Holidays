import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

bool _theme = false;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

/// This is the private State class that goes with MainScreen.
class _SettingsScreenState extends State<SettingsScreen> {
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onThemeChanged(bool value) {
    setState(() {
      _theme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Holidays'),
        systemOverlayStyle:
        SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 88),
        children: <Widget>[
          SwitchListTile(
            title: const Text(
              'Tema Scuro',
            ),
            value: _theme,
            onChanged: _onThemeChanged,
          ),
        ],
      ),
    );
  }
}