import 'package:flutter/material.dart';

class HotelListItem extends StatelessWidget {
  final String hotelName;
  final String description;

  const HotelListItem({
    Key? key,
    required this.hotelName,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: NewHotelListItem());
  }

  Widget NewHotelListItem() {
    return ListTile(
      leading: FlutterLogo(size: 72.0),
      title: Text(hotelName),
      subtitle: Text(description),
      isThreeLine: true,
    );
  }
}
