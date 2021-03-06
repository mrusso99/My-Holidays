import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:my_holidays/screens/rooms.dart';
import 'package:my_holidays/ui/payReservation.dart';
import 'package:my_holidays/ui/pick_image.dart';
import 'package:my_holidays/ui/profile_screen.dart';
import 'package:my_holidays/ui/self_check_in_summary.dart';
import 'package:my_holidays/ui/smart_services.dart';
import 'package:my_holidays/widgets/room_devices/smart_lock.dart';
import 'package:my_holidays/widgets/smart_services/breakfast.dart';
import 'package:my_holidays/widgets/smart_services/restaurant.dart';
import 'package:my_holidays/widgets/smart_services/taxi.dart';
import 'package:provider/provider.dart';
import 'package:my_holidays/ui/self_check_in.dart';
import 'package:my_holidays/ui/booking_details.dart';
import 'package:my_holidays/ui/reservation_screen.dart';
import 'languages/languageLocalizationsDelegate.dart';
import 'ui/login_screen.dart';
import 'ui/forgot_password_screen.dart';
import 'ui/smart_room_screen.dart';
import 'util/nav_bar.dart';
import 'ui/registration_screen.dart';
import 'ui/settings_screen.dart';
import 'ui/wallet_screen.dart';
import 'theme/theme_item.dart';
import 'theme/theme_model.dart';
import 'widgets/room_devices/air_conditioner.dart';
import 'widgets/room_devices/light.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}

/// This is the main application widget.
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static const String _title = 'GoFelix';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

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
            '/': (context) => const NavBar(),
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
            '/smart_lock': (context) => const SmartLock(),
            'SmartServices': (context) => const SmartServices(),
            '/breakfast': (context) => const BreakFast(),
            '/restaurant': (context) => const Restaurant(),
            '/taxi': (context) => const TaxiService(),
            'PickImage': (context) => PickImage(),
            SelfCheckInSummary.routeName: (context) =>
                const SelfCheckInSummary(),
            BookingDetailsScreen.routeName: (context) =>
                const BookingDetailsScreen(),
            'Rooms': (context) => const Rooms(),
            'Pay': (context) => const Payment()
          },
        );
      }),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
