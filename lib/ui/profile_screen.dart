import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/ui/self_check_in_summary.dart';
import 'package:my_holidays/util/reservationNumber.dart';

import '../util/app_colors.dart';
import 'profile_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

/// This is the private State class that goes with MainScreen.
class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var _title = Image.asset('assets/logo_200x54.png', fit: BoxFit.cover);
    return Scaffold(
      appBar:AppBar(
        elevation: 0,
        title: _title,
        centerTitle: true,
        automaticallyImplyLeading: true,
        foregroundColor: AppColors.primaryColor,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(LanguageLocalizations.of(context).settings),
            onTap: () {
              Navigator.pushNamed(context, 'Settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.self_improvement),
            title: const Text('Self Check-in'),
            onTap: () {
              Navigator.pushNamed(context, 'Checkin');
            },
          ),
          ListTile(
            leading: const Icon(Icons.room_service),
            title: const Text('Smart Room'),
            onTap: () {
              Navigator.pushNamed(context, 'SmartRoom');
            },
          ),
          ListTile(
            leading: const Icon(Icons.room_service),
            title: const Text('Smart Services'),
            onTap: () {
              Navigator.pushNamed(context, 'SmartServices');
            },
          ),
        ]),
      ),
    );
  }
}
