import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_holidays/ui/settings_screen.dart';
import 'package:my_holidays/util/Global.dart';

import 'booking_details.dart';
import 'login_screen.dart';


class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();

}

class Reservation {
  late String email;
  late String username;
  late String dateFrom;
  late String dateUntil;
  late String hotel_name;
  late String numberAdult;
  late String numberChild;

  Reservation(this.email, this.username, this.dateFrom, this.dateUntil,
      this.hotel_name, this.numberAdult, this.numberChild);

}

class _ReservationScreenState extends State<ReservationScreen>{

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
                    Spacer(),
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
                        Row (
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget> [
                            SizedBox(height: 55.0),
                            IconButton(
                              icon: Icon(Icons.settings),
                              onPressed: () {
                                Navigator.pushNamed(context, 'Settings');
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
                    Spacer(),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Loyalty Card",
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 50.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 100.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "3191\t",
                                      style: TextStyle(
                                        color: Colors.yellowAccent,
                                        fontSize: 30,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Felix points",
                                      style: TextStyle(
                                          color: Colors.yellowAccent
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 35.0,
                            ),
                            Container(
                              padding: const EdgeInsets.all(25.0),
                              color: Colors.yellowAccent,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "My next trip",
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                              DefaultTextStyle(
                                style: Theme.of(context).textTheme.headline2!,
                                textAlign: TextAlign.center,
                                child: FutureBuilder<String>(
                                  future: myNextTrip(), // a previously-obtained Future<String> or null
                                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                    List<Widget> children;
                                    if (snapshot.hasData) {
                                      children = <Widget>[
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${snapshot.data}',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ];
                                    } else if (snapshot.hasError) {
                                      children = <Widget>[
                                        Text('Non hai fatto la login',
                                          style: TextStyle(
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ];
                                    } else {
                                      children = const <Widget>[
                                        Text('Awaiting result...',
                                          style: TextStyle(
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat'
                                          ),
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
                              )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
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
                        builder: (BuildContext context, AsyncSnapshot<List<Reservation>> snapshot) {
                          List<Widget> children;
                          if (snapshot.hasData){
                            if(snapshot.data!.isEmpty){
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
                            }else {
                              children = <Widget>[
                                SizedBox(
                                  height: MediaQuery.of(context).size.height / 4,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (ctx, i) {
                                      return GestureDetector(
                                        onTap: () => {
                                          GlobalState.instance.set('reservationHotelName', snapshot.data![i].hotel_name),
                                          GlobalState.instance.set('reservationHotelDate', snapshot.data![i].dateFrom + ' - ' + snapshot.data![i].dateUntil),
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx) => BookingDetailsScreen(),),),
                                        },
                                        child: Container(
                                          width: 160,
                                          margin:
                                          const EdgeInsets.symmetric(horizontal: 11.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(15.0),
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
                                                    padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 5.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.lightBlue,
                                                      borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(15),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Text(
                                                            snapshot.data![i].hotel_name,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.white)
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                            snapshot.data![i].dateFrom + ' - ' + snapshot.data![i].dateUntil,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.white)
                                                        ),
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
                        }
                      )
                    ),
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
    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    if (isDarkMode){
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  Color getThemeButtonColor(BuildContext context){
    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    if (!isDarkMode){
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

    Future<List<Reservation>> getReservationList() async {

      List<Reservation> l = [];

      await FirebaseFirestore.instance
          .collection('reservation')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

          Reservation addToList = Reservation(data['email'], data['full_name'], data['from'],
              data['until'], data['hotel_name'], data['numberAdult'].toString(), data['numberChild'].toString());
          l.add(addToList);
        });
      });

      return l;

    }

  Future<String> myNextTrip() async {

    final dateTime = <String>[];

    await FirebaseFirestore.instance
        .collection('reservation')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
        dateTime.add(data['from']);
      });
    });

    dateTime.sort((a,b) => a.compareTo(b));

    DateFormat format = DateFormat('dd/MM/yyyy');
    DateTime now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    String formatted = format.format(now);

    var nowFormatted = DateFormat('dd/MM/yyyy').parse(formatted);

    int index = -1;

    for (int i = 0; i < dateTime.length; i++) {
      var df2 = DateFormat('dd/MM/yyyy').parse(dateTime[i]);
      if(nowFormatted.isBefore(df2) == true){
        index = i;
        break;
      }
    }

    if (index < 0){
      return 'errore';
    }else{
      return dateTime[index];
    }

  }

  String? userName (){

    if(FirebaseAuth.instance.currentUser == null){
      return 'null';
    }else{
      return FirebaseAuth.instance.currentUser!.displayName;
    }
  }


}
