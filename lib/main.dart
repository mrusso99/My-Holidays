import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_holidays/ui/main_screen.dart';
import 'package:my_holidays/ui/settings_screen.dart';
import 'package:my_holidays/util/const.dart';

void main() => runApp(const App());

/// This is the main application widget.
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static const String _title = 'My Holidays';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      //home: const MainScreen(),
      theme: Constants.lightTheme,
      darkTheme: Constants.darkTheme,
      // standard dark theme
      themeMode: ThemeMode.system, // device controls theme
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => const MainScreen(),
        '/settings' : (context) => const SettingsScreen(),
      },
    );
  }
}

/// This is the stateful widget that the main application instantiates.
