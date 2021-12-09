import 'package:flutter/material.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController _searchControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        fontSize: 15.0,
      ),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20,10,20,10),
        fillColor: Colors.grey.withOpacity(0.1),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blueGrey, width: 1,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: (LanguageLocalizations.of(context).whereyougo + '?'),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.blueAccent,
        ),
        hintStyle: TextStyle(
          fontSize: 15.0,
        ),
      ),
      maxLines: 1,
      controller: _searchControl,
    );
  }
}
