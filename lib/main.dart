import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:my_holidays/ui/self_check_in.dart';
import 'package:my_holidays/ui/booking_details.dart';
import 'package:my_holidays/ui/reservation_screen.dart';
import 'languages/languageLocalizationsDelegate.dart';
import 'ui/login_screen.dart';
import 'ui/forgot_password_screen.dart';
import 'util/navigation_bar.dart';
import 'ui/registration_screen.dart';
import 'ui/settings_screen.dart';
import 'ui/explore_screen.dart';
import 'ui/wallet_screen.dart';
import 'theme/theme_item.dart';
import 'theme/theme_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

/// This is the main application widget.
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static const String _title = 'GoFelix';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
          builder: (context, ThemeModel themeNotifier, child) {
            return GetMaterialApp(
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
              theme: themeNotifier.isDark ? ThemeItem.darkTheme : ThemeItem.lightTheme,
              debugShowCheckedModeBanner: false,
              initialRoute: '/',
              routes: {
                '/': (context) => const NavigationBar(),
                'Login': (context) => const LoginScreen(),
                'ForgotPassword': (context) => const ForgotPassword(),
                'NewAccount': (context) => const RegistrationScreen(),
                'Settings': (context) => const SettingsScreen(),
                'Wallet': (context) =>  WalletScreen(),
                'Explore': (context) => const ExploreScreen(),
                'Checkin': (context) => SelfCheckIn(),
                'Reservation': (context) => ReservationScreen(),
                'Booking_Details': (context) => BookingDetailsScreen(),
              },
            );
          }
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
