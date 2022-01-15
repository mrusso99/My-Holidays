// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/util/Global.dart';
import 'package:my_holidays/util/places.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<Payment> {
  String originalPrice = '100';
  String price = '100';
  int usedFelix = 0;
  String from = GlobalState.instance.get('dateFrom');
  String until = GlobalState.instance.get('dateUntil');
  int numberAdult = GlobalState.instance.get('numberAdult');
  int numberChild = GlobalState.instance.get('numberChild');
  @override
  Widget build(BuildContext context) {
    int hotelIndex = GlobalState.instance.get('hotelIndex');
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 10.0),
          buildSlider(),
          const SizedBox(height: 20),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              const SizedBox(height: 6),
              Text(
                "Il tuo soggiorno",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
                maxLines: 2,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Color(0xFFfae3e2).withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ]),
                child: Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 25, right: 30, top: 10, bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Hotel",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF3a3a3b),
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.left,
                            ),
                            Row(
                                children: <Widget>[
                                  Text(
                                    "${places[hotelIndex]["name"]}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ]
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Date",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF3a3a3b),
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.left,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  from,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  " - ",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  until,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Person",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF3a3a3b),
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.left,
                            ),
                            Row(
                                children: <Widget>[
                                  Text(
                                    numberAdult.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                  Icon(
                                    Icons.emoji_people_outlined,
                                    size: 18,
                                    color: getThemeColor(context),
                                  ),
                                  Text(
                                    " +  ",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    numberChild.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                  Icon(
                                    Icons.child_care_outlined,
                                    size: 18,
                                    color: getThemeColor(context),
                                  ),
                                ]
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Price",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF3a3a3b),
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.left,
                            ),
                            Row(
                                children: <Widget>[
                                  Text(
                                    price,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "€",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ]
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Total FELX",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF3a3a3b),
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.left,
                            ),
                            Row(
                                children: <Widget>[
                                  FutureBuilder<String>(
                                    future: getBalance(),
                                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                      List<Widget> children;
                                      if (snapshot.hasData) {
                                        String? balance = snapshot.data;
                                        children = <Widget>[
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              balance!,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xFF3a3a3b),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ];
                                      } else if (snapshot.hasError) {
                                        children = <Widget>[
                                          Text('Error',
                                            style: TextStyle(
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ];
                                      } else {
                                        children = <Widget>[
                                          SizedBox(
                                            child: CircularProgressIndicator(
                                              color: getThemeTextColor(context),
                                            ),
                                            height: 25.0,
                                            width: 25.0,
                                          ),
                                        ];
                                      }
                                      return Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: children,
                                        ),
                                      );
                                    },
                                  ),
                                ]
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Felix to use",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF3a3a3b),
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.left,
                            ),
                            FutureBuilder<String>(
                              future: getBalance(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                List<Widget> children;
                                if (snapshot.hasData) {
                                  String? balance = snapshot.data;
                                  int balanceConverted = int.parse(balance!);
                                  if (balanceConverted >= 12 && balanceConverted <= (12 * int.parse(price))){
                                    children = <Widget>[
                                      Align(
                                        alignment: Alignment.center,
                                        child: CustomNumberPicker(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(color: Colors.transparent, width: 1),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          valueTextStyle: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xFF3a3a3b),
                                              fontWeight: FontWeight.w400
                                          ),
                                          initialValue: 0,
                                          maxValue: balanceConverted,
                                          minValue: 0,
                                          step: 12,
                                          customMinusButton: FittedBox(
                                              child: Row (
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.remove, color: getThemeTextColor(context), size: 15,),
                                                  SizedBox(width: 8),
                                                ],
                                              )
                                          ),
                                          customAddButton: FittedBox(
                                              child: Row (
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(width: 8),
                                                  Icon(Icons.add, color: getThemeTextColor(context), size: 15,),
                                                ],
                                              )
                                          ),
                                          onValue: (value) {
                                            usedFelix = (value as int?)!;
                                            print(usedFelix);
                                            updatePrice(usedFelix);
                                          },
                                        ),
                                      ),
                                    ];
                                  } else if(balanceConverted < 12){
                                    children = <Widget>[
                                      Text('Non hai abbastanza felix da convertire',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ];
                                  } else {
                                    children = <Widget>[
                                      Align(
                                        alignment: Alignment.center,
                                        child: CustomNumberPicker(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(color: Colors.transparent, width: 1),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          valueTextStyle: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          initialValue: 0,
                                          maxValue: (12 * int.parse(price)),
                                          minValue: 0,
                                          step: 12,
                                          customMinusButton: FittedBox(
                                              child: Row (
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.remove, color: getThemeTextColor(context), size: 15,),
                                                  SizedBox(width: 8),
                                                ],
                                              )
                                          ),
                                          customAddButton: FittedBox(
                                              child: Row (
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(width: 8),
                                                  Icon(Icons.add, color: getThemeTextColor(context), size: 15,),
                                                ],
                                              )
                                          ),
                                          onValue: (value) {
                                            usedFelix = (value as int?)!;
                                            updatePrice(usedFelix);
                                          },
                                        ),
                                      ),
                                    ];
                                  }
                                } else if (snapshot.hasError) {
                                  children = <Widget>[
                                    Text('Error',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ];
                                } else {
                                  children = <Widget>[
                                    SizedBox(
                                      child: CircularProgressIndicator(
                                        color: getThemeTextColor(context),
                                      ),
                                      height: 25.0,
                                      width: 25.0,
                                    ),
                                  ];
                                }
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: children,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Total",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF3a3a3b),
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.left,
                            ),
                            Row(
                                children: <Widget>[
                                  Text(
                                    price,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "€",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    " +  ",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    usedFelix.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "FELX",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ]
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(340, 40),
                          primary: getThemeButtonColor(context),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () async {
                          if (FirebaseAuth.instance.currentUser == null) {
                            _showMaterialDialog(context);
                          } else {
                            _showMaterialDialogPayment(context);
                          }
                        },
                        child: Text(
                            LanguageLocalizations
                                .of(context)
                                .book,
                            style: TextStyle(
                              color: getThemeTextColor(context),
                            )
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildSlider() {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      height: 250.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: places == null ? 0 : places.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = places[index];

          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                "${place["img"]}",
                height: 250.0,
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 40.0,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Color getThemeColor(BuildContext context) {
    bool isDarkMode = Theme
        .of(context)
        .brightness == Brightness.dark;

    if (isDarkMode) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  Color getThemeButtonColor(BuildContext context) {
    bool isDarkMode = Theme
        .of(context)
        .brightness == Brightness.dark;

    if (!isDarkMode) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  getThemeTextColor(BuildContext context) {
    bool isDarkMode = Theme
        .of(context)
        .brightness == Brightness.dark;
    if (isDarkMode) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  void _showMaterialDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(LanguageLocalizations
                .of(context)
                .attention),
            content: Text(LanguageLocalizations
                .of(context)
                .textattention),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _dismissDialog(context);
                    Navigator.pushNamed(context, 'Explore');
                  },
                  child: Text(LanguageLocalizations
                      .of(context)
                      .delete,
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
                      height: 1,
                    ),
                  )
              ),
              TextButton(
                onPressed: () {
                  _dismissDialog(context);
                  Navigator.pushNamed(context, 'Login');
                },
                child: Text(
                  LanguageLocalizations
                      .of(context)
                      .signin,
                  style: const TextStyle(
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

  _dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }


  void _showMaterialDialogPayment(BuildContext context) {
    String first = 'Il costo della transazione è di \n';
    String second = " €";
    String third = " +  ";
    String fourth = usedFelix.toString();
    String fifth = " FELX";
    String finalString = first + price + second + third + fourth + fifth;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Transazione in corso'),
            content: Text(finalString),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _dismissDialog(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancella',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 20,
                    height: 1,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  String result = await payable(usedFelix, price);
                  if (result == 'error'){
                    _dismissDialog(context);
                    _showMaterialDialogPaymentError(context);
                    //_dismissDialog(context);
                  } else {
                    String transaction = await sendFELX(usedFelix);
                    if (transaction == 'ok'){
                      _showMaterialDialogPayOk(context);
                    } else {
                      _dismissDialog(context);
                      _showMaterialDialogPaymentError(context);
                    }
                  }
                },
                child: Text(
                  'Ok',
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


  Future<String> getBalance() async {
    List<String> address = [];
    String base = 'http://10.0.2.2:4455/address/';
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


    final response = await http
        .get(Uri.parse(toParse));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final Map parsed = json.decode(response.body);
      return parsed['data']['balance'].toString();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }


  Future<String> payable (int usedFelix, String price) async {
    String balance = '';

    List<String> address = [];
    String base = 'http://10.0.2.2:4455/address/';
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


    final response = await http
        .get(Uri.parse(toParse));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final Map parsed = json.decode(response.body);
      balance = parsed['data']['balance'].toString();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }


    int difference = int.parse(balance) - usedFelix;

    if (difference < 0) {
      return 'error';
    } else {
      const String tokenizationKey = 'sandbox_s9cbnb2j_b3dnpv9x5q7qc7f9';
      var request = BraintreeDropInRequest(
        tokenizationKey: tokenizationKey,
        collectDeviceData: true,
        googlePaymentRequest: BraintreeGooglePaymentRequest(
          totalPrice: '4.20',
          currencyCode: 'USD',
          billingAddressRequired: false,
        ),
        cardEnabled: true,
      );
      final result = await BraintreeDropIn.start(request);
      print(result);
      if (result != null) {
        return 'ok';
      } else {
        return 'error';
      }
    }

  }

  void _showMaterialDialogPaymentError(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Transazione non effettuata'),
            content: Icon(Icons.sentiment_dissatisfied_outlined, size: 80, color: getThemeTextColor(context),),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _dismissDialog(context);
                  Navigator.pushNamed(context, '/');
                },
                child: Text(
                  'Ok',
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

  void _showMaterialDialogPayOk(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Transazione effettuata'),
            content: SizedBox(
              height: 110,
              child: Column(
                children: <Widget>[
                  Text('Prenotazione effettuata con successo \n'),
                  Icon(
                    Icons.check, size: 50, color: getThemeTextColor(context),
                  ),
                ],
              ),
            ) ,
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  _dismissDialog(context);
                  int hotelIndex = GlobalState.instance.get('hotelIndex');
                  double tokenToMint = (int.parse(price)*20)/100;
                  int finalToken = tokenToMint.toInt() * 12;
                  mint(finalToken);
                  FirebaseFirestore.instance.collection('reservation').add({
                    'hotel_name': '${places[hotelIndex]["name"]}',
                    'full_name': FirebaseAuth.instance.currentUser!.displayName,
                    'email': FirebaseAuth.instance.currentUser!.email,
                    'numberAdult': GlobalState.instance.get('numberAdult'),
                    'numberChild': GlobalState.instance.get('numberChild'),
                    'from': GlobalState.instance.get('dateFrom'),
                    'until': GlobalState.instance.get('dateUntil'),
                  }).then((value) => _showMaterialDialogEarnedFELX(context, finalToken))
                      .catchError((error) => print(error));
                  Navigator.pushNamed(context, '/');
                },
                child: Text(
                  'Ok',
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

  Future<String> sendFELX(int price) async {
    List<String> address = [];
    String base = 'http://10.0.2.2:4455/send/';
    address.add(base);

    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["address"]);
        address.add(doc["address"]);
      });
    });

    address.add('/');
    address.add(price.toString());
    address.add('/');

    int hotelIndex = GlobalState.instance.get('hotelIndex');

    await FirebaseFirestore.instance
        .collection('users')
        .where('user_name', isEqualTo: places[hotelIndex]["name"])
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["address"]);
        address.add(doc["address"]);
      });
    });

    String toParse = address.join();

    print(toParse);

    final response = await http
        .get(Uri.parse(toParse));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return 'ok';
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }

  }
  

  void updatePrice(int used){
    setState(() {
      double convertedPrice = int.parse(originalPrice) - (used/12);
      String updatedPrice = convertedPrice.toInt().toString();
      price = updatedPrice;
    });
  }

  void mint (int number) async {

    List<String> address = [];
    String base = 'http://10.0.2.2:4455/mint/' + number.toString() + '/';
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


    final response = await http
        .get(Uri.parse(toParse));

  }

  void _showMaterialDialogEarnedFELX(BuildContext context, int earned) {
    String first = 'Hai guadagnato ';
    String second = earned.toString();
    String third = ' FELX';
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text((first + second + third)),
            content: Icon(Icons.sentiment_satisfied_outlined, size: 80, color: getThemeTextColor(context),),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _dismissDialog(context);
                  Navigator.pushNamed(context, '/');
                },
                child: Text(
                  'Ok',
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

}

