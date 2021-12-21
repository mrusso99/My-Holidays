import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';

import 'profile_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

/// This is the private State class that goes with MainScreen.
class _ProfileScreenState extends State<ProfileScreen> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

  User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            user: user,
          ),
        ),
      );
    }
    else {
      Navigator.pushNamed(context, 'Login');
    }
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
           ListTile(
                leading: Icon(Icons.account_box),
                title: Text(LanguageLocalizations.of(context).profile),
                onTap: () {
                  if (true) {
                    //todo check login
                    _initializeFirebase();
                    }
                  }
                ),
               ListTile(
                leading: const Icon(Icons.settings),
                title: Text(LanguageLocalizations.of(context).settings),
                onTap: () {
                  Navigator.pushNamed(context, 'Settings');
                },
              ),
          ListTile(
              leading: Icon(Icons.settings),
              title: Text('Self Check-in'),
              onTap: () {
                Navigator.pushNamed(context, 'Checkin');
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.bed_outlined),
              title: Text('Le mie prenotazioni'),
              onTap: () {
                Navigator.pushNamed(context, 'Reservation');
              },
            ),
          ),
        ]),
      ),
    );
  }
}
