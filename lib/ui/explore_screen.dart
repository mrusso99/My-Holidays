import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_holidays/ui/hotel_item.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

/// This is the private State class that goes with MainScreen.
class _ExploreScreenState extends State<ExploreScreen> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HotelItem());
  }
}
