import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../languages/languageLocalizations.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'wallet_screen.dart';
import 'explore_screen.dart';

import 'package:my_holidays/languages/languageLocalizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

/// This is the private State class that goes with MainScreen.
class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Card(
      child: HomeScreen(),
    ),
    Card(
      child: ExploreScreen(),
    ),
    Card(
      child: WalletScreen(),
    ),
    Card(child: ProfileScreen()),
  ];

  void _onItemTapped(int index) {
    setState((){
      _selectedIndex = index;
      if(_selectedIndex == 2){
        if(FirebaseAuth.instance.currentUser == null){
          _showMaterialDialog();
        }
      }else {

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeFlutterFire();
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    Color selectedItemColor;
    Color unselectedItemColor;
    if (isDarkMode) {
      selectedItemColor = Colors.lightBlue;
      unselectedItemColor = Colors.white;
    } else {
      selectedItemColor = Colors.lightBlue;
      unselectedItemColor = Colors.black;
    }
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.explore),
            label: LanguageLocalizations.of(context).explore,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_balance_wallet_rounded),
            label: LanguageLocalizations.of(context).wallet,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle_rounded),
            label: LanguageLocalizations.of(context).profile,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        selectedItemColor: selectedItemColor,
        unselectedItemColor: unselectedItemColor,
      ),
    );
  }

  void _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Attenzione'),
            content: Text('Devi prima accedere'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _dismissDialog();
                    _onItemTapped(0);
                    //Navigator.pushNamed(context, 'Explore');
                  },
                  child: Text('Annulla',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
                      height: 1,
                    ),
                  )
              ),
              TextButton(
                onPressed: () {
                  _dismissDialog();
                  Navigator.pushNamed(context, 'Login');
                },
                child: Text(
                    'Accedi',
          style: TextStyle(
          color: Colors.blueAccent,
          fontSize: 20,
          height: 1,
          ),
                ),
              )
            ],
          );
        });
  }

  _dismissDialog() {
    Navigator.pop(context);
  }

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails

    }
  }

}
