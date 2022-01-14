import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:my_holidays/ui/payReservation.dart';
import 'package:my_holidays/ui/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:my_holidays/ui/self_check_in.dart';
import 'package:my_holidays/ui/booking_details.dart';
import 'package:my_holidays/ui/reservation_screen.dart';
import 'languages/languageLocalizationsDelegate.dart';
import 'ui/login_screen.dart';
import 'ui/forgot_password_screen.dart';
import 'ui/smart_room_screen.dart';
import 'util/navigation.dart';
import 'ui/registration_screen.dart';
import 'ui/settings_screen.dart';
import 'ui/wallet_screen.dart';
import 'theme/theme_item.dart';
import 'theme/theme_model.dart';
import 'widgets/room_devices/air_conditioner.dart';
import 'widgets/room_devices/light.dart';

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
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    toolbarHeight:
    10;
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
          theme:
              themeNotifier.isDark ? ThemeItem.darkTheme : ThemeItem.lightTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => const Navigation(),
            'Login': (context) => const LoginScreen(),
            'ForgotPassword': (context) => const ForgotPassword(),
            'NewAccount': (context) => const RegistrationScreen(),
            'Settings': (context) => const SettingsScreen(),
            'Wallet': (context) => WalletScreen(),
            'Checkin': (context) => SelfCheckIn(),
            'Reservation': (context) => const ReservationScreen(),
            'Booking_Details': (context) => const BookingDetailsScreen(),
            'Profile': (context) => const ProfileScreen(),
            'SmartRoom': (context) => const SmartRoom(),
            '/lights': (context) => const LightDevice(),
            '/thermostat': (context) => const AirConditioner(),
            'Pay': (context) => Payment(),
          },
        );
      }),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
