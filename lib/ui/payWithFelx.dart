// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/util/Global.dart';
import 'package:my_holidays/util/places.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);


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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${places[hotelIndex]["name"]}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    size: 14,
                    color: Colors.blueGrey[300],
                  ),
                  const SizedBox(width: 3),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${places[hotelIndex]["location"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.blueGrey[300],
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: <Widget>[
                  const SizedBox(width: 50),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Price",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(width: 105),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "${places[hotelIndex]["price"]} FELX",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Row(
                children: <Widget>[
                  const SizedBox(width: 50),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Balance",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(width: 85),
                  FutureBuilder<String>(
                    future: getBalance(),
                    builder: (BuildContext context,
                        AsyncSnapshot<String> snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        String? balance = snapshot.data;
                        children = <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              balance!,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: getThemeTextColor(context)),
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
                          CircularProgressIndicator(
                            color: getThemeTextColor(context),
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
                  Text(
                    ' FELX',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: getThemeTextColor(context)),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Row(
                children: <Widget>[
                  const SizedBox(width: 50),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Points",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(width: 100),
                  FutureBuilder<String>(
                    future: getPoints(),
                    builder: (BuildContext context,
                        AsyncSnapshot<String> snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        String? points = snapshot.data;
                        children = <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              points!,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: getThemeTextColor(context)),
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
                          CircularProgressIndicator(
                            color: getThemeTextColor(context),
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


              SizedBox(height: 20.0),
              Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: getThemeButtonColor(context),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                        child: Text(
                            LanguageLocalizations
                                .of(context)
                                .cancel,
                            style: TextStyle(
                              color: getThemeTextColor(context),

                            )
                        ),
                      ),
                      SizedBox(width: 80),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: getThemeButtonColor(context),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () async {
                          if (FirebaseAuth.instance.currentUser == null) {
                            _showMaterialDialog(context);
                          } else {
                            print('clicked');
                            _showMaterialDialogPayment(context, int.parse(places[hotelIndex]["price"]));
                            /*
                            FirebaseFirestore.instance.collection('reservation').add({
                              'hotel_name': '${places[hotelIndex]["name"]}',
                              'full_name': FirebaseAuth.instance.currentUser!.displayName,
                              'email': FirebaseAuth.instance.currentUser!.email,
                              'numberAdult': numberAdult,
                              'numberChild': numberChild,
                              'from': GlobalState.instance.get('dateFrom'),
                              'until': GlobalState.instance.get('dateUntil'),
                            }).then((value) => _showMaterialDialogReservation(context))
                            .catchError((error) => print("Failed to add reservation: $error"));*/

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
              SizedBox(height: 20.0),
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


  void _showMaterialDialogPayment(BuildContext context, int price) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Transazione in corso'),
            content: Text(
                'I tuoi punti verranno convertiti in FELX (Ogni 10 punti 1 FELX)'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _dismissDialog(context);
                  Navigator.pushNamed(context, '/');
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
                  int hotelIndex = GlobalState.instance.get('hotelIndex');
                  String result = await payable(int.parse(places[hotelIndex]["price"]));
                  if (result == 'error'){
                    _showMaterialDialogPaymentError(context);
                    //_dismissDialog(context);
                  } else {
                    String transaction = await sendFELX(int.parse(places[hotelIndex]["price"]));
                    if (transaction == 'ok'){
                      _showMaterialDialogPayOk(context);
                    } else {
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

  Future<String> getPoints() async {
    int points = 0;

    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
        points = data['points'];
      });
    });

    return points.toString();
  }

  Future<String> payable (int price) async {
    String balance = '';
    int points = 0;

    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
        points = data['points'];
      });
    });

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

    int conversion = (points / 10).floor();

    int total = int.parse(balance) + conversion;
    print(total);

    if (total < price) {
      return 'error';
    } else {
      return 'ok';
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
            content: Icon(Icons.check, size: 80, color: getThemeTextColor(context),),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  _dismissDialog(context);
                  int hotelIndex = GlobalState.instance.get('hotelIndex');
                  FirebaseFirestore.instance.collection('reservation').add({
                    'hotel_name': '${places[hotelIndex]["name"]}',
                    'full_name': FirebaseAuth.instance.currentUser!.displayName,
                    'email': FirebaseAuth.instance.currentUser!.email,
                    'numberAdult': GlobalState.instance.get('numberAdult'),
                    'numberChild': GlobalState.instance.get('numberChild'),
                    'from': GlobalState.instance.get('dateFrom'),
                    'until': GlobalState.instance.get('dateUntil'),
                  }).then((value) => _showMaterialDialogReservation(context))
                      .catchError((error) => print("Failed to add reservation: $error"));
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

  void _showMaterialDialogReservation(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Prenotazione Effettuata'),
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
