import 'package:flutter/material.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/ui/reservation_screen.dart';
import 'package:my_holidays/ui/self_check_in_summary.dart';
import 'package:my_holidays/util/colors.dart';
import 'package:my_holidays/util/places.dart';
import 'package:my_holidays/util/reservationNumber.dart';
import 'package:my_holidays/widgets/rounded_button.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/bookingDetails';

  @override
  Widget build(BuildContext context) {
    final reservation =
        ModalRoute.of(context)!.settings.arguments as Reservation;
    int id = 0;
    return Scaffold(
        body: SafeArea(
      child: Row(children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 5,
                      top: 5,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, top: 80),
                      height: 400.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        primary: false,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          Map place = places[index];

                          return Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                "${place["img"]}",
                                height: 250.0,
                                width: MediaQuery.of(context).size.width - 40.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${places[id]['name']}",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      reservation.dateFrom.toString() +
                          " - " +
                          reservation.dateUntil.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "351€",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              "2 notti",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: CircularProgressIndicator(
                                  value: .25,
                                  backgroundColor: Colors.lightBlue,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.brightness_3,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 150,
                            child: RoundedButton(
                                text: LanguageLocalizations.of(context)
                                    .roomControl,
                                color: Colors.blueAccent,
                                customOnPressed: () =>
                                    Navigator.pushNamed(context, 'SmartRoom'))),
                        Padding(padding: EdgeInsets.all(15)),
                        SizedBox(
                            width: 150,
                            child: RoundedButton(
                                text: LanguageLocalizations.of(context)
                                    .SmartServices,
                                color: Colors.blueAccent,
                                customOnPressed: () => Navigator.pushNamed(
                                    context, 'SmartServices'))),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 150,
                            child: RoundedButton(
                                text: "Check In",
                                color: Colors.blueAccent,
                                customOnPressed: () => {
                                      Navigator.pushNamed(
                                          context, SelfCheckInSummary.routeName,
                                          arguments: ReservationNumber(
                                              reservation.reservationNumber))
                                    })),
                        Padding(padding: EdgeInsets.all(15)),
                        SizedBox(
                            width: 150,
                            child: RoundedButton(
                                text: LanguageLocalizations.of(context).cancel,
                                color: Colors.blueAccent,
                                customOnPressed: () => {})),
                      ],
                    )
                  ],
                ),
              )),
            ],
          ),
        )
      ]),
    ));
  }
}

Color getThemeButtonColor(BuildContext context) {
  bool isDarkMode =
      MediaQuery.of(context).platformBrightness == Brightness.dark;

  if (!isDarkMode) {
    return Colors.white;
  } else {
    return Colors.black;
  }
}

getThemeTextColor(BuildContext context) {
  bool isDarkMode =
      MediaQuery.of(context).platformBrightness == Brightness.dark;

  if (!isDarkMode) {
    return Colors.white;
  } else {
    return Colors.black;
  }
}
