import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../util/fire_auth.dart';
import 'login_screen.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isSendingVerification = false;
  bool _isSigningOut = false;

  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profilo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NOME: ${_currentUser.displayName}',
              style: GoogleFonts.josefinSans(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                height: 1,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'EMAIL: ${_currentUser.email}',
              style: GoogleFonts.josefinSans(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                height: 1,
              ),
            ),
            SizedBox(height: 16.0),
            _isSendingVerification
                ? CircularProgressIndicator()
                : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () async {
                    User? user = await FireAuth.refreshUser(_currentUser);

                    if (user != null) {
                      setState(() {
                        _currentUser = user;
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            _isSigningOut
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isSigningOut = true;
                });
                await FirebaseAuth.instance.signOut();
                setState(() {
                  _isSigningOut = false;
                });
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Text('Sign out'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
