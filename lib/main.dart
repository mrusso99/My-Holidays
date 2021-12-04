import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_holidays/ui/explore_screen.dart';
import 'package:my_holidays/ui/wallet_screen.dart';
import 'languages/languageLocalizationsDelegate.dart';
import 'ui/main_screen.dart';
import 'ui/login_screen.dart';
import 'ui/forgot_password_screen.dart';
import 'ui/registration_screen.dart';
import 'ui/settings_screen.dart';
import 'util/const.dart';


void main() => runApp(const App());

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
        'Login': (context) => LoginScreen(),
        'ForgotPassword': (context) => const ForgotPassword(),
        'NewAccount': (context) =>  RegistrationScreen(),
        'Settings': (context) => const SettingsScreen(),
        'Wallet': (context) => const WalletScreen(),
        'Explore': (context) => ExploreScreen(),
      },
    );
  }
}

/// This is the stateful widget that the main application instantiates.
