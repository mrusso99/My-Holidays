// ignore_for_file: use_key_in_widget_constructors

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_holidays/util/app_colors.dart';
import 'package:my_holidays/util/balanceCard.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_braintree/flutter_braintree.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

/// This is the private State class that goes with MainScreen.
class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    StatelessWidget balanceCard = const BalanceCard();
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              const Text(
                "My Wallet",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              balanceCard,
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Operations",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      int _currentHorizontalIntValue = 0;
                      showMaterialNumberPicker(
                        context: context,
                        title: 'Quanti Felx vuoi prelevare?',
                        maxNumber: 1000,
                        minNumber: 0,
                        selectedNumber: _currentHorizontalIntValue,
                        onChanged: (value) =>
                            setState(() => _currentHorizontalIntValue = value),
                        onConfirmed: () {
                          mint(_currentHorizontalIntValue);
                        },
                      );
                    },
                    child: const Icon(
                      Icons.add,
                      color: AppColors.white,
                      size: 30,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.all(25),
                      primary: getThemeButtonColor(context), // <-- Button color
                      onPrimary: Colors.black, // <-- Splash color
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => super.widget));
                    },
                    child: const Icon(
                      Icons.refresh,
                      color: AppColors.white,
                      size: 30,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.all(25),
                      primary: getThemeButtonColor(context), // <-- Button color
                      onPrimary: Colors.black, // <-- Splash color
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Transactions",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                        child: FutureBuilder<List<Transaction>>(
                            future: getTransactionList(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Transaction>> snapshot) {
                              List<Widget> children;
                              if (snapshot.hasData) {
                                if (snapshot.data!.isEmpty) {
                                  children = <Widget>[
                                    const Icon(
                                      Icons.sentiment_dissatisfied_outlined,
                                      color: AppColors.secondaryColor,
                                      size: 60,
                                    ),
                                    const Text(
                                      'No transaction',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: AppColors.primaryColor,
                                      ),
                                    )
                                  ];
                                } else {
                                  children = <Widget>[
                                    SizedBox(
                                      width: 340,
                                      height: 165,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (ctx, i) {
                                          return GestureDetector(
                                            onTap: () => {},
                                            child: Container(
                                              width: 160,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                child: Stack(
                                                  children: <Widget>[
                                                    Positioned(
                                                      bottom: 0,
                                                      left: 0,
                                                      right: 0,
                                                      child: Container(
                                                        height: 150,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 9.0,
                                                                vertical: 5.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              getThemeButtonColor(
                                                                  context),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topRight:
                                                                Radius.circular(
                                                                    20),
                                                            topLeft:
                                                                Radius.circular(
                                                                    20),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                                "Address: ${snapshot.data![i].address}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: getThemeTextColor(
                                                                        context))),
                                                            const Spacer(),
                                                            Text(
                                                                "Block number: ${snapshot.data![i].block_number}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: getThemeTextColor(
                                                                        context))),
                                                            const Spacer(),
                                                            Text(
                                                                "Type: ${snapshot.data![i].type}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: getThemeTextColor(
                                                                        context))),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ];
                                }
                              } else if (snapshot.hasError) {
                                // ignore: avoid_print
                                print(snapshot.error);
                                children = <Widget>[
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 60,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 16),
                                    child: Text('Non hai fatto la login'),
                                  )
                                ];
                              } else {
                                children = const <Widget>[
                                  SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 16),
                                    child: Text('Awaiting result...'),
                                  )
                                ];
                              }
                              return Center(
                                child: Column(
                                  children: children,
                                ),
                              );
                            })),
                  ]),
                ],
              ),
            ],
          )),
    )));
  }

  String? userName() {
    if (FirebaseAuth.instance.currentUser == null) {
      return 'null';
    } else {
      return FirebaseAuth.instance.currentUser!.displayName;
    }
  }

  getThemeTextColor(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (isDarkMode) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  Color getThemeButtonColor(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (!isDarkMode) {
      return AppColors.primaryColor;
    } else {
      return Colors.black;
    }
  }

  void mint(int number) async {
    List<String> address = [];
    String base = 'https://10.0.2.2:4455/mint/' + number.toString() + '/';
    print(base);
    address.add(base);

    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        address.add(doc["address"]);
      });
    });

    String toParse = address.join();

    final response = await http.get(Uri.parse(toParse));
  }

  Future<List<Transaction>> getTransactionList() async {
    List<Transaction> l = [];

    List<String> address = [];
    String base = 'https://10.0.2.2:4455/address/';
    address.add(base);

    var userEmail;
    if (FirebaseAuth.instance.currentUser != null) {
      userEmail = FirebaseAuth.instance.currentUser!.email;
      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          address.add(doc["address"]);
        });
      });

      String toParse = address.join();

      final response = await http.get(Uri.parse(toParse));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        final Map parsed = json.decode(response.body);
        List<dynamic> transactions = parsed['data']['transactions'];
        for (int i = 0; i < transactions.length; i++) {
          String type = '';
          String address = '';
          if (transactions[i]['to'] != null) {
            type = 'send';
            address = transactions[i]['to'];
          } else {
            type = 'receive';
            address = transactions[i]['from'];
          }
          String number = transactions[i]['block_number'].toString();
          String gas = transactions[i]['gas'].toString();
          String gas_price = transactions[i]['gas_price'].toString();
          String value = transactions[i]['value'].toString();
          l.add(Transaction(type, number, address, gas, gas_price, value));
        }
        return l;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load');
      }
    } else {
      throw Exception('user not connected');
    }
  }
}

class Transaction {
  late String type;
  late String block_number;
  late String address;
  late String gas;
  late String gas_price;
  late String value;

  Transaction(this.type, this.block_number, this.address, this.gas,
      this.gas_price, this.value);
}
