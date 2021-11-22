import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_holidays/ui/forgot_password_screen.dart';
import 'package:my_holidays/ui/login_screen.dart';
import 'package:my_holidays/ui/main_screen.dart';
import 'package:my_holidays/ui/registration_screen.dart';
import 'package:my_holidays/ui/settings_screen.dart';
import 'package:my_holidays/util/const.dart';

import 'languages/languageLocalizationsDelegate.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

/// This is the main application widget.
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static const String _title = 'My Holidays';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      localizationsDelegates: const [
        DemoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('it', ''),
      ],
      theme: Constants.lightTheme,
      darkTheme: Constants.darkTheme,
      // standard dark theme
      themeMode: ThemeMode.system, // device controls theme
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        'Login': (context) => const LoginScreen(),
        'ForgotPassword': (context) => const ForgotPassword(),
        'NewAccount': (context) => const RegistrationScreen(),
        'Settings': (context) => const SettingsScreen(),
      },
    );
  }
}

/// This is the stateful widget that the main application instantiates.
