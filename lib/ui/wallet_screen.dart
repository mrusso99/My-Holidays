// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_holidays/util/balanceCard.dart';

class WalletScreen extends StatefulWidget {

  @override
  _WalletScreenState createState() => _WalletScreenState();

}

/// This is the private State class that goes with MainScreen.
class _WalletScreenState extends State<WalletScreen> {

  Widget _appBar() {
    String? userString = userName();
    return Row(
      children: <Widget>[
        const CircleAvatar(
          radius: 40.0,
          backgroundImage: NetworkImage("https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
        ),
        const SizedBox(width: 15),
        Text(userString!,
        ),
        const Expanded(
          child: SizedBox(),
        ),
        Icon(
          Icons.short_text,
          color: Theme.of(context).iconTheme.color,
        )
      ],
    );
  }

  Widget _operationsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _icon(Icons.transfer_within_a_station, "Transfer"),
        _icon(Icons.phone, "Airtime"),
        _icon(Icons.payment, "Pay Bills"),
        _icon(Icons.code, "Qr Pay"),
      ],
    );
  }

  Widget _icon(IconData icon, String text) {
    bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark;
    Color box;
    if (isDarkMode) {
      box = Colors.black;
    } else {
      box = Colors.white;
    }
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/transfer');
          },
          child: Container(
            height: 80,
            width: 80,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: box,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: const <BoxShadow>[
                  BoxShadow()
                ]),
            child: Icon(icon),
          ),
        ),
        Text(text),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 35),
                      _appBar(),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text("My wallet"),
                      const SizedBox(
                        height: 20,
                      ),
                      const BalanceCard(),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text("Operations"),
                      const SizedBox(
                        height: 10,
                      ),
                      _operationsWidget(),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  )),
            )
        )
    );
  }

  String? userName (){

    if(FirebaseAuth.instance.currentUser == null){
      return 'null';
    }else{
      return FirebaseAuth.instance.currentUser!.displayName;
    }
  }


}

