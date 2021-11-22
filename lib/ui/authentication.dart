import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebase {

  FirebaseAuth auth = FirebaseAuth.instance;

  void authFirebase(){
    auth.authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

  }

}