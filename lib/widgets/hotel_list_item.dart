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
    return Card(child: NewHotelListItem());
  }

  // ignore: non_constant_identifier_names
  Widget NewHotelListItem() {
    return ListTile(
      leading: const FlutterLogo(size: 72.0),
      title: Text(hotelName),
      subtitle: Text(description),
      isThreeLine: true,
    );
  }
}
