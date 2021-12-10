import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/theme/theme_model.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

/// This is the private State class that goes with MainScreen.
class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('GoFelix'),
              systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
              elevation: 0,
            ),
            body: ListView(
              padding: const EdgeInsets.only(bottom: 88),
              children: <Widget>[
                SwitchListTile(
                    title: Text(
                      LanguageLocalizations.of(context).darktheme,
                    ),
                    value: themeNotifier.isDark,
                    onChanged: (value) {
                      themeNotifier.isDark
                          ? themeNotifier.isDark = false
                          : themeNotifier.isDark = true;
                    })
              ],
            ),
          );
        }
        );
  }
}