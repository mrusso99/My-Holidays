import 'package:flutter/material.dart';
import 'package:my_holidays/ui/forgot_password_screen.dart';
import 'package:my_holidays/ui/login_screen.dart';
import 'package:my_holidays/ui/main_screen.dart';
import 'package:my_holidays/ui/registration_screen.dart';
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
      theme: Constants.lightTheme,
      darkTheme: Constants.darkTheme,
      // standard dark theme
      themeMode: ThemeMode.system, // device controls theme
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => LoginScreen(),
        'ForgotPassword': (context) => ForgotPassword(),
        'NewAccount': (context) => RegistrationScreen(),
      },
    );
  }
}

/// This is the stateful widget that the main application instantiates.
