import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:my_holidays/util/const.dart';

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
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Explore',
      style: optionStyle,
    ),
    Text(
      'Index 3: Wallet',
      style: optionStyle,
    ),
    Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Card(
        child: ListTile(
          leading: Icon(Icons.settings),
          title: Text('Impostazioni App'),
        ),
      ),
    ]),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    Color selectedItemColor;
    Color unselectedItemColor;
    if(isDarkMode){
      selectedItemColor = Colors.lightBlue;
      unselectedItemColor = Colors.white;
    }else {
      selectedItemColor = Colors.lightBlue;
      unselectedItemColor = Colors.black;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Holidays'),
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        elevation: 0,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_rounded),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
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
}
