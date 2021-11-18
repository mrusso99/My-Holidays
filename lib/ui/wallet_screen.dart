import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

/// This is the private State class that goes with MainScreen.
class _WalletScreenState extends State<WalletScreen> {
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Text(
          'Index 2: Wallet',
          style: optionStyle,
        ),
      ),
    );
  }
}