import 'package:flutter/material.dart';
import 'package:my_holidays/util/balanceCard.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);


  @override
  State<WalletScreen> createState() => _WalletScreenState();

}

/// This is the private State class that goes with MainScreen.
class _WalletScreenState extends State<WalletScreen> {

  Widget _appBar() {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 40.0,
          backgroundImage: NetworkImage("https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
        ),
        SizedBox(width: 15),
        Text(' Janth'),
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
        MediaQuery.of(context).platformBrightness == Brightness.dark;
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
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: box,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      )
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
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 35),
                      _appBar(),
                      SizedBox(
                        height: 40,
                      ),
                      Text("My wallet"),
                      SizedBox(
                        height: 20,
                      ),
                      BalanceCard(),
                      SizedBox(
                        height: 50,
                      ),
                      Text("Operations"),
                      SizedBox(
                        height: 10,
                      ),
                      _operationsWidget(),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  )),
            )));
  }

}

