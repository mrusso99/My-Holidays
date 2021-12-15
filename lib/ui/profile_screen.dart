import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/ui/profile_page.dart';

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
      body:Column(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                leading: const Icon(Icons.account_box),
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
              ]
      ),
    );
  }
}
