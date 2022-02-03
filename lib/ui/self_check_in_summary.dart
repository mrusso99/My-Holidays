import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/ui/reservation_screen.dart';
import 'package:my_holidays/util/documents.dart';
import 'package:my_holidays/util/reservationNumber.dart';
import 'package:my_holidays/widgets/rounded_button.dart';
import 'package:http/http.dart' as http;

class SelfCheckInSummary extends StatelessWidget {
  const SelfCheckInSummary({Key? key}) : super(key: key);

  static const routeName = '/selfCheckInSummary';

  @override
  Widget build(BuildContext context) {
    final reservation =
        ModalRoute.of(context)!.settings.arguments as Reservation;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: FutureBuilder<String>(
              future: getGuestNumber(reservation),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    children = <Widget>[
                      const Icon(
                        Icons.sentiment_dissatisfied_outlined,
                        color: Colors.red,
                        size: 60,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: const Text('No reservation'),
                      )
                    ];
                  } else {
                    int guestNumber = int.parse(snapshot.data.toString());
                    List<Documents> documents = [];
                    List<TextEditingController> nameController = [];
                    List<TextEditingController> surnameController = [];
                    for (int i = 0; i < guestNumber; i++) {
                      nameController.add(TextEditingController());
                      surnameController.add(TextEditingController());
                    }
                    children = <Widget>[
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      for (int i = 1; i <= guestNumber; i++)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                                child: TextField(
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.withOpacity(0.1),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          const BorderSide(color: Colors.grey)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent)),
                                  labelText:
                                      LanguageLocalizations.of(context).name),
                              controller: nameController.elementAt(i - 1),
                            )),
                            const Padding(padding: EdgeInsets.all(15)),
                            Flexible(
                                child: TextField(
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.withOpacity(0.1),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  labelText: LanguageLocalizations.of(context)
                                      .surname),
                              controller: surnameController.elementAt(i - 1),
                            )),
                            const Padding(padding: EdgeInsets.all(15)),
                            RoundedButton(
                                color: Colors.blueAccent,
                                text: "Carica",
                                customOnPressed: () async {
                                  var result = await Navigator.pushNamed(
                                      context, "Checkin");
                                  if (result != null) {
                                    List<XFile> temp = result as List<XFile>;
                                    print(nameController.elementAt(i - 1).text);
                                    print(surnameController
                                        .elementAt(i - 1)
                                        .text);
                                    documents.add(Documents(
                                        temp.elementAt(0),
                                        temp.elementAt(1),
                                        nameController.elementAt(i - 1).text,
                                        surnameController
                                            .elementAt(i - 1)
                                            .text));
                                  }
                                }),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                          ],
                        ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RoundedButton(
                              text: "Carica",
                              color: Colors.blueAccent,
                              customOnPressed: () {
                                for (int i = 1; i <= guestNumber; i++) {
                                  uploadImageToFirebase(
                                      context,
                                      documents.elementAt(i - 1).front.path,
                                      reservation,
                                      documents.elementAt(i - 1).name,
                                      documents.elementAt(i - 1).surname,
                                      "front");
                                  uploadImageToFirebase(
                                      context,
                                      documents.elementAt(i - 1).back.path,
                                      reservation,
                                      documents.elementAt(i - 1).name,
                                      documents.elementAt(i - 1).surname,
                                      "back");
                                }
                                Navigator.pop(context, '');
                              })
                        ],
                      )
                    ];
                  }
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  children = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: const Text('Non hai fatto la login'),
                    )
                  ];
                } else {
                  children = const <Widget>[
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        color: Colors.blue,
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
    );
  }

  Future<String> getGuestNumber(Reservation reservation) async {
    String nAdult = reservation.numberAdult;
    String nChild = reservation.numberChild;
    print(nAdult);
    print(nChild);
    int value = (int.parse(nAdult)) + (int.parse(nChild));
    print(value);
    String finalValue = value.toString();
    return finalValue;
  }

  Future<void> uploadImageToFirebase(
      BuildContext context,
      String imagePath,
      Reservation reservation,
      String name,
      String surname,
      String frontOrBack) async {
    File image = File(imagePath);
    FirebaseStorage storage = FirebaseStorage.instance;

    try {
      await FirebaseStorage.instance
          .ref(reservation.reservationNumber +
              '/' +
              name +
              '-' +
              surname +
              '/' +
              frontOrBack +
              ".png")
          .putFile(image);
    } on FirebaseException catch (e) {
      print("Error");
    }

    try {
      List<String> address = [];
      String base = 'https://10.0.2.2:4455/selfcheckin/authenticate/';
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
            address.add('/');
          });
        });

        if (FirebaseAuth.instance.currentUser != null) {
          userEmail = FirebaseAuth.instance.currentUser!.email;
          await FirebaseFirestore.instance
              .collection('hotel')
              .where('user_name', isEqualTo: reservation.hotelName)
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              address.add(doc["address"]);
              address.add('/');
            });
          });

          address.add(reservation.reservationNumber);
          address.add('/');
          address.add(reservation.reservationNumber);

          String toParse = address.join();
          print(toParse);

          final response = await http.get(Uri.parse(toParse));

          if (response.statusCode == 200) {
            // If the server did return a 200 OK response, selfcheckin/checkin/<user>/<destination>/<reservationNumber>
            // then parse the JSON.
            List<String> address2 = [];
            String base2 = 'https://10.0.2.2:4455/selfcheckin/checkin/';
            address2.add(base2);

            var userEmail;
            if (FirebaseAuth.instance.currentUser != null) {
              userEmail = FirebaseAuth.instance.currentUser!.email;
              await FirebaseFirestore.instance
                  .collection('users')
                  .where('email', isEqualTo: userEmail)
                  .get()
                  .then((QuerySnapshot querySnapshot) {
                querySnapshot.docs.forEach((doc) {
                  address2.add(doc["address"]);
                  address2.add('/');
                });
              });

              if (FirebaseAuth.instance.currentUser != null) {
                userEmail = FirebaseAuth.instance.currentUser!.email;
                await FirebaseFirestore.instance
                    .collection('hotel')
                    .where('user_name', isEqualTo: reservation.hotelName)
                    .get()
                    .then((QuerySnapshot querySnapshot) {
                  querySnapshot.docs.forEach((doc) {
                    address2.add(doc["address"]);
                    address2.add('/');
                  });
                });
              }

              address2.add(reservation.reservationNumber);

              String toParse2 = address2.join();
              print(toParse2);

              final response = await http.get(Uri.parse(toParse2));

              if (response.statusCode == 200) {
                print('check-in done');
              } else {
                // If the server did not return a 200 OK response,
                // then throw an exception.
                print('error');
              }
            } else {
              // If the server did not return a 200 OK response,
              // then throw an exception.
              print('error');
            }
          } else {
            throw Exception('user not connected');
          }
        }
      }
        } on FirebaseException catch (e) {
          print("Error");
    }

  }
}
