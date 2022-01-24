import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_holidays/util/Global.dart';
import 'package:my_holidays/util/balanceCard.dart';
import 'package:my_holidays/util/reservationNumber.dart';

import 'booking_details.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class Reservation {
  final String email;
  final String dateFrom;
  final String dateUntil;
  final String hotelName;
  final String numberAdult;
  final String numberChild;
  final String reservationNumber;
  final String roomName;
  final String hotelId;
  final String roomId;
  final String price;

  Reservation(
      this.email,
      this.dateFrom,
      this.dateUntil,
      this.hotelName,
      this.numberAdult,
      this.numberChild,
      this.reservationNumber,
      this.roomName,
      this.hotelId,
      this.roomId,
      this.price);
}

class _ReservationScreenState extends State<ReservationScreen> {
  @override
  Widget build(BuildContext context) {
    String? userString = userName();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.all(Radius.circular(75.0)),
                              boxShadow: [
                                BoxShadow(blurRadius: 0.0, color: Colors.black)
                              ]),
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          userString!,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(height: 55.0),
                            IconButton(
                              icon: Icon(Icons.settings),
                              onPressed: () {
                                Navigator.pushNamed(context, 'Profile');
                              },
                              color: getThemeTextColor(context),
                            ),
                            SizedBox(height: 55.0),
                            IconButton(
                              icon: Icon(Icons.refresh),
                              onPressed: () {
                                setState(() {});
                              },
                              color: getThemeTextColor(context),
                            ),
                            SizedBox(width: 2),
                            IconButton(
                              icon: Icon(Icons.logout),
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.pushNamed(context, '/');
                              },
                              color: getThemeTextColor(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "My Bookings",
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child: FutureBuilder<List<Reservation>>(
                            future: getReservationList(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Reservation>> snapshot) {
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
                                  children = <Widget>[
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (ctx, i) {
                                          return GestureDetector(
                                            onTap: () => {
                                              GlobalState.instance.set(
                                                  'reservationHotelName',
                                                  snapshot.data![i].hotelName),
                                              GlobalState.instance.set(
                                                  'reservationHotelDate',
                                                  snapshot.data![i].dateFrom +
                                                      ' - ' +
                                                      snapshot
                                                          .data![i].dateUntil),
                                              Navigator.pushNamed(
                                                  context,
                                                  BookingDetailsScreen
                                                      .routeName,
                                                  arguments: snapshot.data![i],
                                              )},
                                            child: Container(
                                              width: 160,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 11.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                child: Stack(
                                                  children: <Widget>[
                                                    Positioned.fill(
                                                      child: Image.network(
                                                        "https://media-cdn.tripadvisor.com/media/photo-s/16/1a/ea/54/hotel-presidente-4s.jpg",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 0,
                                                      left: 0,
                                                      right: 0,
                                                      child: Container(
                                                        height: 70,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 9.0,
                                                                vertical: 5.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              getThemeButtonColor(
                                                                  context),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    0),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                                snapshot
                                                                    .data![i]
                                                                    .hotelName,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: getThemeTextColor(
                                                                        context))),
                                                            Spacer(),
                                                            Text(
                                                                snapshot
                                                                        .data![
                                                                            i]
                                                                        .dateFrom +
                                                                    ' - ' +
                                                                    snapshot
                                                                        .data![
                                                                            i]
                                                                        .dateUntil,
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
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
      return Colors.white;
    } else {
      return Colors.black;
    }
  }


  Future<List<Reservation>> getReservationList() async {
    List<Reservation> l = [];
    var userEmail;
    if (FirebaseAuth.instance.currentUser != null) {
      userEmail = FirebaseAuth.instance.currentUser!.email;
      await FirebaseFirestore.instance
          .collection('reservation')
          .where('email', isEqualTo: userEmail)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {

          Reservation addToList = Reservation(
              doc['email'],
              doc['hotel_name'],
              doc['room_name'],
              doc['hotel_id'],
              doc['room_id'],
              doc['from'],
              doc['until'],
              doc['numberAdult'].toString(),
              doc['numberChild'].toString(),
              doc.id,
              doc['price']);
          l.add(addToList);
        });
      });

      return l;

    } else {
      throw Exception('user not connected');
    }
  }

  String? userName() {
    if (FirebaseAuth.instance.currentUser == null) {
      return 'null';
    } else {
      return FirebaseAuth.instance.currentUser!.displayName;
    }
  }
}
