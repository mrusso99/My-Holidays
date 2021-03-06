import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_holidays/main.dart';
import 'package:my_holidays/ui/reservation_screen.dart';
import 'package:my_holidays/util/app_colors.dart';
import '../languages/languageLocalizations.dart';
import '../ui/home_screen.dart';
import '../ui/wallet_screen.dart';

import 'package:my_holidays/languages/languageLocalizations.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

/// This is the private State class that goes with MainScreen.
class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const Card(
      child: HomeScreen(),
    ),
    Card(
      child: WalletScreen(),
    ),
    const Card(
      child: ReservationScreen(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex != 0) {
        if (FirebaseAuth.instance.currentUser == null) {
          _showMaterialDialog();
        }
      } else {}
    });
  }

  void setTabIndex(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeFlutterFire();
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color selectedItemColor;
    Color unselectedItemColor;
    if (isDarkMode) {
      selectedItemColor = AppColors.primaryColor;
      unselectedItemColor = Colors.white;
    } else {
      selectedItemColor = AppColors.primaryColor;
      unselectedItemColor = Colors.black;
    }
    return Scaffold(
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          /*BottomNavigationBarItem(
            icon: const Icon(Icons.explore),
            label: LanguageLocalizations.of(context).explore,
          ),*/
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
          return Scaffold(
            body: AlertDialog(
              title: Text(LanguageLocalizations.of(context).attention),
              content: Text(LanguageLocalizations.of(context).textattention),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      _dismissDialog();
                      _onItemTapped(0);
                      //Navigator.pushNamed(context, 'Explore');
                    },
                    child: Text(
                      LanguageLocalizations.of(context).delete,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 20,
                        height: 1,
                      ),
                    )),
                TextButton(
                  onPressed: () {
                    _dismissDialog();
                    Navigator.pushNamed(context, 'Login');
                  },
                  child: Text(
                    LanguageLocalizations.of(context).signin,
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 20,
                      height: 1,
                    ),
                  ),
                )
              ],
            ),
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
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails

    }
  }
}
