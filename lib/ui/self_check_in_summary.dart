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

class SelfCheckInSummary extends StatelessWidget {
  const SelfCheckInSummary({Key? key}) : super(key: key);

  static const routeName = '/selfCheckInSummary';

  @override
  Widget build(BuildContext context) {
    final reservationNumber =
        ModalRoute.of(context)!.settings.arguments as ReservationNumber;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: FutureBuilder<String>(
              future: getGuestNumber(),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('No reservation'),
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
                      Padding(padding: EdgeInsets.only(top: 10)),
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
                                          BorderSide(color: Colors.grey)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          BorderSide(color: Colors.blueAccent)),
                                  labelText:
                                      LanguageLocalizations.of(context).name),
                              controller: nameController.elementAt(i - 1),
                            )),
                            Padding(padding: EdgeInsets.all(15)),
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
                            Padding(padding: EdgeInsets.all(15)),
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
                            Padding(padding: EdgeInsets.only(top: 10)),
                          ],
                        ),
                      Padding(padding: EdgeInsets.only(top: 10)),
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
                                      reservationNumber.reservationNumber,
                                      documents.elementAt(i - 1).name,
                                      documents.elementAt(i - 1).surname,
                                      "front");
                                  uploadImageToFirebase(
                                      context,
                                      documents.elementAt(i - 1).back.path,
                                      reservationNumber.reservationNumber,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Non hai fatto la login'),
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

  Future<String> getGuestNumber() async {
    List<Reservation> l = [];

    await FirebaseFirestore.instance
        .collection('reservation')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

        Reservation addToList = Reservation(
            data['email'],
            data['hotel_name'],
            data['room_name'],
            data['hotel_id'],
            data['room_id'],
            data['from'],
            data['until'],
            data['numberAdult'],
            data['numberChild'],
            doc.id,
            data['price']);
        l.add(addToList);
      });
    });

    String nAdult = l.elementAt(0).numberAdult.toString();
    String nChild = l.elementAt(0).numberChild.toString();
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
      String reservationNumber,
      String name,
      String surname,
      String frontOrBack) async {
    File image = File(imagePath);
    FirebaseStorage storage = FirebaseStorage.instance;

    try {
      await FirebaseStorage.instance
          .ref(reservationNumber +
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
  }
}
